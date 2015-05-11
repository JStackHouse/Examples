//
//  ConfigureDefine.h
//  TemplatesProject
//
//  Created by zhangjie on 15/5/8.
//  Copyright (c) 2015年 stack. All rights reserved.
//

#ifndef TemplatesProject_ConfigureDefine_h
#define TemplatesProject_ConfigureDefine_h

/**
 * 系统配置的宏定义
 */

//#define TEST_LOG        //表明是测试状态，日志会打印，正式发布的时候，这个宏要去掉
//#define TEST_PUSH       //正式IP地址时需注掉，控制测试还是外网环境的推送
#define IS_DEVELOP      //发布时需注掉，控制


#define TIME_OUT        10.0f       //超时时长


#define BASE_URL        @"http://www."      //正式URL
#define TEST_BASE_URL   @"http://192."      //开发URL

#endif
