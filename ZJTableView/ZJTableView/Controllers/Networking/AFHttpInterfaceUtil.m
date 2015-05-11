//
//  AFHttpInterfaceUtil.m
//  ZJTableView
//
//  Created by zhangjie on 15/1/6.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import "AFHttpInterfaceUtil.h"
#import "AFHttpUtil.h"
#import "AFHttpDefine.h"
#import "NSString+MD5.h"
#import "ZJVariablesUtil.h"

@implementation AFHttpInterfaceUtil

/**
 * Json数据解析
 *
 * @param object 解析对象
 */
+ (NSDictionary *)jsonParseWithObject:(id)object
{
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:object options:NSJSONReadingAllowFragments error:nil];
    return result;
}

/**
 * 判断是否token非法
 *
 * @param object    返回判断对象
 */
+ (BOOL)isAccessTokenLegal:(id)object
{
    BOOL isLegal = YES;
    NSDictionary *resultDic = [self jsonParseWithObject:object];
    //NSString *retval = resultDic[@"retval"];
    NSInteger retval = [resultDic[@"retval"] integerValue];
    //if (NSOrderedSame == [@"99998" compare:retval])
    if (99998 == retval)
        isLegal = NO;
    return isLegal;
}


/**
 * 获取access token
 */
+ (void)accessTokenWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
    NSDictionary *para = @{@"appid": APP_ID, @"secret": APP_SECRET, @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    NSLog(@"para is %@",para);
    [AFHttpUtil getRequestWithActionName:@"getAccessToken" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"中间层");
        NSDictionary *result = [self jsonParseWithObject:responseObject];
        NSLog(@"获取access token 返回结果 %@",result);
        NSString *access_token = result[@"access_token"];
        [ZJVariablesUtil setAccessToken:access_token];
        successBlock(operation, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
//    [AFHttpUtil getRequestWithActionName:@"getAccessToken" para:para success:successBlock failure:failureBlock];
}

/**
 * 发送验证码给已经注册的号码
 *
 *  @param phoneNum 电话号码
 */
+ (void)sendYZM4RegedPhoneWithPhone:(NSString *)phoneNum
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], @"phone": phoneNum, @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    
    [AFHttpUtil postRequestWithActionName:@"sendYzm4RegedPhone" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self sendYZM4RegedPhoneWithPhone:phoneNum success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"sendYzm4RegedPhone" para:para success:successBlock failure:failureBlock];
}

/**
 * 发送验证码给未注册的号码
 *
 *  @param phoneNum 电话号码
 */
+ (void)sendYZM4UnRegedPhoneWithPhone:(NSString *)phoneNum
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], @"phone": phoneNum, @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    [AFHttpUtil postRequestWithActionName:@"sendYzm4UnRegedPhone" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self sendYZM4UnRegedPhoneWithPhone:phoneNum success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"sendYzm4UnRegedPhone" para:para success:successBlock failure:failureBlock];
}

/**
 * 判断号码是否已经注册
 *
 * @param phoneNum 电话号码
 */
+ (void)checkPhoneRegedWithPhone:(NSString *)phoneNum
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], @"phone": phoneNum, @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    [AFHttpUtil postRequestWithActionName:@"checkPhoneReged" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self checkPhoneRegedWithPhone:phoneNum success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"checkPhoneReged" para:para success:successBlock failure:failureBlock];
}

/**
 * 获取添加家庭成员许可码
 */
+ (void)xkmOfAddingMemberWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil sid] || ![ZJVariablesUtil accessToken])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    [AFHttpUtil postRequestWithActionName:@"getXKM" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self xkmOfAddingMemberWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"getXKM" para:para success:successBlock failure:failureBlock];
}

/**
 * 注册
 *
 * @param phoneNum  电话号码
 * @param userName  姓名
 * @param yzm       短信验证码
 */
+ (void)regWithPhone:(NSString *)phoneNum
        withUserName:(NSString *)userName
             withYzm:(NSString *)yzm
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], @"phone": phoneNum, @"username": userName, @"sex": @"2", @"yzm": [yzm md5], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    [AFHttpUtil postRequestWithActionName:@"reg" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self regWithPhone:phoneNum withUserName:userName withYzm:yzm success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"reg" para:para success:successBlock failure:failureBlock];
}

/**
 * 获取用户配置
 */
+ (void)myProfileWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    [AFHttpUtil postRequestWithActionName:@"getMyProfile" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self myProfileWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    
    //[AFHttpUtil postRequestWithActionName:@"getMyProfile" para:para success:successBlock failure:failureBlock];
}

/**
 * 登录
 *
 * @param phoneNum      电话号码
 * @param yzm           短信验证码
 * @param isFirstLogin  是否为第一次登录
 */
