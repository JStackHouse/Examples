//
//  ZJMultiMediaView.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/25.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ZJMultiMediaViewDelegate <NSObject>

- (void)didSelecteMediaItem:(ZJMultiMediaItem *)item atIndexPath:(NSInteger)index;

@end


@interface ZJMultiMediaView : UIView <UIScrollViewDelegate>


@property (strong, nonatomic) NSArray *multiMediaItems;

@property (weak, nonatomic) id <ZJMultiMediaViewDelegate> delegate;


//调整布局
- (void)reloadData;


@end
