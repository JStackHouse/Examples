//
//  ZJNewsTableViewCell.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/10.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NewsClickBlock)(NSString *newsUrl);

@class ZJNewsModel;

@interface ZJNewsTableViewCell : UITableViewCell

@property (strong, nonatomic) NewsClickBlock newsClickBlock;


- (void)loadCellInfo:(ZJNewsModel *)news;
- (void)loadCellInfo:(ZJNewsModel *)news withNewsClickBlock:(NewsClickBlock)newsClick;

@end
