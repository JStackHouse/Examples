//
//  ZJWebViewController.h
//  ZJTableView
//
//  Created by zhangjie on 15/3/20.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJWebViewController : UIViewController

@property (strong, nonatomic) NSString *webPath;

- (void)nslogUrl:(NSString *)url;

@end
