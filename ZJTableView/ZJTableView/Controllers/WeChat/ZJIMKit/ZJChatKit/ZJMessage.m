//
//  ZJMessage.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/12.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJMessage.h"

@implementation ZJMessage


//初始化文本消息
- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        time:(NSString *)time
{
    if (self = [super init])
    {
        self.text = text;
        self.messageSender = sender;
        self.messageTime = time;
        self.messageMediaType = ZJMessageMediaTypeText;
    }
    return self;
}


//初始化图片消息
- (instancetype)initWithPhoto:(UIImage *)photo
                 thumbnailPath:(NSString *)thumbnailPath
                 originalPath:(NSString *)originalPath
                       sender:(NSString *)sender
                         time:(NSString *)time
{
    if (self = [super init])
    {
        self.photo = photo;
        self.thumbnailPhotoPath = thumbnailPath;
        self.originalPhotoPath = originalPath;
        self.messageSender = sender;
        self.messageTime = time;
        self.messageMediaType = ZJMessageMediaTypePhoto;
    }
    return self;
}

//初始化音频消息
- (instancetype)initWithAudioPath:(NSString *)serverPath
                        localPath:(NSString *)localPath
                         duration:(NSString *)duration
                           sender:(NSString *)sender
                             time:(NSString *)time
{
    if (self = [super init])
    {
        self.audioServerPath = serverPath;
        self.audioLocalPath = localPath;
        self.audioDuration = duration;
        self.messageSender = sender;
        self.messageTime = time;
        self.messageMediaType = ZJMessageMediaTypeAudio;
    }
    return self;
}

//初始化视频消息
- (instancetype)initWithVideoPath:(UIImage *)videoPhoto
                       serverPath:(NSString *)serverPath
                        localPath:(NSString *)localPath
                           sender:(NSString *)sender
                             time:(NSString *)time
{
    if (self = [super init])
    {
        self.videoScreenshotPhoto = videoPhoto;
        self.videoServerPath = serverPath;
        self.videoLocalPath = localPath;
        self.messageSender = sender;
        self.messageTime = time;
        self.messageMediaType = ZJMessageMediaTypeVideo;
    }
    return self;
}

- (void)dealloc
{
    self.messageSender = nil;
    self.messageTime = nil;
    
    self.avator = nil;
    self.avatorUrl = nil;
    
    self.text = nil;
    
    self.photo = nil;
    self.thumbnailPhotoPath = nil;
    self.originalPhotoPath  = nil;
    
    self.audioServerPath = nil;
    self.audioLocalPath = nil;
    self.audioDuration = nil;
    
    self.videoScreenshotPhoto = nil;
    self.videoServerPath = nil;
    self.videoLocalPath = nil;
}


@end
