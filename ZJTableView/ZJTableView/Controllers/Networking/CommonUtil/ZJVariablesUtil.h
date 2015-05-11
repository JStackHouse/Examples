//
//  ZJVariablesUtil.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/16.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJVariablesUtil : NSObject

/**********************************
 * SET_ACCESS_TOKEN//设置为已经登录过
 */
+ (void)setAccessToken:(NSString *)accessToken;

/**
 * GET_ACCESS_TOKEN
 */
+ (NSString *)accessToken;


/**********************************
 * SET_SID
 */
+ (void)setSid:(NSString *)sid;

/**
 * GET_SID
 */
+ (NSString *)sid;

/**********************************
 * SET_isFirstLogin
 * 设置是否初次登录
 */
+ (void)setHasLogined:(NSString *)phone;

/**
 * GET_isFirstLogin
 */
+ (BOOL)hasLogined:(NSString *)phone;


/**********************************
 * SET_hz.sid
 * 记录当前用户是不是户主
 */
+ (void)setIsHz:(BOOL)isHz;

/**
 * GET_hz.sid
 * 当前用户是不是户主
 */
+ (BOOL)isHz;


/**********************************
 * SET_hzphone.sid
 * 设置户主号码
 */
+ (void)setHzPhone:(NSString *)hzPhone;

/**
 * GET_hzphone.sid
 * 户主号码
 */
+ (NSString *)hzPhone;

/**********************************
 * SET_pushReged.sid
 * 推送注册成功
 */
+ (void)setPushReged:(BOOL)reged;

/**
 * GET_pushReged.sid
 * 推送注销
 */
+ (BOOL)pushReged;


/**********************************
 * SET_pushId.sid
 * 保存当前用户的PUSHID
 */
+ (void)setPushId:(NSString *)pushId;

/**
 * GET_pushId.sid
 * 保存当前用户的PUSHID
 */
+ (NSString *)pushId;


/**********************************
 * SET_updateApp
 * updateApp
 */
+ (void)setNeedUpdateApp:(BOOL)needUpdate;

/**
 * GET_updateApp
 * updateApp
 */
+ (BOOL)needUpdateApp;


/**********************************
 * SET_updateUrl
 * updateUrl
 */
+ (void)setUpdateUrl:(NSString *)updateUrl;

/**
 * GET_updateUrl
 * updateUrl
 */
+ (NSString *)updateUrl;

/**********************************
 * SET_updateLog
 * updateLog
 */
+ (void)setUpdateLog:(NSString *)updateLog;

/**
 * GET_updateLog
 * updateLog
 */
+ (NSString *)updateLog;

/**********************************
 * SET_kfAccount
 * kfAccount
 */
+ (void)setKfAccount:(NSString *)kfAccount;

/**
 * GET_kfAccount
 * kfAccount
 */
+ (NSString *)kfAccount;

/**********************************
 * SET_lastTxlTime.sid
 * 上次通讯录更新时间
 */
+ (void)setLastTxlTime:(NSTimeInterval)lastTxlTime;

/**
 * GET_lastTxlTime.sid
 * kfAccount
 */
+ (NSTimeInterval)lastTxlTime;

/**********************************
 * SET_lastMsgId.sid
 * 最后获取到的消息ID
 */
+ (void)setLastMsgId:(NSString *)lastMsgId;

/**
 * GET_lastMsgId.sid
 * 最后获取到的消息ID
 */
+ (NSString *)lastMsgId;

/**********************************
 * SET_txlLoaded.sid
 * 通信录是否成功加载过
 */
+ (void)setTxlLoaded:(BOOL)txlLoaded;

/**
 * GET_txlLoaded.sid
 * 通信录是否成功加载过
 */
+ (BOOL)txlLoaded;

/**********************************
 * SET_hasNewRecord.sid
 * 是否有新成长记录标志
 */
+ (void)setHasNewRecord:(BOOL)has;

/**
 * GET_hasNewRecord.sid
 * 是否有新成长记录标志
 */
+ (BOOL)hasNewRecord;

@end
