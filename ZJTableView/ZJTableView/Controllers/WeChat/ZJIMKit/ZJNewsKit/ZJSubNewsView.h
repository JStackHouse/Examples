//
//  ZJSubNewsView.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/10.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJSubNewsModel;

@interface ZJSubNewsView : UIButton


@property (strong, nonatomic) ZJSubNewsModel *subNewsModel;

- (void)loadSubNewsView:(ZJSubNewsModel *)subNewsInfo;

@end
