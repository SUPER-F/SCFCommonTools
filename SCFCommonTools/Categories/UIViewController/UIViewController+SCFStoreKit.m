//
//  UIViewController+SCFStoreKit.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/2.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "UIViewController+SCFStoreKit.h"
#import <objc/runtime.h>

static NSString *const affiliateTokenKey = @"affiliateTokenKey";
static NSString *const campaignTokenKey = @"campaignTokenKey";
static NSString *const loadingStoreKitItemBlockKey = @"loadingStoreKitItemBlockKey";
static NSString *const loadedStoreKitItemBlockKey = @"loadedStoreKitItemBlockKey";
static NSString *const iTunesAppleString = @"itunes.apple.com";

@implementation UIViewController (SCFStoreKit)

#pragma mark - public methods
+ (BOOL)isContainsAppUrlHostWithUrlString:(NSString *)urlString {
    return ([urlString rangeOfString:iTunesAppleString].location != NSNotFound);
}

+ (NSString *)getAppIDWithUrlString:(NSString *)urlString {
    NSError *error;
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"id\\d+" options:0 error:&error];
    NSTextCheckingResult *result = [regExp firstMatchInString:urlString options:0 range:NSMakeRange(0, urlString.length)];
    
    NSString *idString = [urlString substringWithRange:result.range];
    if (idString.length > 0) {
        idString = [idString stringByReplacingOccurrencesOfString:@"id" withString:@""];
    }
    
    return idString;
}

+ (NSURL *)getAppUrlWithIdentifier:(NSString *)identifier {
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", identifier];
    return [NSURL URLWithString:urlString];
}

+ (void)openAppUrlWithIdentifier:(NSString *)identifier {
    NSString *appUrlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrlString]];
}

+ (void)openAppReviewUrlWithIdentifier:(NSString *)identifier {
    NSString *reviewUrlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewUrlString]];
}

- (void)presentStoreViewControllerWithIdentifier:(NSString *)identifier {
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;
    
    NSString *campaignToken = self.campaignToken ? self.campaignToken : @"";
    
    NSDictionary *parameters = @{SKStoreProductParameterITunesItemIdentifier : identifier,
                                 affiliateTokenKey : kAffiliateToken,
                                 campaignTokenKey : campaignToken,
                                 };
    
    if (self.loadingStoreKitItemBlock) {
        self.loadingStoreKitItemBlock();
    }
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (self.loadedStoreKitItemBlock) {
            self.loadedStoreKitItemBlock();
        }
        
        if (result && !error) {
            [self presentViewController:storeViewController animated:YES completion:nil];
        }
    }];
}

#pragma mark - SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setters / getters
- (void)setCampaignToken:(NSString *)campaignToken {
    objc_setAssociatedObject(self,
                             &campaignTokenKey,
                             campaignToken,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)campaignToken {
    return objc_getAssociatedObject(self, &campaignTokenKey);
}

- (void)setLoadingStoreKitItemBlock:(void (^)(void))loadingStoreKitItemBlock {
    objc_setAssociatedObject(self,
                             &loadingStoreKitItemBlockKey,
                             loadingStoreKitItemBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))loadingStoreKitItemBlock {
    return objc_getAssociatedObject(self, &loadingStoreKitItemBlockKey);
}

- (void)setLoadedStoreKitItemBlock:(void (^)(void))loadedStoreKitItemBlock {
    objc_setAssociatedObject(self,
                             &loadedStoreKitItemBlockKey,
                             loadedStoreKitItemBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))loadedStoreKitItemBlock {
    return objc_getAssociatedObject(self, &loadedStoreKitItemBlockKey);
}

@end
