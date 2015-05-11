//
//  ZJMultiMediaItem.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/25.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJMultiMediaItem : NSObject


@property (strong, nonatomic) NSString *imageName;

@property (strong, nonatomic) NSString *title;


- (instancetype)initWithItemImage:(NSString *)imageName withTitle:(NSString *)title;

@end
