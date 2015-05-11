//
//  ZJMultiMediaItem.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/25.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJMultiMediaItem.h"

@implementation ZJMultiMediaItem


- (instancetype)initWithItemImage:(NSString *)imageName withTitle:(NSString *)title
{
    if (self = [super init])
    {
        self.imageName = imageName;
        self.title = title;
    }
    return self;
}

- (void)dealloc
{
    self.imageName = nil;
    self.title = nil;
}

@end
