//
//  ZJNibCollectionViewCell.h
//  ZJTableView
//
//  Created by zhangjie on 14-4-21.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJNibCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) NSDictionary *cellInfo;

- (void)loadCell;

@end
