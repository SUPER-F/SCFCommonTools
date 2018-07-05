//
//  NSString+SCFMerge.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SCFMerge)

// 合并两个NSDictionary
+ (NSDictionary *)scf_dictionaryByMergingDictionary:(NSDictionary *)dict1
                                     withDictionary:(NSDictionary *)dict2;

// 并入一个NSDictionary
- (NSDictionary *)scf_dictionaryByMergingDictionary:(NSDictionary *)dict;

@end
