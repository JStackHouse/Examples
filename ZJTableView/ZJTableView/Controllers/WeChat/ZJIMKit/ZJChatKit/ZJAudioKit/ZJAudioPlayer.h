//
//  ZJAudioPlayer.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/19.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


@interface ZJAudioPlayer : NSObject <AVAudioPlayerDelegate>


@property (copy, nonatomic) UIImageView *animationImageView;


+ (instancetype)sharedAudioPlayer;


//根据音频文件名和文件类型，获取文件的本地路径
- (NSString *)audioFilePathFromfileName:(NSString *)fileName withType:(NSString *)type;
//返回文件名称
- (NSString *)fileName;

//播放音频文件
- (void)playAudioFileWithPath:(NSString *)filePath;
//暂停播放
- (void)pausePlaying;
//是否正在播放
- (BOOL)isPlaying;


//录制音频文件 - 文件名称
- (void)startRecordAudioFile;
//停止音频录制
- (void)stopRecording;

//获取录音时长
- (NSString *)audioDuration;

@end
