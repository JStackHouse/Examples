//
//  ZJBusinessUtil.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/14.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJDBModelDefine.h"

@interface ZJBusinessUtil : NSObject


/**
 * 初始化用户环境,在APP启动时候执行
 */
+ (void)initUserWithBlock:(void (^)(BOOL success, MyProfile *myProfile))initUserBlock;

/**
 * 发送验证码给已经注册的号码，主要为登录
 *
 * @param phone 手机号
 * @param 1：发送成功 0：号码格式不正确 2：验证码短信暂时无法发送 3：号码未注册 4：请求失败
 */
+ (void)sendYzm4RegedPhoneWithPhone:(NSString *)phone
                  sendYzmRegedBlock:(void (^)(int sendFlag))sendYzmRegedBlock;


/**
 * 发送验证码给未注册的号码，主要为注册和换号
 *
 * @param phone 手机号
 * @param 1：发送成功 0：号码格式不正确 2：验证码短信暂时无法发送 3：请求失败
 */
+ (void)sendYzm4UnRegedPhoneWithPhone:(NSString *)phone
                  sendYzmUnRegedBlock:(void (^)(int sendFlag))sendYzmUnRegedBlock;

/**
 * 获取最新通信录信息
 */
+ (void)txlWithUserLogin;

/**
 * 获取新信息列表
 */
+ (void)listNewMsgs;


/**
 * 登录
 *
 * @param phone     手机号
 * @param yzm       验证码
 * 1 登陆成功后处理，跳转到主面板 0 短信验证码不正确 2手机号码未注册，请先注册
 */
+ (void)loginWithPhone:(NSString *)phone
               withYzm:(NSString *)yzm
            loginBlock:(void (^)(int loginFlag, NSDictionary *loginInfo))loginBlock;


/**
 * 进行注册
 *
 * @param phone     电话
 * @param userName  姓名
 * @param yzm       验证码
 * 1 注册成功并进行了登陆 100 登陆时出现异常 99 无效验证码
 */
+ (void)regWithPhone:(NSString *)phone
        withUserName:(NSString *)userName
             withYzm:(NSString *)yzm
            regBlock:(void(^)(int regFalg, NSDictionary *regInfo))regBlock;


/**
 * 计算会话ID
 *
 * @param sessionIds    会话id数组
 */
+ (NSString *)calSessionIdWithIds:(NSArray *)sessionIds;


@end
