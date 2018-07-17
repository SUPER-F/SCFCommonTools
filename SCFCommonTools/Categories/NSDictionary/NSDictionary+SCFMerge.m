//
//  NSString+SCFMerge.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSDictionary+SCFMerge.h"

@implementation NSDictionary (SCFMerge)

+ (NSDictionary *)dictionaryByMergingDictionary:(NSDictionary *)dict1
                                     withDictionary:(NSDictionary *)dict2 {
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:dict1];
    NSMutableDictionary *tempResult = [NSMutableDictionary dictionaryWithDictionary:dict1];
    [tempResult addEntriesFromDictionary:dict2];
    
    [tempResult enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([dict1 objectForKey:key]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *newDic = [[dict1 objectForKey:key] dictionaryByMergingDictionary:(NSDictionary *)obj];
                [result setObject:newDic forKey:key];
            }
            else {
                [result setObject:obj forKey:key];
            }
        }
        else if ([dict2 objectForKey:key]) {
            if ([obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *newDic = [[dict2 objectForKey:key] dictionaryByMergingDictionary:(NSDictionary *)obj];
                [result setObject:newDic forKey:key];
            }
            else {
                [result setObject:obj forKey:key];
            }
        }
    }];
    
    return result.copy;
}

- (NSDictionary *)dictionaryByMergingDictionary:(NSDictionary *)dict {
    return [NSDictionary dictionaryByMergingDictionary:self withDictionary:dict];
}

@end
