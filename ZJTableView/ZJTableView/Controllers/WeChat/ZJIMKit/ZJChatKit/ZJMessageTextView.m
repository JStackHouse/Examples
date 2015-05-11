//
//  ZJMessageTextView.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/18.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJMessageTextView.h"

@implementation ZJMessageTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.returnKeyType = UIReturnKeySend;
        self.enablesReturnKeyAutomatically = YES;
        
        self.font = [UIFont systemFontOfSize:15.0f];
        self.textAlignment = NSTextAlignmentLeft;
        self.textColor = [UIColor blackColor];
    }
    return self;
}

@end
