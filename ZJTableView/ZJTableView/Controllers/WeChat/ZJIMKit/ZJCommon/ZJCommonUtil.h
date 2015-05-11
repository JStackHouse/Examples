//
//  ZJCommonUtil.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/30.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJCommonUtil : NSObject

#pragma mark - Time Related
//当前时间
+ (NSString *)currentDateString;

//NSdate转NSString
+ (NSString *)dateStringFromDate:(NSDate *)date;

//NSString转NSdate
+ (NSDate *)dateFromString:(NSString *)dateString;


//比较两个时间的时间差
+ (NSTimeInterval)timeIntervalFromDateString:(NSString *)fromDateString toDateString:(NSString *)toDateString;

@end
