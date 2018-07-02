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

static NSString *const scf_affiliateTokenKey = @"scf_affiliateTokenKey";
static NSString *const scf_campaignTokenKey = @"scf_campaignTokenKey";
static NSString *const scf_loadingStoreKitItemBlockKey = @"scf_loadingStoreKitItemBlockKey";
static NSString *const scf_loadedStoreKitItemBlockKey = @"scf_loadedStoreKitItemBlockKey";
static NSString *const scf_iTunesAppleString = @"itunes.apple.com";

@implementation UIViewController (SCFStoreKit)

#pragma mark - public methods
+ (BOOL)scf_isContainsAppUrlHostWithUrlString:(NSString *)urlString {
    return ([urlString rangeOfString:scf_iTunesAppleString].location != NSNotFound);
}

+ (NSString *)scf_getAppIDWithUrlString:(NSString *)urlString {
    NSError *error;
    NSRegularExpression *regExp = [NSRegularExpression regularExpressionWithPattern:@"id\\d+" options:0 error:&error];
    NSTextCheckingResult *result = [regExp firstMatchInString:urlString options:0 range:NSMakeRange(0, urlString.length)];
    
    NSString *idString = [urlString substringWithRange:result.range];
    if (idString.length > 0) {
        idString = [idString stringByReplacingOccurrencesOfString:@"id" withString:@""];
    }
    
    return idString;
}

+ (NSURL *)scf_getAppUrlWithIdentifier:(NSString *)identifier {
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/app/id%@", identifier];
    return [NSURL URLWithString:urlString];
}

+ (void)scf_openAppUrlWithIdentifier:(NSString *)identifier {
    NSString *appUrlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appUrlString]];
}

+ (void)scf_openAppReviewUrlWithIdentifier:(NSString *)identifier {
    NSString *reviewUrlString = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", identifier];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:reviewUrlString]];
}

- (void)scf_presentStoreViewControllerWithIdentifier:(NSString *)identifier {
    SKStoreProductViewController *storeViewController = [[SKStoreProductViewController alloc] init];
    storeViewController.delegate = self;
    
    NSString *campaignToken = self.scf_campaignToken ? self.scf_campaignToken : @"";
    
    NSDictionary *parameters = @{SKStoreProductParameterITunesItemIdentifier : identifier,
                                 scf_affiliateTokenKey : kAffiliateToken,
                                 scf_campaignTokenKey : campaignToken,
                                 };
    
    if (self.scf_loadingStoreKitItemBlock) {
        self.scf_loadingStoreKitItemBlock();
    }
    [storeViewController loadProductWithParameters:parameters completionBlock:^(BOOL result, NSError * _Nullable error) {
        if (self.scf_loadedStoreKitItemBlock) {
            self.scf_loadedStoreKitItemBlock();
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
- (void)setScf_campaignToken:(NSString *)scf_campaignToken {
    objc_setAssociatedObject(self,
                             &scf_campaignTokenKey,
                             scf_campaignToken,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)scf_campaignToken {
    return objc_getAssociatedObject(self, &scf_campaignTokenKey);
}

- (void)setScf_loadingStoreKitItemBlock:(void (^)(void))scf_loadingStoreKitItemBlock {
    objc_setAssociatedObject(self,
                             &scf_loadingStoreKitItemBlockKey,
                             scf_loadingStoreKitItemBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))scf_loadingStoreKitItemBlock {
    return objc_getAssociatedObject(self, &scf_loadingStoreKitItemBlockKey);
}

- (void)setScf_loadedStoreKitItemBlock:(void (^)(void))scf_loadedStoreKitItemBlock {
    objc_setAssociatedObject(self,
                             &scf_loadedStoreKitItemBlockKey,
                             scf_loadedStoreKitItemBlock,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))scf_loadedStoreKitItemBlock {
    return objc_getAssociatedObject(self, &scf_loadedStoreKitItemBlockKey);
}

@end
