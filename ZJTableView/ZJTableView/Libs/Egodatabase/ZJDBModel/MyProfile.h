//
//  MyProfile.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/14.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyProfile : NSObject


@property (strong, nonatomic) NSString *sid;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *phone;

@property (assign, nonatomic) int txlGetTime;

@property (assign, nonatomic) int isCurrent;

@property (strong, nonatomic) NSString *deviceId;

@property (assign, nonatomic) int lastMsgId;


@end
