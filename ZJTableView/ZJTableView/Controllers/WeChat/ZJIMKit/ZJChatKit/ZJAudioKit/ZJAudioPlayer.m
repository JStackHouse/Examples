//
//  ZJAudioPlayer.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/19.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJAudioPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import "VoiceConverter.h"

#define DocumentsPath       [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
#define AudioPath           [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Audio"]


@interface ZJAudioPlayer ()


@property (strong, nonatomic) AVAudioRecorder *recorder;

@property (strong, nonatomic) AVAudioPlayer *player;


@property (strong, nonatomic) NSString *fileName;
//@property (strong, nonatomic) NSString *wavFileName;
//
//@property (strong, nonatomic) NSString *amrFileName;

@property (strong, nonatomic) NSString *duration;

@end



@implementation ZJAudioPlayer

static ZJAudioPlayer *_zjAudioPlayer = nil;

//单例初始化
+ (instancetype)sharedAudioPlayer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _zjAudioPlayer = [[ZJAudioPlayer alloc]init];
        
        NSLog(@"NSHomeDirectory is %@",NSHomeDirectory());
    });
    return _zjAudioPlayer;
}

//
- (void)setAnimationImageView:(UIImageView *)animationImageView
{
    if(_animationImageView != animationImageView)
    {
        [_animationImageView stopAnimating];
        _animationImageView = nil;
        [_player stop];
    }
    _animationImageView = animationImageView;
}


//根据音频文件名和文件类型，获取文件的本地路径
- (NSString *)audioFilePathFromfileName:(NSString *)fileName withType:(NSString *)type
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL bExist = [fileManager fileExistsAtPath:AudioPath isDirectory:&isDir];
    if (bExist == NO || isDir == NO)
    {
        [fileManager createDirectoryAtPath:AudioPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *filePath = [[AudioPath stringByAppendingPathComponent:fileName]stringByAppendingPathExtension:type];
    return filePath;
}

//当前时间
- (NSString *)currentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];
    return timeString;
}

//返回文件名称
- (NSString *)fileName
{
    return _fileName;
}

#pragma mark - record

//录制音频文件 - 文件名称
- (void)startRecordAudioFile
{
    _fileName = [self currentTime];
    NSString *wavPath = [self audioFilePathFromfileName:_fileName withType:@"wav"];
    [self startRecordAudioFileWithPath:wavPath];
    //转码相关
    [VoiceConverter changeStu];
    //启动计时器
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self                                                                           selector:@selector(wavToAmrAction) object:nil];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation];
}

//录制音频文件 - 文件路径
- (void)startRecordAudioFileWithPath:(NSString *)filePath
{
    @try {
        //初始化录音
        NSError *error;
        _recorder = [[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:filePath]
                                               settings:[self audioRecorderSetting]
                                                  error:&error];
        if (error)
        {
            NSException *exception = [[NSException alloc]initWithName:@"AVAudioRecorderInit" reason:error.description userInfo:nil];
            [exception raise];
        }
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        //开始录音
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        [_recorder record];
    }
    @catch (NSException *exception) {
        NSLog(@"exception.name is %@;exception.reason is %@",exception.name,exception.reason);
    }
    @finally {
        
    }
}

//停止音频录制
- (void)stopRecording
{
    [VoiceConverter changeStu];
    if (_recorder && [_recorder isRecording])
    {
        [_recorder stop];
    }
}

//获取录音时长
- (NSString *)audioDuration
{
    NSString *wavPath = [self audioFilePathFromfileName:_fileName withType:@"wav"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:wavPath] error:nil];
    NSLog(@"录音时长 %.1f",player.duration);
    return [NSString stringWithFormat:@"%.1f",player.duration];
}


//获取录音设置
- (NSDictionary*)audioRecorderSetting
{
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey, //采样率
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,//采样位数 默认 16
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,//通道的数目
                                   //[NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,//大端还是小端 是内存的组织方式
                                   //[NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,//采样信号是整数还是浮点数
                                   //[NSNumber numberWithInt: AVAudioQualityMedium],AVEncoderAudioQualityKey,//音频编码质量
                                   nil];
    return recordSetting;
}


#pragma mark - play

//播放音频文件
- (void)playAudioFileWithPath:(NSString *)filePath
{
    _player = nil;
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL URLWithString:filePath] error:nil];
    _player.delegate = self;
    [_player play];
    [_animationImageView startAnimating];
}

//暂停播放
- (void)pausePlaying
{
    if (_player && [_player isPlaying])
    {
        [_player pause];
        [_animationImageView stopAnimating];
    }
}

//是否正在播放
- (BOOL)isPlaying
{
    return (_player && [_player isPlaying]);
}



#pragma mark - 转码相关
- (void)wavToAmrAction
{
    if (_fileName && _fileName.length > 0)
    {
        NSLog(@"wav转amr");
        NSString *wavPath = [self audioFilePathFromfileName:_fileName withType:@"wav"];
        NSString *amrPath = [self audioFilePathFromfileName:_fileName withType:@"amr"];
        [VoiceConverter wavToAmr:wavPath amrSavePath:amrPath];
        
        //
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData *wavData = [fileManager contentsAtPath:wavPath];
        NSLog(@"wav 路径:%@ \n 文件大小:%d",wavPath,(int)wavData.length);
        
        
        NSData *amrData = [fileManager contentsAtPath:amrPath];
        NSLog(@"amr 路径:%@ \n 文件大小:%d",amrPath,(int)amrData.length);
        
        
//        /[self amrToWavAction];
//        [self playAudioFileWithPath:wavPath];
        
    }
}

- (void)amrToWavAction
{
    if (_fileName && _fileName.length > 0)
    {
        NSLog(@"amr转wav");
        NSString *wavPath = [self audioFilePathFromfileName:_fileName withType:@"wav"];
        NSString *amrPath = [self audioFilePathFromfileName:_fileName withType:@"amr"];
        [VoiceConverter amrToWav:amrPath wavSavePath:wavPath];

        //
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData *wavData = [fileManager contentsAtPath:wavPath];
        NSLog(@"wav 路径:%@ \n 文件大小:%d",wavPath,(int)wavData.length);
    }
    
}

- (void)armToWavFileWithName:(NSString *)fileName
{
    NSString *wavPath = [self audioFilePathFromfileName:fileName withType:@"wav"];
    NSString *amrPath = [self audioFilePathFromfileName:fileName withType:@"amr"];
    [VoiceConverter amrToWav:amrPath wavSavePath:wavPath];
}


#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if (player == _player && _animationImageView)
    {
        [_animationImageView stopAnimating];
    }
}


@end
