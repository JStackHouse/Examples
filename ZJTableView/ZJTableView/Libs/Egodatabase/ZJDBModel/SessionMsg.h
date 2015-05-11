//
//  SessionMsg.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/15.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionMsg : NSObject


@property (strong, nonatomic) NSString *msgId;

@property (strong, nonatomic) NSString *sid;

@property (strong, nonatomic) NSString *sessionId;

@property (strong, nonatomic) NSString *msgContent;

@property (strong, nonatomic) NSDate *recTime;

@property (strong, nonatomic) NSString *fromer;

@property (assign, nonatomic) int status;

@property (assign, nonatomic) int readed;

@property (strong, nonatomic) NSString *qKey;

@end
