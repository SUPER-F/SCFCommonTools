//
//  UIViewController+SCFStoreKit.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/2.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

#define kAffiliateToken @"10laQX"

@interface UIViewController (SCFStoreKit) <SKStoreProductViewControllerDelegate>

@property (nonatomic, copy) NSString *campaignToken;
@property (nonatomic, copy) void (^loadingStoreKitItemBlock)(void);
@property (nonatomic, copy) void (^loadedStoreKitItemBlock)(void);

/**
 判断连接中是否包含APP主机名

 @param urlString URL
 @return 是否包含
 */
+ (BOOL)isContainsAppUrlHostWithUrlString:(NSString *)urlString;

/**
 获取APP的ID

 @param urlString APP的URL
 @return APP的ID
 */
+ (NSString *)getAppIDWithUrlString:(NSString *)urlString;

/**
 获取APP的URL

 @param identifier APP的ID
 @return APP的URL
 */
+ (NSURL *)getAppUrlWithIdentifier:(NSString *)identifier;


/**
 打开APP的URL

 @param identifier APP的ID
 */
+ (void)openAppUrlWithIdentifier:(NSString *)identifier;


/**
 打开APP的review URL

 @param identifier APP的ID
 */
+ (void)openAppReviewUrlWithIdentifier:(NSString *)identifier;

/**
 模态到APP商店页面
 
 @param identifier APP的ID
 */
- (void)presentStoreViewControllerWithIdentifier:(NSString *)identifier;

@end
