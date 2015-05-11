//
//  ZJAudioHud.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/24.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJAudioHud.h"
#import <QuartzCore/QuartzCore.h>



@implementation ZJAudioHud


const CGFloat hudSize = 140.0f;


static ZJAudioHud *audioHud = nil;
+ (instancetype)sharedAudioHud
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        audioHud = [[ZJAudioHud alloc]initWithFrame:ccr(0, 0, hudSize, hudSize)];
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:0];
        for (int i = 1; i < 5; i ++)
        {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"audioHud0%d",i]];
            if (image)
            {
                [images addObject:image];
            }
        }
        audioHud.image = [UIImage imageNamed:@"audioHud04"];
        audioHud.animationImages = images;
        audioHud.animationDuration = 1.0f;
        [audioHud stopAnimating];
        
        audioHud.layer.backgroundColor = [[UIColor blackColor]CGColor];
        audioHud.layer.cornerRadius = 10.0f;
    });
    return audioHud;
}


- (void)startHudAnimatingInView:(UIView *)view
{
    if (audioHud)
    {
        [audioHud removeFromSuperview];
        [view addSubview:audioHud];
        audioHud.center = view.center;
        [audioHud startAnimating];
    }
}

- (void)stopHudAnimating
{
    if (audioHud)
    {
        [audioHud stopAnimating];
        [audioHud removeFromSuperview];
    }
}



//- (instancetype)initWithFrame:(CGRect)frame inView:(UIView *)view
//{
//    if (self = [super initWithFrame:frame])
//    {
//        self.frame = ccr(0, 0, hudSize, hudSize);
//        [view addSubview:self];
//        self.center = view.center;
//    }
//    return self;
//}

@end
