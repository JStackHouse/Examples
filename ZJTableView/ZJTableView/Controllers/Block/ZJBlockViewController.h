//
//  ZJBlockViewController.h
//  ZJTableView
//
//  Created by zhangjie on 14-4-30.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ZJBlock)(NSString *str, BOOL bYes, NSInteger num);

@interface ZJBlockViewController : UIViewController

@property (strong, nonatomic) ZJBlock zjBlock;

- (void)transblock:(ZJBlock)aZjBlock;

@end
