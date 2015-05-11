//
//  ZJNewsViewController.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/10.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNewsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) UITableView *newsTableView;

@property (strong, nonatomic) NSArray *newsDataSource;

@end
