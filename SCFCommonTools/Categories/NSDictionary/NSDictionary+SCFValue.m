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

- (NSDictionary *)scf_dictionaryObjectForKey:(NSString *)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSDictionary class]] ? object : nil;
}

- (NSArray *)scf_arrayObjectForKey:(NSString *)aKey {
    id object = [self objectForKey:aKey];
    return [object isKindOfClass:[NSArray class]] ? object : nil;
}

- (NSArray *)scf_arrayStringForKey:(NSString *)aKey {
    NSArray *array = [self scf_arrayObjectForKey:aKey];
    BOOL invalid = NO;
    for (id item in array)     {
        if (![item isKindOfClass:[NSString class]])         {
            invalid = YES;
        }
    }
    return invalid ? nil : array;
}

- (NSString *)scf_stringForKey:(NSString *)aKey defaultValue:(NSString *)defaultValue {
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSString class]]) {
        return object;
    }
    else if([object isKindOfClass:[NSNumber class]]) {
        return [object stringValue];
    }
    return defaultValue;
}

- (NSString *)scf_stringForKey:(NSString *)aKey {
    return [self scf_stringForKey:aKey defaultValue:@""];
}

- (NSString *)scf_numberStringForKey:(NSString *)aKey {
    return [self scf_stringForKey:aKey defaultValue:@"0"];
}

- (NSString *)scf_stringByReplaceNBSPForKey:(NSString *)aKey {
    NSString *value = [self scf_stringForKey:aKey];
    NSString *str = [value stringByReplacingOccurrencesOfString:@"&nbsp" withString:@" "];
    return str;
}

@end
