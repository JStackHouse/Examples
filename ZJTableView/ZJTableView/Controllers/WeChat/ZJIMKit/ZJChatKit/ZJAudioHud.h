//
//  ZJAudioHud.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/24.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJAudioHud : UIImageView


+ (instancetype)sharedAudioHud;

- (void)startHudAnimatingInView:(UIView *)view;

- (void)stopHudAnimating;

@end
