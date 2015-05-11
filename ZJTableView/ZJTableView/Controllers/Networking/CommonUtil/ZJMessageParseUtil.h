//
//  ZJMessageParseUtil.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/19.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    MessageTypeText = 0,
    MessageTypeImage,
    MessageTypeAudio,
    MessageTypeVideo,
    MessageTypeCmd,
    MessageTypeLink,
    MessageTypeNews
}MessageType;

@interface ZJMessageParseUtil : NSObject

/**
 * 解析类型消息
 *
 * @param type  类型string
 */
+ (MessageType)parseMessageType:(NSString *)type;

/**
 * 解析消息短语
 *
 * @param type  类型string
 */
+ (NSString *)parseShortMsg:(NSString *)type withContent:(NSDictionary *)contentInfo;

@end
