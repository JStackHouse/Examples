//
//  ZJVariablesUtil.m
//  ZJTableView
//
//  Created by zhangjie on 15/1/16.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import "ZJVariablesUtil.h"
#import "AFHttpDefine.h"

@implementation ZJVariablesUtil


/**********************************
 * SET_ACCESS_TOKEN
 */
+ (void)setAccessToken:(NSString *)accessToken
{
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:ACCESS_TOKEN];
}

/**
 * GET_ACCESS_TOKEN
 */
+ (NSString *)accessToken;
{
    NSString *tempAccessToken = [[NSUserDefaults standardUserDefaults] objectForKey:ACCESS_TOKEN];
    return (nil == tempAccessToken ? @"" : tempAccessToken);
}

/**********************************
 * SET_SID
 */
+ (void)setSid:(NSString *)sid
{
    [[NSUserDefaults standardUserDefaults] setObject:sid forKey:APP_SID];
}

/**
 * GET_SID
 */
+ (NSString *)sid
{
    NSString *tempSid = [[NSUserDefaults standardUserDefaults] objectForKey:APP_SID];
    return (nil == tempSid ? @"" : tempSid);
}

/**********************************
 * SET_isFirstLogin
 * 设置是否初次登录
 */
+ (void)setHasLogined:(NSString *)phone
{
    NSString *isFirstLoginKey = [NSString stringWithFormat:@"logined.%@",phone];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isFirstLoginKey];
}

/**
 * GET_isFirstLogin
 */
+ (BOOL)hasLogined:(NSString *)phone
{
    NSString *isFirstLoginKey = [NSString stringWithFormat:@"logined.%@",phone];
    return [[NSUserDefaults standardUserDefaults] boolForKey:isFirstLoginKey];
}

/**********************************
 * SET_hz.sid
 * 记录当前用户是不是户主
 */
+ (void)setIsHz:(BOOL)isHz
{
    NSString *sidKey = [NSString stringWithFormat:@"hz.%@",[self sid]];
    [[NSUserDefaults standardUserDefaults]setBool:isHz forKey:sidKey];
}

/**
 * GET_hz.sid
 * 记录当前用户是不是户主
 */
+ (BOOL)isHz
{
    NSString *sidKey = [NSString stringWithFormat:@"hz.%@",[self sid]];
    return [[NSUserDefaults standardUserDefaults] boolForKey:sidKey];
}

/**********************************
 * SET_hzphone.sid
 * 设置户主号码
 */
+ (void)setHzPhone:(NSString *)hzPhone
{
    NSString *hzPhoneKey = [NSString stringWithFormat:@"hzphone.%@",[self sid]];
    [[NSUserDefaults standardUserDefaults] setObject:hzPhone forKey:hzPhoneKey];
}

/**
 * GET_hzphone.sid
 * 户主号码
 */
+ (NSString *)hzPhone
{
    NSString *hzPhoneKey = [NSString stringWithFormat:@"hzphone.%@",[self sid]];
    return [[NSUserDefaults standardUserDefaults] objectForKey:hzPhoneKey];
}

/**********************************
 * SET_pushReged.sid
 * 推送注册成功与否
 */
+ (void)setPushReged:(BOOL)reged
{
    NSString *pushRegedKey = [NSString stringWithFormat:@"pushReged.%@",[self sid]];
    [[NSUserDefaults standardUserDefaults] setBool:reged forKey:pushRegedKey];
}

/**
 * GET_pushReged.sid
 * 推送注册成功与否
 */
+ (BOOL)pushReged
{
    NSString *pushRegedKey = [NSString stringWithFormat:@"pushReged.%@",[self sid]];
    return [[NSUserDefaults standardUserDefaults] boolForKey:pushRegedKey];
}

/**********************************
 * SET_pushId.sid
 * 保存当前用户的PUSHID
 */
+ (void)setPushId:(NSString *)pushId
{
    NSString *pushIdKey = [NSString stringWithFormat:@"pushId.%@",[self sid]];
    [[NSUserDefaults standardUserDefaults] setObject:pushId forKey:pushIdKey];
}

/**
 * GET_pushId.sid
 * 保存当前用户的PUSHID
 */
+ (NSString *)pushId
{
    NSString *pushIdKey = [NSString stringWithFormat:@"pushId.%@",[self sid]];
    return [[NSUserDefaults standardUserDefaults] objectForKey:pushIdKey];
}

