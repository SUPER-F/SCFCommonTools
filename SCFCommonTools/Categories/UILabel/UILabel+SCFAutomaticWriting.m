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

static inline void scf_AutomaticWritingSwizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
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
        scf_AutomaticWritingSwizzleSelector([self class],
                                            @selector(textRectForBounds:limitedToNumberOfLines:),
                                            @selector(scf_automaticWritingTextRectForBounds:limitedToNumberOfLines:));
        scf_AutomaticWritingSwizzleSelector([self class],
                                            @selector(drawTextInRect:),
                                            @selector(scf_automaticWritingDrawTextInRect:));
    });
}

- (void)scf_automaticWritingDrawTextInRect:(CGRect)rect {
    [ self scf_automaticWritingDrawTextInRect:UIEdgeInsetsInsetRect(rect, self.scf_edgeInsets)];
}

- (CGRect)scf_automaticWritingTextRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [self scf_automaticWritingTextRectForBounds:UIEdgeInsetsInsetRect(bounds, self.scf_edgeInsets) limitedToNumberOfLines:numberOfLines];
    return textRect;
}

- (void)scf_setTextWithAutomaticWritingAnimation:(NSString *)text {
    [self scf_setText:text automaticWritingAnimationWithBlinkingMode:UILabelSCFlinkingModeNone];
}

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithBlinkingMode:(UILabelSCFlinkingMode)blinkingMode {
    [self scf_setText:text automaticWritingAnimationWithDuration:UILabelAWDefaultDuration blinkingMode:blinkingMode];
}

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration {
    [self scf_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:UILabelSCFlinkingModeNone];
}

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode {
    [self scf_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:UILabelAWDefaultCharacter];
}

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter {
    [self scf_setText:text automaticWritingAnimationWithDuration:duration blinkingMode:blinkingMode blinkingCharacter:blinkingCharacter completion:nil];
}

- (void)scf_setText:(NSString *)text automaticWritingAnimationWithDuration:(NSTimeInterval)duration blinkingMode:(UILabelSCFlinkingMode)blinkingMode blinkingCharacter:(unichar)blinkingCharacter completion:(void (^)(void))completion {
    
    self.scf_automaticWritingOperationQueue.suspended = YES;
    self.scf_automaticWritingOperationQueue = nil;
    
    self.text = @"";
    
    NSMutableString *automaticWritingText = NSMutableString.new;
    if (text) {
        [automaticWritingText appendString:text];
    }
    
    [self.scf_automaticWritingOperationQueue addOperationWithBlock:^{
        
    }];
}

#pragma mark - private methods
- (void)scf_automaticWriting:(NSMutableString *)text duration:(NSTimeInterval)duration mode:(UILabelSCFlinkingMode)mode character:(unichar)character completion:(void (^)(void))completion {
    
    NSOperationQueue *currentQueue = NSOperationQueue.currentQueue;
    if ((text.length || mode >= UILabelSCFlinkingModeWhenFinish) && !currentQueue.isSuspended) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (mode != UILabelSCFlinkingModeNone) {
                if ([self scf_isLastCharacter:character]) {
                    [self scf_deleteLastCharacter];
                }
                else if (mode != UILabelSCFlinkingModeWhenFinish || !text.length) {
                    [text insertString:[self scf_stringWithCharacter:character] atIndex:0];
                }
            }
            
            if (text.length) {
                [self scf_appendCharacter:[text characterAtIndex:0]];
                [text deleteCharactersInRange:NSMakeRange(0, 1)];
                if ((![self scf_isLastCharacter:character] && mode == UILabelSCFlinkingModeWhenFinishShowing)
                     || (!text.length && mode == UILabelSCFlinkingModeUntilFinishKeeping)) {
                    [self scf_appendCharacter:character];
                }
            }
            
            if (!currentQueue.isSuspended) {
                [currentQueue addOperationWithBlock:^{
                    [self scf_automaticWriting:text duration:duration mode:mode character:character completion:completion];
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

- (NSString *)scf_stringWithCharacter:(unichar)character {
    return [self scf_stringWithCharacters:@[@(character)]];
}

- (NSString *)scf_stringWithCharacters:(NSArray *)characters {
    NSMutableString *string = NSMutableString.new;
    for (NSNumber *character in characters) {
        [string appendFormat:@"%c", character.unsignedShortValue];
    }
    
    return string.copy;
}

- (void)scf_appendCharacter:(unichar)character {
    [self scf_appendCharacters:@[@(character)]];
}

- (void)scf_appendCharacters:(NSArray *)characters {
    self.text = [self.text stringByAppendingString:[self scf_stringWithCharacters:characters]];
}

- (BOOL)scf_isLastCharacter:(unichar)character {
    return [self scf_isLastCharacters:@[@(character)]];
}

- (BOOL)scf_isLastCharacters:(NSArray *)characters {
    if (self.text.length >= characters.count) {
        return [self.text hasSuffix:[self scf_stringWithCharacters:characters]];
    }
    
    return NO;
}

- (BOOL)scf_deleteLastCharacter {
    return [self scf_deleteLastCharacters:1];
}

- (BOOL)scf_deleteLastCharacters:(NSUInteger)characters {
    if (self.text.length >= characters) {
        self.text = [self.text substringToIndex:self.text.length - characters];
        return YES;
    }
    
    return NO;
}

#pragma mark - setters / getters
#pragma mark scf_edgeInsets
- (void)setScf_edgeInsets:(UIEdgeInsets)scf_edgeInsets {
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, [NSValue valueWithUIEdgeInsets:scf_edgeInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)scf_edgeInsets {
    NSValue *edgeInsetsValue = objc_getAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey);
    if (edgeInsetsValue) {
        return edgeInsetsValue.UIEdgeInsetsValue;
    }
    
    edgeInsetsValue = [NSValue valueWithUIEdgeInsets:UIEdgeInsetsZero];
    objc_setAssociatedObject(self, &kAutomaticWritingEdgeInsetsKey, edgeInsetsValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return edgeInsetsValue.UIEdgeInsetsValue;
}

#pragma mark scf_automaticWritingOperationQueue
- (void)setScf_automaticWritingOperationQueue:(NSOperationQueue *)scf_automaticWritingOperationQueue {
    objc_setAssociatedObject(self, &kAutomaticWritingOperationQueueKey, scf_automaticWritingOperationQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSOperationQueue *)scf_automaticWritingOperationQueue {
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
