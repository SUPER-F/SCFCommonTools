//
//  NSString+SCFValue.m
//  SCFCommonTools
//
//  Created by scf on 2018/7/5.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//

#import "NSDictionary+SCFValue.h"

@implementation NSDictionary (SCFValue)

- (NSDictionary *)dictionaryObjectForKey:(NSString *)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSDictionary class]] ? object : nil;
}

- (NSArray *)arrayObjectForKey:(NSString *)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSArray class]] ? object : nil;
}

- (NSArray *)arrayStringForKey:(NSString *)aKey {
    NSArray *array = [self arrayObjectForKey:aKey];
    BOOL invalid = NO;
    for (id item in array)     {
        if (![item isKindOfClass:[NSString class]])         {
            invalid = YES;
        }
    }
    return invalid ? nil : array;
}

- (NSString *)stringForKey:(NSString *)aKey defaultValue:(NSString *)defaultValue {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    else if([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }
    return defaultValue;
}

- (NSString *)stringForKey:(NSString *)aKey {
    return [self stringForKey:aKey defaultValue:@""];
}

- (NSString *)numberStringForKey:(NSString *)aKey {
    return [self stringForKey:aKey defaultValue:@"0"];
}

- (NSString *)stringByReplaceNBSPForKey:(NSString *)aKey {
    NSString *value = [self stringForKey:aKey];
    NSString *str = [value stringByReplacingOccurrencesOfString:@"&nbsp" withString:@" "];
    return str;
}

@end
