//
//  ZJActivity.m
//  ZJTableView
//
//  Created by zhangjie on 14-4-25.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJActivity.h"

@interface ZJActivity ()

@property (strong, nonatomic) NSURL *url;

@end

@implementation ZJActivity


- (NSString *)activityType
{
//    NSLog(@"NSStringFromClass([self class]) is %@",NSStringFromClass([self class]));
    return NSStringFromClass([self class]);
}
- (NSString *)activityTitle
{
    NSLog(@"NSLocalizedStringFromTable is %@",NSLocalizedStringFromTable(@"open", @"ZJActivity", nil));
    return NSLocalizedStringFromTable(@"open", @"ZJActivity", nil);
}
- (UIImage *)activityImage
{
    return [UIImage imageNamed:@"icon-58.png"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    for (id activity in activityItems)
    {
        if ([activity isKindOfClass:[NSURL class]])
        {
            _url = activity;
            if ([[UIApplication sharedApplication] canOpenURL:activity])
                return YES;
            else
                return NO;
        }
    }
    return NO;
}

#pragma mark - 点击activity后触发下面三个方法
- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activity in activityItems)
    {
        if ([activity isKindOfClass:[NSURL class]])
        {
            _url = activity;
        }
    }
}

- (void)performActivity
{
    BOOL complete = [[UIApplication sharedApplication] openURL:_url];
    [self activityDidFinish:complete];
}
- (UIViewController *)activityViewController
{
//    NSLog(@"activityViewController is %@",activityViewController);
    return nil;
}
@end
