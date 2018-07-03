//
//  NSDate+SCFFormatter.h
//  SCFCommonTools
//
//  Created by scf on 2018/7/3.
//  Copyright © 2018年 scf. All rights reserved.
//
//  github: https://github.com/SUPER-F/SCFCommonTools
//
//  原代码: http://schwiiz.org/
//

#import <Foundation/Foundation.h>

@interface NSDate (SCFFormatter)

+ (NSDateFormatter *)formatter;
+ (NSDateFormatter *)formatterWithoutTime;
+ (NSDateFormatter *)formatterWithoutDate;

- (NSString *)formatWithUTCTimeZone;
- (NSString *)formatWithLocalTimeZone;
- (NSString *)formatWithTimeZoneOffset:(NSTimeInterval)offset;
- (NSString *)formatWithTimeZone:(NSTimeZone *)timezone;

- (NSString *)formatWithUTCTimeZoneWithoutTime;
- (NSString *)formatWithLocalTimeZoneWithoutTime;
- (NSString *)formatWithTimeZoneOffsetWithoutTime:(NSTimeInterval)offset;
- (NSString *)formatWithTimeZoneWithoutTime:(NSTimeZone *)timezone;

- (NSString *)formatWithUTCWithoutDate;
- (NSString *)formatWithLocalTimeWithoutDate;
- (NSString *)formatWithTimeZoneOffsetWithoutDate:(NSTimeInterval)offset;
- (NSString *)formatTimeWithTimeZone:(NSTimeZone *)timezone;


+ (NSString *)currentDateStringWithFormat:(NSString *)format;
+ (NSDate *)dateWithSecondsFromNow:(NSInteger)seconds;
+ (NSDate *)dateWithYear:(NSInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSString *)dateStringWithFormat:(NSString *)format;

@end
