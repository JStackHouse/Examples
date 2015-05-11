//
//  AFHttpDefine.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/6.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#ifndef ZJTableView_AFHttpDefine_h
#define ZJTableView_AFHttpDefine_h


#import "JSONKit.h"

//打印日志
#define LOG                         1
#define NSLOG_STRING(__string)      if(LOG) NSLog(@"%@",(__string))

//超时时长
#define TIME_OUT                    5.0f

#define BASE_URL                    @"http://open.wenet980.com/OpenProxy"
//#define BASE_URL                  @"http://192.168.5.128:8800/OpenProxy"


//Appid
#define APP_ID                      @"iosapp"
//密钥
#define APP_SECRET                  @"123456789"
//客户端版本号
#define APP_VERSION                 [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//客户端类型
#define APP_AGENTTYPE               @"ios"


//access token
#define ACCESS_TOKEN                @"access_token"


//登陆用户的唯一标志 sid
#define APP_SID                     @"sid"


static const NSString *AFboundary = @"--------------------56423498738365";
static const NSString *AFFileKey = @"fileKey";
static const NSString *AFFileType = @"fileType";
static const NSString *AFFileData = @"fileData";

//userDefault的set方法
//#define USER_DEFAULT_SET(__obj,__key)           [[NSUserDefaults standardUserDefaults] setObject:(__obj) forKey:(__key)]
//#define USER_DEFAULT_SET_BOOL(__bool,__key)     [[NSUserDefaults standardUserDefaults] setBool:(__bool) forKey:(__key)]
//#define USER_DEFAULT_SET_DOUBLE(__double,__key) [[NSUserDefaults standardUserDefaults] setDouble:(__double) forKey:(__key)]
//userDefault的get方法
//#define USER_DEFAULT_GET(__key)                 [[NSUserDefaults standardUserDefaults] objectForKey:(__key)]
//#define USER_DEFAULT_GET_BOOL(__key)            [[NSUserDefaults standardUserDefaults] boolForKey:(__key)]
//#define USER_DEFAULT_GET_DOUBLE(__double,__key) [[NSUserDefaults standardUserDefaults] doubleForKey:(__key)]




#endif






