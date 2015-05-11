  //
//  ZJBusinessUtil.m
//  ZJTableView
//
//  Created by zhangjie on 15/1/14.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import "ZJBusinessUtil.h"
#import "AFHttpInterfaceUtil.h"
#import "AFHttpDefine.h"
#import "ZJDBUtil.h"
#import "ZJVariablesUtil.h"

@implementation ZJBusinessUtil


static int TXL_GET_TIMES = 0;
/**
 * 初始化用户环境,在APP启动时候执行
 * success      初始化成功与否
 * myProfile    初始化的个人信息
 */
+ (void)initUserWithBlock:(void (^)(BOOL success, MyProfile *myProfile))initUserBlock
{
    //清除通知栏通知
#warning ios8 与ios7不一致，单独处理
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    @try {
        //当前登录的个人信息
        MyProfile *myProfile = [ZJDBUtil myProfileWithCurrentUser];
        if (!myProfile)
        {
            //作未登录处理，跳转到登录注册页面
            initUserBlock(NO, nil);
        }
        else
        {
            //上次通信录获取时间
            TXL_GET_TIMES = myProfile.txlGetTime;
            //获取个人配置信息
            [AFHttpInterfaceUtil myProfileWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
                NSString *retval = result[@"retval"];
                if (NSOrderedSame == [@"1" compare:retval])
                {
                    int txlPeriods = 0;
                    NSString *txlTimeOut = result[@"txl.timeout"];
                    if (txlTimeOut && NSOrderedSame != [@"" compare:txlTimeOut])
                    {
                        txlPeriods = [txlTimeOut intValue];
                    }
                    //判断通信录是否超时
                    if(TXL_GET_TIMES + txlPeriods * 60 < [[NSDate date]timeIntervalSince1970])
                    {
                        //获取用户通信录
                        [ZJBusinessUtil txlWithUserLogin];
                    }
                    
                    //判断是否要更新
                    NSString *newVersion = result[@"newVersion"];
                    if (newVersion && NSOrderedSame != [@"" compare:newVersion] && NSOrderedSame != [[NSString stringWithFormat:@"%@",APP_VERSION] compare:newVersion])
                    {
                        [ZJVariablesUtil setNeedUpdateApp:YES];
                        [ZJVariablesUtil setUpdateUrl:result[@"updateurl"]];
                        [ZJVariablesUtil setUpdateLog:result[@"updatelog"]];
                        
                        //保存客服账号
                        [ZJVariablesUtil setKfAccount:result[@"kfaccount"]];
                    }
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
            
            //初始化推送服务
            [ZJBusinessUtil initPush];
            
            //通知UI处理做已登录处理
            initUserBlock(YES, myProfile);
            
            //加载新信息
            [ZJBusinessUtil listNewMsgs];
            
            //数据库数据整理
            [ZJDBUtil cleanUpSession];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"初始化用户环境 error is %@",exception.reason);
    }
    @finally {
        
    }
    
}

/**
 * 获取最新通信录信息
 */
+ (void)txlWithUserLogin
{
    NSLOG_STRING(@"获取最新通信录信息");
    [AFHttpInterfaceUtil userLoginWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSString *retVal = result[@"retval"];
        if (NSOrderedSame == [@"1" compare:retVal])
        {
            //更新用户基本信息
            [self updateUserInfo:result];
            
            //刷新通信录
            [ZJDBUtil cleanUpTxlWithLoginInfo:result];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/**
 * 更新用户基本信息
 *
 * @param userInfo  用户基本信息
 */
+ (void)updateUserInfo:(NSDictionary *)userInfo
{
//    {
//        hzphone = 18651655260;
//        i = "Fm9GQFxOX18=";
//        p = 18651655260;
//        pushid = "PUSHID_9";
//        retval = 1;
//        t = zhangjie;
//        txl =     (
//        );
//    }
    [ZJDBUtil updateUserInfo:userInfo];
}

#warning 初始化推送服务 补充
/**
 * 初始化推送服务
 */
+ (void)initPush
{
    
}

#warning 获取新信息列表 补充
/**
 * 获取新信息列表
 */
+ (void)listNewMsgs
{
    NSString *sid = [ZJVariablesUtil sid];
    if (!sid && NSOrderedSame == [sid compare:@""])
        return;
    //最后一条信息ID
    NSString *lastMsgId = [ZJVariablesUtil lastMsgId];
    [AFHttpInterfaceUtil listNewMsgsWithLastMsgId:lastMsgId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        int retval = [result[@"retval"] intValue];
        //信息处理
        if (1 == retval)
        {
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
        
}


/**
 * 登录
 *
 * @param phone     手机号
 * @param yzm       验证码
 * 1 登陆成功后处理，跳转到主面板 0 短信验证码不正确 2手机号码未注册，请先注册
 */
+ (void)loginWithPhone:(NSString *)phone
               withYzm:(NSString *)yzm
            loginBlock:(void (^)(int loginFlag, NSDictionary *loginInfo))loginBlock
{
    BOOL isFirstLogin = ![ZJVariablesUtil hasLogined:phone];
    [AFHttpInterfaceUtil loginByYzmWithPhone:phone withYzm:yzm isFirstLogin:isFirstLogin success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        //NSLog(@"class is %@",[result[@"retval"] class]);
        NSString *retVal = result[@"retval"];
        if (NSOrderedSame == [@"1" compare:retVal])
        {
            //设置为已经登录过
            [ZJVariablesUtil setHasLogined:phone];
            
            NSString *sid = result[@"i"];
            if (sid && NSOrderedSame != [@"" compare:sid])
            {
                [ZJVariablesUtil setSid:sid];
            }

            //更新用户基本信息
            [self updateUserInfo:result];
            
            //初始化当前用户环境
            [self initUserWithBlock:^(BOOL success, MyProfile *myProfile) {
                
            }];
        
            // 处理通信录
            [ZJDBUtil cleanUpTxlWithLoginInfo:result];
            loginBlock(1,result);
       }
        else if (NSOrderedSame == [@"0" compare:retVal])
        {
            loginBlock(0,result);
        }
        else
            loginBlock(2,result);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

/**
 * 登出
 *
 * @param
 * @param
 * @param
 *
 */
+ (void)logoutWithLogoutId:(int)logoutId
{
    EGODatabase *dataBase = [ZJDBBase initDatabase];
    [dataBase open];
    @try {
        NSString *updateMyProfileSql = @"update P_MYPROFILE set ISCURRENT = 0 where ISCURRENT = 1";
        [dataBase executeUpdate:updateMyProfileSql];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        [dataBase close];
    }
    
    [ZJVariablesUtil setSid:@""];
    
    //推送被注销
    [ZJVariablesUtil setPushReged:NO];
    //清除PUSHID
    [ZJVariablesUtil setPushId:@""];
    //推送服务注销
}

/**
 * 发送验证码给已经注册的号码，主要为登录
 *
 * @param phone 手机号
 * @param 1：发送成功 0：号码格式不正确 2：验证码短信暂时无法发送 3：号码未注册 4：请求失败
 */
+ (void)sendYzm4RegedPhoneWithPhone:(NSString *)phone
                  sendYzmRegedBlock:(void (^)(int sendFlag))sendYzmRegedBlock
{
    [AFHttpInterfaceUtil sendYZM4RegedPhoneWithPhone:phone success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        int retVal = [result[@"retval"] intValue];
        sendYzmRegedBlock(retVal);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        sendYzmRegedBlock(4);
    }];
}

/**
 * 发送验证码给未注册的号码，主要为注册和换号
 *
 * @param phone 手机号
 * @param 1：发送成功 0：号码格式不正确 2：验证码短信暂时无法发送 3：请求失败
 */
+ (void)sendYzm4UnRegedPhoneWithPhone:(NSString *)phone
                    sendYzmUnRegedBlock:(void (^)(int sendFlag))sendYzmUnRegedBlock
{
    [AFHttpInterfaceUtil sendYZM4UnRegedPhoneWithPhone:phone success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        int retVal = [result[@"retval"]intValue];
        sendYzmUnRegedBlock(retVal);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        sendYzmUnRegedBlock(3);
    }];
}


/**
 * 检查号码是否已经注册
 *
 * @param phone 手机号
 * @param 1：已注册，并返回用户ID[id] 0：未注册 2：请求失败
 */
+ (void)checkPhoneRegedWithPhone:(NSString *)phone
            checkPhoneRegedBlock:(void (^)(int regedFlag, NSString *sid))checkPhoneRegedBlock
{
    [AFHttpInterfaceUtil checkPhoneRegedWithPhone:phone success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        int retVal = [result[@"retval"] intValue];
        checkPhoneRegedBlock(retVal, 1 == retVal ? result[@"sid"] : nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        checkPhoneRegedBlock(2, nil);
    }];
}

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
            regBlock:(void(^)(int regFalg, NSDictionary *regInfo))regBlock
{
    [AFHttpInterfaceUtil regWithPhone:phone withUserName:userName withYzm:yzm success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        int retVal = [result[@"retval"]intValue];
        if (1 == retVal || 2 == retVal)
        {
            @try {
                [self loginWithPhone:phone withYzm:yzm loginBlock:^(int loginFlag, NSDictionary *loginInfo){
                    regBlock(1,loginInfo);
                 }];
            }
            @catch (NSException *exception) {
                NSLog(@"注册后登录异常 %@",exception.reason);
                regBlock(100,result);
            }
        }
        else
        {
            regBlock(99,result);
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
    }];
}


/**
 * 计算会话ID
 *
 * @param sessionIds    会话id数组
 */
+ (NSString *)calSessionIdWithIds:(NSArray *)sessionIds
{
#warning 需补充 去@，排序
    return nil;
}

@end



