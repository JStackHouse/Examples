//
//  ZJCommonUtil.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/30.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJCommonUtil.h"

@implementation ZJCommonUtil


#pragma mark - Time Related
//当前时间
+ (NSString *)currentDateString
{
    NSString *current = [self dateStringFromDate:[NSDate date]];
    return current;
}

//NSdate转NSString
+ (NSString *)dateStringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

//NSString转NSdate
+ (NSDate *)dateFromString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:dateString];
}


//比较两个时间的时间差
+ (NSTimeInterval)timeIntervalFromDateString:(NSString *)fromDateString toDateString:(NSString *)toDateString
{
    NSDate *frameDate = [self dateFromString:fromDateString];
    NSDate *toDate = [self dateFromString:toDateString];
    
    return [frameDate timeIntervalSinceDate:toDate];
}


@end
