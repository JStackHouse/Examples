//
//  ZJMessageParseUtil.m
//  ZJTableView
//
//  Created by zhangjie on 15/1/19.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import "ZJMessageParseUtil.h"

@implementation ZJMessageParseUtil


const static NSString *MSGTYPE_NEWS = @"news";
const static NSString *MSGTYPE_LINK = @"link";
const static NSString *MSGTYPE_CMD = @"cmd";
const static NSString *MSGTYPE_VIDEO = @"video";
const static NSString *MSGTYPE_AUDIO = @"audio";
const static NSString *MSGTYPE_IMAGE = @"image";
const static NSString *MSGTYPE_TEXT = @"text";

/**
 * 解析类型消息
 *
 * @param type  类型string
 */
+ (MessageType)parseMessageType:(NSString *)type
{
    MessageType messageType;
    if (NSOrderedSame == [MSGTYPE_TEXT compare:type])
        messageType = MessageTypeText;
    else if (NSOrderedSame == [MSGTYPE_IMAGE compare:type])
        messageType = MessageTypeImage;
    else if (NSOrderedSame == [MSGTYPE_AUDIO compare:type])
        messageType = MessageTypeAudio;
    else if (NSOrderedSame == [MSGTYPE_VIDEO compare:type])
        messageType = MessageTypeVideo;
    else if (NSOrderedSame == [MSGTYPE_CMD compare:type])
        messageType = MessageTypeCmd;
    else if (NSOrderedSame == [MSGTYPE_LINK compare:type])
        messageType = MessageTypeLink;
    else if (NSOrderedSame == [MSGTYPE_NEWS compare:type])
        messageType = MessageTypeNews;
    return messageType;
}

/**
 * 解析消息短语
 *
 * @param type  类型string
 */
+ (NSString *)parseShortMsg:(NSString *)type withContent:(NSDictionary *)contentInfo
{
    NSString *shortMsg;
    if (NSOrderedSame == [MSGTYPE_IMAGE compare:type])
        shortMsg = @"[图片]";
    else if (NSOrderedSame == [MSGTYPE_AUDIO compare:type])
        shortMsg = @"[一段话]";
    else if (NSOrderedSame == [MSGTYPE_VIDEO compare:type])
        shortMsg = @"[视频]";
    else if (NSOrderedSame == [MSGTYPE_LINK compare:type])
        shortMsg = @"[链接]";
    else if (NSOrderedSame == [MSGTYPE_CMD compare:type])
    {
        NSArray *listNews = [contentInfo objectForKey:@"list"];
        NSString *title = nil;
        if (listNews.count > 0)
        {
            title = listNews[0][@"title"];
        }
        shortMsg = title ? [NSString stringWithFormat:@"[图文]%@",title] : @"[图文]";
    }
    return shortMsg;
}


@end
