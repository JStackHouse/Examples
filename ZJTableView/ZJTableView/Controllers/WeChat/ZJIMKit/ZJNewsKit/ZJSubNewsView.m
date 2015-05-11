//
//  ZJSubNewsView.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/10.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJSubNewsView.h"
#import "ZJNewsCommonDefine.h"
#import "ZJNewsModel.h"
#import "ZJNewsWebViewController.h"

@interface ZJSubNewsView ()

@property (strong, nonatomic) UILabel *subNewsTitleLabel;
@property (strong, nonatomic) UIImageView *subNewsImageView;


@end



@implementation ZJSubNewsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.subNewsTitleLabel];
        [self addSubview:self.subNewsImageView];
    }
    return self;
}

- (UILabel *)subNewsTitleLabel
{
    if (!_subNewsTitleLabel)
    {
        _subNewsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SUB_NEWS_INNER_MARGINS, SUB_NEWS_INNER_MARGINS, SUB_NEWS_LABLE_WIDTH, SUB_NEWS_LABLE_HEIGHT)];
        _subNewsTitleLabel.backgroundColor = [UIColor clearColor];
        _subNewsTitleLabel.textAlignment = NSTextAlignmentLeft;
        _subNewsTitleLabel.numberOfLines = 0;
        _subNewsTitleLabel.textColor = [UIColor blackColor];
        _subNewsTitleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    }
    return _subNewsTitleLabel;
}

- (UIImageView *)subNewsImageView
{
    if (!_subNewsImageView)
    {
        _subNewsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(NEWS_INNER_HOR_MARGINS * 2 + SUB_NEWS_LABLE_WIDTH, SUB_NEWS_IMAGE_VER_MARGINS, SUB_NEWS_IMAGE_WIDTH, SUB_NEWS_IMAGE_HEIGHT)];
        //占位图片
        _subNewsImageView.image = [UIImage imageNamed:@"NewsBackgroundImage"];
    }
    return _subNewsImageView;
}

- (void)loadSubNewsView:(ZJSubNewsModel *)subNewsInfo
{
    _subNewsModel = subNewsInfo;
    _subNewsTitleLabel.text = _subNewsModel.subNewsTitle;
    [_subNewsImageView setImageWithURL:[NSURL URLWithString:_subNewsModel.subNewsImageUrl]];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