/**********************************
 * SET_updateApp
 * updateApp
 */
+ (void)setNeedUpdateApp:(BOOL)needUpdate
{
    [[NSUserDefaults standardUserDefaults] setBool:needUpdate forKey:@"updateApp"];
}

/**
 * GET_updateApp
 * updateApp
 */
+ (BOOL)needUpdateApp
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"updateApp"];
}

/**********************************
 * SET_updateUrl
 * updateUrl
 */
+ (void)setUpdateUrl:(NSString *)updateUrl
{
    [[NSUserDefaults standardUserDefaults] setObject:updateUrl forKey:@"updateUrl"];
}

/**
 * GET_updateUrl
 * updateUrl
 */
+ (NSString *)updateUrl
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"updateUrl"];
}

/**********************************
 * SET_updateLog
 * updateLog
 */
+ (void)setUpdateLog:(NSString *)updateLog
{
    [[NSUserDefaults standardUserDefaults] setObject:updateLog forKey:@"updateLog"];
}

/**
 * GET_updateLog
 * updateLog
 */
+ (NSString *)updateLog
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"updateLog"];
}

/**********************************
 * SET_kfAccount
 * kfAccount
 */
+ (void)setKfAccount:(NSString *)kfAccount
{
    [[NSUserDefaults standardUserDefaults] setObject:kfAccount forKey:@"kfAccount"];
}

/**
 * GET_kfAccount
 * kfAccount
 */
+ (NSString *)kfAccount
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"kfAccount"];
}

/**********************************
 * SET_lastTxlTime
 * 上次通讯录更新时间
 */
+ (void)setLastTxlTime:(NSTimeInterval)lastTxlTime
{
    NSString *lastTxlTimeKey = [NSString stringWithFormat:@"lastTxlTime.%@",[self sid]];
    [[NSUserDefaults standardUserDefaults] setDouble:lastTxlTime forKey:lastTxlTimeKey];
}

/**
 * GET_lastTxlTime
 * kfAccount
 */
+ (NSTimeInterval)lastTxlTime
{
    NSString *lastTxlTimeKey = [NSString stringWithFormat:@"lastTxlTime.%@",[self sid]];
    return [[NSUserDefaults standardUserDefaults] doubleForKey:lastTxlTimeKey];
}

/**********************************
 * SET_lastMsgId.sid
 * 最后获取到的消息ID
 */
+ (void)setLastMsgId:(NSString *)lastMsgId
{
    NSString *lastMsgIdKey = [NSString stringWithFormat:@"lastMsgId.%@",[self sid]];
    [[NSUserDefaults standardUserDefaults] setObject:lastMsgId forKey:lastMsgIdKey];
}

/**
 * GET_lastMsgId.sid
 * 最后获取到的消息ID
 */
+ (NSString *)lastMsgId
{
    NSString *lastMsgIdKey = [NSString stringWithFormat:@"lastMsgId.%@",[self sid]];
    return [[NSUserDefaults standardUserDefaults] objectForKey:lastMsgIdKey];
}

/**********************************
 * SET_txlLoaded.sid
 * 通信录是否成功加载过
 */
+ (void)setTxlLoaded:(BOOL)txlLoaded
{
    NSString *txlLoadedKey = [NSString stringWithFormat:@"txlLoaded.%@",[self sid]];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:txlLoadedKey];
}

/**
 * GET_txlLoaded.sid
 * 通信录是否成功加载过
 */
+ (BOOL)txlLoaded
{
    NSString *txlLoadedKey = [NSString stringWithFormat:@"txlLoaded.%@",[self sid]];
    return [[NSUserDefaults standardUserDefaults] boolForKey:txlLoadedKey];
}

/**********************************
 * SET_hasNewRecord.sid
 * 是否有新成长记录标志
 */
+ (void)setHasNewRecord:(BOOL)has
{
    NSString *hasNewRecordKey = [NSString stringWithFormat:@"hasNewRecord.%@",[self sid]];
    [[NSUserDefaults standardUserDefaults] setBool:has forKey:hasNewRecordKey];
}

/**
 * GET_hasNewRecord.sid
 * 是否有新成长记录标志
 */
+ (BOOL)hasNewRecord
{
    NSString *hasNewRecordKey = [NSString stringWithFormat:@"hasNewRecord.%@",[self sid]];
    return [[NSUserDefaults standardUserDefaults] boolForKey:hasNewRecordKey];
}


@end