+ (void)loginByYzmWithPhone:(NSString *)phoneNum
                    withYzm:(NSString *)yzm
               isFirstLogin:(BOOL)isFirstLogin
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
    NSString *bFirstLogin = isFirstLogin ? @"1" : @"0";
//    if (![ZJVariablesUtil accessToken])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], @"phone": phoneNum, @"yzm": [yzm md5], @"firstlogin": bFirstLogin, @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    [AFHttpUtil postRequestWithActionName:@"loginByYzm" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self loginByYzmWithPhone:phoneNum withYzm:yzm isFirstLogin:isFirstLogin success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"loginByYzm" para:para success:successBlock failure:failureBlock];
}

/**
 * 得到用户登录信息
 */
+ (void)userLoginWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    [AFHttpUtil postRequestWithActionName:@"getUserLogin" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self userLoginWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    
    //[AFHttpUtil postRequestWithActionName:@"getUserLogin" para:para success:successBlock failure:failureBlock];
}


/**
 * 绑定孩子的接送卡
 *
 * @param childId       孩子ID
 * @param cardId        接送卡号
 * @param schId         学校ID
 * @param isAppendCard  是否是追加新卡，1 表示是，0表示否
 */
+ (void)bindCardWithChildId:(NSString *)childId
                     cardId:(NSString *)cardId
                   schoolId:(NSString *)schId
                   isAppend:(BOOL)isAppendCard
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSString *bAppendCard = isAppendCard ? @"1" : @"0";
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"childid": childId, @"cardid": cardId, @"schid": schId, @"append": bAppendCard};
    [AFHttpUtil postRequestWithActionName:@"bindCard" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self bindCardWithChildId:childId cardId:cardId schoolId:schId isAppend:isAppendCard success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"bindCard" para:para success:successBlock failure:failureBlock];
}




/**
 * 获取孩子列表
 */
+ (void)listChildrenWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE};
    [AFHttpUtil postRequestWithActionName:@"listChildren" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self listChildrenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    
    //[AFHttpUtil postRequestWithActionName:@"listChildren" para:para success:successBlock failure:failureBlock];
}

/**
 * 添加孩子信息
 *
 * @param   孩子姓名
 * @param   性别
 * @param   出生年月
 * @param   家长与孩子关系
 */
+ (void)addChildWithName:(NSString *)childName
                 withSex:(NSString *)sex
            withBirthday:(NSString *)birthday
                 withP2s:(NSString *)p2s
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"childname": childName, @"sex": sex, @"birth": birthday, @"p2s": p2s};
    
    [AFHttpUtil postRequestWithActionName:@"addChild" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self addChildWithName:childName withSex:sex withBirthday:birthday withP2s:p2s success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"addChild" para:para success:successBlock failure:failureBlock];
}

/**
 * 加入班级
 *
 * @param   孩子ID
 * @param   班级加入码
 */
+ (void)joinClassWithChildId:(NSString *)childId
                withJoinCode:(NSString *)joinCode
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"childid": childId, @"joincode": joinCode};
    
    [AFHttpUtil postRequestWithActionName:@"joinClass" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self joinClassWithChildId:childId withJoinCode:joinCode success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"joinClass" para:para success:successBlock failure:failureBlock];
}


/**
 * 更换手机号码
 *
 * @param   新手机号码
 * @param   短信验证码
 */
+ (void)changePhoneWithANewPhone:(NSString *)aNewPhone
                         withYzm:(NSString *)yzm
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"newphone": aNewPhone, @"yzm": yzm};
    
    [AFHttpUtil postRequestWithActionName:@"changePhone" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self changePhoneWithANewPhone:aNewPhone withYzm:yzm success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"changePhone" para:para success:successBlock failure:failureBlock];
}


/**
 * 添加孩子其他家长
 *
 * @param parentPhone   家长号码
 * @param p2s           与孩子关系
 * @param xkm           许可码
 */
+ (void)addOtherParentWithParentPhone:(NSString *)parentPhone
                              withP2s:(NSString *)p2s
                              withXkm:(NSString *)xkm
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"parentphone": parentPhone, @"p2s": p2s, @"xkm": xkm};
    
    [AFHttpUtil postRequestWithActionName:@"addOtherParent" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self addOtherParentWithParentPhone:parentPhone withP2s:p2s withXkm:xkm success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"addOtherParent" para:para success:successBlock failure:failureBlock];
}

/**
 * 信息发送
 *
 * @param message   信息内容
 * @param scratch   信息签名
 * @param receivers 接收人列表
 */
+ (void)sendMsgWithMessageContent:(NSString *)message
                    withReceivers:(NSString *)receivers
                      withScratch:(NSString *)scratch
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"msgcontent": message, @"receivers": receivers, @"scratch": scratch};
    
    [AFHttpUtil postRequestWithActionName:@"sendMsg" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self sendMsgWithMessageContent:message withReceivers:receivers withScratch:scratch success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"sendMsg" para:para success:successBlock failure:failureBlock];
}

