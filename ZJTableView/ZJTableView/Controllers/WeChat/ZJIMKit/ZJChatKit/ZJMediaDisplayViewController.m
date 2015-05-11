//
//  ZJMediaDisplayViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/29.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJMediaDisplayViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ZJMediaDisplayViewController ()

@property (copy, nonatomic) id <ZJMessageModel> message;

@property (nonatomic, strong) MPMoviePlayerController *moviePlayerController;

@property (nonatomic, strong) UIImageView *photoImageView;


@end


@implementation ZJMediaDisplayViewController


- (instancetype)initWithMessage:(id <ZJMessageModel>)message
{
    if (self = [super init])
    {
        _message = message;
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (_message.messageMediaType == ZJMessageMediaTypePhoto)
    {
        NSLog(@"图片路径：%@",_message.thumbnailPhotoPath);
        if(self.message.photo)
        {
            CGSize imageSize = self.message.photo.size;
            self.photoImageView.frame = ccr(0, 0, getW(self.view.frame), imageSize.height * getW(self.view.frame) / imageSize.width);
            self.photoImageView.center = self.view.center;
            self.photoImageView.image = self.message.photo;
            return;
        }
        else if (self.message.thumbnailPhotoPath)
        {
            if ([fileManager fileExistsAtPath:self.message.thumbnailPhotoPath])
            {
                float fileSize = [[fileManager attributesOfItemAtPath:self.message.thumbnailPhotoPath error:nil] fileSize];
                NSLog(@"图片大小：%.2fM",fileSize / (1024.0 * 1024.0));
            }
            UIImage *image = [UIImage imageWithContentsOfFile:self.message.thumbnailPhotoPath];
            self.photoImageView.image = image;
            self.photoImageView.frame = ccr(0, 0, getW(self.view.frame), image.size.height * getW(self.view.frame) / image.size.width);
            self.photoImageView.center = self.view.center;
        }
    }
    else if (_message.messageMediaType == ZJMessageMediaTypeVideo)
    {
//        NSString *path = [[NSBundle mainBundle]pathForResource:@"tempVideo" ofType:@"MOV"];
        if ([fileManager fileExistsAtPath:self.message.videoLocalPath])
        {
            float fileSize = [[fileManager attributesOfItemAtPath:self.message.videoLocalPath error:nil] fileSize];
            NSLog(@"视频大小：%.2fM",fileSize / (1024.0 * 1024.0));
        }
        self.moviePlayerController.contentURL = [NSURL fileURLWithPath:self.message.videoLocalPath];
        [self.moviePlayerController play];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self.message messageMediaType] == ZJMessageMediaTypeVideo)
    {
        [self.moviePlayerController stop];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_moviePlayerController stop];
    _moviePlayerController = nil;
    
    _photoImageView = nil;
}

#pragma mark - 
- (MPMoviePlayerController *)moviePlayerController
{
    if (!_moviePlayerController)
    {
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
        _moviePlayerController.repeatMode = MPMovieRepeatModeOne;
        _moviePlayerController.scalingMode = MPMovieScalingModeAspectFill;
        _moviePlayerController.view.frame = self.view.frame;
        [self.view addSubview:_moviePlayerController.view];
    }
    return _moviePlayerController;
}

- (UIImageView *)photoImageView
{
    if (!_photoImageView)
    {
        _photoImageView = [[UIImageView alloc]initWithFrame:self.view.frame];
        [self.view addSubview:_photoImageView];
    }
    return _photoImageView;
}

@end
