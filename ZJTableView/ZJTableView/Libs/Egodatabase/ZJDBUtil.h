//
//  ZJDBUtil.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/14.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDBModelDefine.h"

@interface ZJDBUtil : NSObject

/**
 * EGODatabaseResult 中第一个columnString的值
 *
 * @param result        数据库查询结果
 * @param columnString  字段key
 */
+ (NSString *)firstResultStringFrom:(EGODatabaseResult *)result withColumn:(NSString *)columnString;

/**
 * P_MYPROFILE   个人配置
 */
+ (MyProfile *)myProfileWithCurrentUser;

/**
 * P_MYPROFILE  更新用户基本信息
 *
 * @param userInfo  用户基本信息
 */
+ (BOOL)updateUserInfo:(NSDictionary *)userInfo;


/**
 * 数据库会话表整理
 */
+ (void)cleanUpSession;

/**
 * 通讯录整理
 *
 * @param loginInfo 登录信息
 */
+ (void)cleanUpTxlWithLoginInfo:(NSDictionary *)loginInfo;

/**
 * 新信息处理
 *
 * @param newMsgs   未读信息
 */
+ (void)handleNewMsgsWithNewMsgs:(NSDictionary *)newMsgsInfo;












/**
 * 批量插入测试
 */
+ (void)multiInsertTest;


@end
