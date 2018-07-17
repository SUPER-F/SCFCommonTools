//
//  UILabel+SCFAutomaticWriting.m
//  SCFCommonTools
//
//  Created by scf on 2018/6/27.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UILabel+SCFAutomaticWriting.h"
#import <objc/runtime.h>

NSTimeInterval const UILabelAWDefaultDuration = 0.4f;
unichar const UILabelAWDefaultCharacter = 124;

static inline void AutomaticWritingSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static char kAutomaticWritingOperationQueueKey;
static char kAutomaticWritingEdgeInsetsKey;

@implementation UILabel (SCFAutomaticWriting)

#pragma mark - public methods
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AutomaticWritingSwizzleSelector([self class],
                                            @selector(textRectForBounds:limitedToNumberOfLines:),
                                            @selector(automaticWritingTextRectForBounds:limitedToNumberOfLines:));
        AutomaticWritingSwizzleSelector([self class],
                                            @selector(drawTextInRect:),
                                            @selector(automaticWritingDrawTextInRect:));
    });
}

- (void)automaticWritingDrawTextInRect:(CGRect)rect {
    [ self automaticWritingDrawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (CGRect)automaticWritingTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [self automaticWritingTextRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets) limitedToNumberOfLines:numberOfLines];
    return textRect;
}

- (void)setTextWithAutomaticWritingAnimation:(NSString *)text {
    [self setText:text automaticWritingAnimationWithBlinkingMode:UILabelSCFlinkingModeNone];
}

- (void)setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelSCFlinkingMode)blinkingMode {
    [self setText:text automaticWritingAnimationWithDuration:UILabelAWDefaultDuration blinkingMode:blinkingMode];
}

- (void)setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration {
    [self setText:text automaticWritingAnimationWithDuration:duration blinkingMode:UILabelSCFlinkingModeNone];
}

- (void)setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode {
    [self setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:UILabelAWDefaultCharacter];
}

- (void)setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter {
    [self setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:blinkingCharacter completion:nil];
}

- (void)setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion {
    
    self.automaticWritingOperationQueue.suspended = YES;
    self.automaticWritingOperationQueue = nil;
    
    self.text = @"";
    
    NSMutableString *automaticWritingText = NSMutableString.new;
    if (text) {
        [automaticWritingText appendString:text];
    }
    
    [self.automaticWritingOperationQueue addOperationWithBlock:^{
        
    }];
}

#pragma mark - private methods
- (void)automaticWriting:(NSMutableString *)text duration:(NSTimeInterval)duration mode:(UILabelSCFlinkingMode)mode character:(unichar)character completion:(void (^)(void))completion {
    
    NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
    if ((text.length || mode >= UILabelSCFlinkingModeWhenFinish) && !currentQueue.isSuspended) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (mode != UILabelSCFlinkingModeNone) {
                if ([self isLastCharacter:character]) {
                    [self deleteLastCharacter];
                }
                else if (mode != UILabelSCFlinkingModeWhenFinish || !text.length) {
                    [text insertString:[self stringWithCharacter:character] atIndex:0];
                }
            }
            
            if (text.length) {
                [self appendCharacter:[text characterAtIndex:0]];
                [text deleteCharactersInRange:NSMakeRange(0, 1)];
                if ((![self isLastCharacter:character] && mode == UILabelSCFlinkingModeWhenFinishShowing)
                     || (!text.length && mode == UILabelSCFlinkingModeUntilFinishKeeping)) {
                    [self appendCharacter:character];
                }
            }
            
            if (!currentQueue.isSuspended) {
                [currentQueue addOperationWithBlock:^{
                    [self automaticWriting:text duration:duration mode:mode character:character completion:completion];
                }];
            }
            else if (completion) {
                completion();
            }
        });
    }
    else if (completion) {
        completion();
    }
}

- (NSString *)stringWithCharacter:(unichar)character {
    return [self stringWithCharacters:@[@(character)]];
}

- (NSString *)stringWithCharacters:(NSArray *)characters {
    NSMutableString *string = NSMutableString.new;
    for (NSNumber *character in characters) {
        [string appendFormat:@"%c", character.unsignedShortValue];
    }
    
    return string.copy;
}

- (void)appendCharacter:(unichar)character {
    [self appendCharacters:@[@(character)]];
}

- (void)appendCharacters:(NSArray *)characters {
    self.text = [self.text stringByAppendingString:[self stringWithCharacters:characters]];
}

- (BOOL)isLastCharacter:(unichar)character {
    return [self isLastCharacters:@[@(character)]];
}

- (BOOL)isLastCharacters:(NSArray *)characters {
    if (self.text.length >= characters.count) {
        return [self.text hasSuffix:[self stringWithCharacters:characters]];
    }
    
    return NO;
}

- (BOOL)deleteLastCharacter {
    return [self deleteLastCharacters:1];
}

- (BOOL)deleteLastCharacters:(NSUInteger)characters {
    if (self.text.length >= characters) {
        self.text = [self.text substringToIndex:self.text.length - characters];
        return YES;
    }
    
    return NO;
}

#pragma mark - setters / getters
#pragma mark edgeInsets
- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, [NSValue valueWithUIEdgeInsets:edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)edgeInsets {
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey);
    if (edgeInsetsValue) {
        return edgeInsetsValue.UIEdgeInsetsValue;
    }
    
    edgeInsetsValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, edgeInsetsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return edgeInsetsValue.UIEdgeInsetsValue;
}

#pragma mark automaticWritingOperationQueue
- (void)setAutomaticWritingOperationQueue:(NSOperationQueue *)automaticWritingOperationQueue {
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, automaticWritingOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)automaticWritingOperationQueue {
    NSOperationQueue *operationQueue = objc_getAssociatedObject(self, &kAutomaticWritingOperationQueueKey);
    if (operationQueue) {
        return operationQueue;
    }
    
    operationQueue = NSOperationQueue.new;
    operationQueue.name = @"Automatic Writing Operation Queue";
    operationQueue.maxConcurrentOperationCount = 1;
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, operationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return operationQueue;
}

@end
