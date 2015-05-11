//
//  LatestSession.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/15.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestSession : NSObject

@property (strong, nonatomic) NSString *sid;

@property (strong, nonatomic) NSString *sessionId;

@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *msgLabel;

@property (strong, nonatomic) NSDate *lastTime;

@property (assign, nonatomic) int unReads;

@property (assign, nonatomic) int direction;

@property (strong, nonatomic) NSString *qunId;

@end
