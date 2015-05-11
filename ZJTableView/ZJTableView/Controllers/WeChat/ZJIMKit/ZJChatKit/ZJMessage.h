//
//  ZJMessage.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/12.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    ZJMessageMediaTypeText = 0,
    ZJMessageMediaTypeAudio,
    ZJMessageMediaTypePhoto,
    ZJMessageMediaTypeVideo
}ZJMessageMediaType;

typedef enum{
    ZJMessageTypeReceive = 0,
    ZJMessageTypeSend
}ZJMessageReceiveSendType;

typedef enum{
    ZJMessageSendStateNone = 0,
    ZJMessageSendStateSending,
    ZJMessageSendStateSuccess,
    ZJMessageSendStateFail
}ZJMessageSendStateType;

typedef enum{
    ZJInputViewTypeNone = 0,
    ZJInputViewTypeText,
    ZJInputViewTypeAudio,
    ZJInputViewTypeFace,
    ZJInputViewTypeMediaMenu
}ZJInputViewType;


@protocol ZJMessageModel <NSObject>

@required
- (UIImage *)avator;
- (NSString *)avatorUrl;

- (NSString *)text;

- (UIImage *)photo;
- (NSString *)thumbnailPhotoPath;
- (NSString *)originalPhotoPath;

- (NSString *)audioServerPath;
- (NSString *)audioLocalPath;
- (NSString *)audioDuration;

- (UIImage *)videoScreenshotPhoto;
- (NSString *)videoServerPath;
- (NSString *)videoLocalPath;

- (ZJMessageMediaType)messageMediaType;
- (ZJMessageReceiveSendType)messageReceiveSendType;
- (ZJMessageSendStateType)messageSendStateType;

@optional
- (NSString *)messageTime;
- (NSString *)messageSender;

@end


@interface ZJMessage : NSObject <ZJMessageModel>


//是否发送
@property (assign, nonatomic) BOOL isSend;

//消息的时间
@property (copy, nonatomic) NSString *messageTime;
//消息发送者
@property (nonatomic, copy) NSString *messageSender;


//头像图片
@property (strong, nonatomic) UIImage *avator;
//头像图片地址
@property (copy, nonatomic) NSString *avatorUrl;


//文本内容
@property (copy, nonatomic) NSString *text;

//发送或接收的图片
@property (strong, nonatomic) UIImage *photo;
//缩略图路径
@property (copy, nonatomic) NSString *thumbnailPhotoPath;
//原图路径
@property (copy, nonatomic) NSString *originalPhotoPath;


//音频服务器路径
@property (copy, nonatomic) NSString *audioServerPath;
//音频本地路径
@property (copy, nonatomic) NSString *audioLocalPath;
//音频时长
@property (copy, nonatomic) NSString *audioDuration;

//视频截图图片
@property (strong, nonatomic) UIImage *videoScreenshotPhoto;
//视频服务器路径
@property (copy, nonatomic) NSString *videoServerPath;
//视频本地路径
@property (copy, nonatomic) NSString *videoLocalPath;


//内容类型
@property (assign, nonatomic) ZJMessageMediaType messageMediaType;

//内容收发类型
@property (assign, nonatomic) ZJMessageReceiveSendType messageReceiveSendType;

//发送状态
@property (assign, nonatomic) ZJMessageSendStateType messageSendStateType;

//初始化文本消息
- (instancetype)initWithText:(NSString *)text
                      sender:(NSString *)sender
                        time:(NSString *)time;


//初始化图片消息
- (instancetype)initWithPhoto:(UIImage *)photo
                 thumbnailPath:(NSString *)thumbnailPath
                  originalPath:(NSString *)originalPath
                       sender:(NSString *)sender
                         time:(NSString *)time;

//初始化音频消息
- (instancetype)initWithAudioPath:(NSString *)serverPath
                        localPath:(NSString *)localPath
                         duration:(NSString *)duration
                           sender:(NSString *)sender
                             time:(NSString *)time;

//初始化视频消息
- (instancetype)initWithVideoPath:(UIImage *)videoPhoto
                       serverPath:(NSString *)serverPath
                        localPath:(NSString *)localPath
                           sender:(NSString *)sender
                             time:(NSString *)time;

@end