/**
 * 发送成长记录
 *
 * @param   信息内容
 */
+ (void)sendRecordWithMessageContent:(NSString *)message
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"msgcontent": message};
    
    [AFHttpUtil postRequestWithActionName:@"sendRecord" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self sendRecordWithMessageContent:message success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"sendRecord" para:para success:successBlock failure:failureBlock];
}

/**
 * 获取未读信息
 *
 * @param lastMessageId     最后一次得到的消息ID
 */
+ (void)listNewMsgsWithLastMsgId:(NSString *)lastMessageId
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"lastmsgid": lastMessageId};
    
    [AFHttpUtil postRequestWithActionName:@"listNewMsgs" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self listNewMsgsWithLastMsgId:lastMessageId success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"listNewMsgs" para:para success:successBlock failure:failureBlock];
}

/**
 * 文件上传
 *
 * @param fileData  文件对象
 * @param text      文本
 */
+ (void)uploadWithFile:(NSData *)fileData
              withText:(NSString *)text
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"text": text, @"actionName": @"upload"};
    
    [AFHttpUtil postRequestWithActionName:@"upload" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self uploadWithFile:fileData withText:text success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postFileRequestWithActionName:@"upload" para:para fileData:fileData success:successBlock failure:failureBlock];
}


/**
 * 文件下载
 *
 * @param fileId  文件ID
 */
+ (void)fileWithFid:(NSString *)fileId
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
    NSDictionary *para = @{@"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"fid": fileId};
    
    [AFHttpUtil getRequestWithActionName:@"file" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self fileWithFid:fileId success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil getRequestWithActionName:@"file" para:para success:successBlock failure:failureBlock];
}

/**
 * 扫描登陆二维码
 *
 * @param logineToken  登陆令牌
 */
+ (void)returnQRCodeSMWithLoginToken:(NSString *)logineToken
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"logintoken": logineToken};
    
    [AFHttpUtil postRequestWithActionName:@"returnQRCodeSM" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self returnQRCodeSMWithLoginToken:logineToken success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"returnQRCodeSM" para:para success:successBlock failure:failureBlock];
}



/**
 * 教师提交每日考勤确认信息
 *
 * @param   异常考勤明细
 */
+ (void)postDayKQWithYclb:(NSString *)yclb
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"yclb": yclb};
    
    [AFHttpUtil postRequestWithActionName:@"postDayKQ" para:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self postDayKQWithYclb:yclb success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postRequestWithActionName:@"postDayKQ" para:para success:successBlock failure:failureBlock];
}

/**
 * 多图信息发送
 *
 * @param files     文件对象，序号从0开始
 * @param scratch   信息签名
 * @param receivers 接收人列表
 */
+ (void)sendMsgPicsWithFiles:(NSArray *)files
                 withScratch:(NSString *)scratch
               withReceivers:(NSString *)receivers
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSString *filesCount = [NSString stringWithFormat:@"%d",(int)files.count];
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"actionName": @"sendMsgPics",@"files": filesCount, @"scratch":scratch, @"receivers":receivers};
    
    [AFHttpUtil postMultiFileRequestWithActionName:@"sendMsgPics" para:para fileDatas:files success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self sendMsgPicsWithFiles:files withScratch:scratch withReceivers:receivers success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postMultiFileRequestWithActionName:@"sendMsgPics" para:para fileDatas:files success:successBlock failure:failureBlock];
}

/**
 * 发送多图成长记录
 *
 * @param files     文件对象，序号从0开始
 */
+ (void)sendRecordPicsWithFiles:(NSArray *)files
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
    NSLog(@"sendRecordPics date is %@",[NSDate date]);
//    if (![ZJVariablesUtil accessToken] || ![ZJVariablesUtil sid])
//        return;
    NSString *filesCount = [NSString stringWithFormat:@"%d",(int)files.count];
    NSDictionary *para = @{ACCESS_TOKEN: [ZJVariablesUtil accessToken], APP_SID: [ZJVariablesUtil sid], @"version": APP_VERSION, @"agenttype": APP_AGENTTYPE, @"actionName": @"sendRecordPics",@"files": filesCount};
    
    [AFHttpUtil postMultiFileRequestWithActionName:@"sendRecordPics" para:para fileDatas:files success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //如果token非法
        if (![self isAccessTokenLegal:responseObject])
        {
            [self accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                //本接口重新请求
                [self sendRecordPicsWithFiles:files success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    successBlock(operation, responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    
                }];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
        }
        //如果token合法
        else
        {
            successBlock(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(operation, error);
    }];
    //[AFHttpUtil postMultiFileRequestWithActionName:@"sendRecordPics" para:para fileDatas:files success:successBlock failure:failureBlock];
}



@end






