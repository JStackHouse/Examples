//
//  ZJNewsTableViewCell.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/10.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJNewsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ZJNewsModel.h"
#import "ZJSubNewsView.h"
#import "ZJNewsCommonDefine.h"



@interface ZJNewsTableViewCell ()

@property (strong, nonatomic) UILabel *timeLabel;

@property (strong, nonatomic) UIView *newsView;

@property (strong, nonatomic) UIImageView *topNewsImageView;
@property (strong, nonatomic) UILabel *topNewsTitleLabel;


@property (strong, nonatomic) ZJNewsModel *newsModel;

@end


@implementation ZJNewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.newsView];
        
    }
    return self;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
        _timeLabel.center = CGPointMake(self.center.x, self.timeLabel.center.y);
        _timeLabel.layer.cornerRadius = 5.0f;
        _timeLabel.layer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        _timeLabel.alpha = 0.7f;
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:12.0f];
        
    }
    return _timeLabel;
}

- (UIImageView *)sepatorImageLineWithFrame:(CGRect)frame
{
    UIImageView *lineImageview = [[UIImageView alloc]initWithFrame:frame];
    lineImageview.backgroundColor = [UIColor lightGrayColor];
    lineImageview.alpha = 0.2f;
    return lineImageview;
}

- (UIView *)newsView
{
    if (!_newsView)
    {
        //固定3条新闻
        _newsView = [[UIView alloc]initWithFrame:CGRectMake(NEWS_OUT_MARGINS, NEWS_TIME_HEIGHT + NEWS_OUT_MARGINS, NEWS_VIEW_WIDTH, TOP_NEWS_HEIGHT + SUB_NEWS_HEIGHT * SUB_NEWS_COUNT + SUB_NEWS_IMAGE_VER_MARGINS)];
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithFrame:_newsView.bounds];
        backgroundImageView.image = IMAGE_STRETCH([UIImage imageNamed:@"NewsBackgroundImage"], UIEdgeInsetsMake(7, 7, 7, 7));
        [_newsView addSubview:backgroundImageView];
        
        [_newsView addSubview:self.topNewsImageView];
        [_newsView addSubview:self.topNewsTitleLabel];
       
        for (int i = 0; i < SUB_NEWS_COUNT; i ++)
        {
            [_newsView addSubview:[self sepatorImageLineWithFrame:CGRectMake(0, TOP_NEWS_HEIGHT + i * (SUB_NEWS_HEIGHT + 1), NEWS_VIEW_WIDTH, 1)]];
            
            ZJSubNewsView *subNewsView = [[ZJSubNewsView alloc]initWithFrame:CGRectMake(0, (TOP_NEWS_HEIGHT + 1)+ i * (SUB_NEWS_HEIGHT + 1), CGRectGetWidth(_newsView.frame), SUB_NEWS_HEIGHT)];
            subNewsView.tag = 10 + i;
            [subNewsView addTarget:self action:@selector(subNewsViewClick:) forControlEvents:UIControlEventTouchUpInside];
            [_newsView addSubview:subNewsView];
        }
        
    }
    return _newsView;
}

- (UIImageView *)topNewsImageView
{
    if (!_topNewsImageView)
    {
        _topNewsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(NEWS_INNER_HOR_MARGINS, NEWS_INNER_VER_MARGINS, TOP_NEWS_IMAGE_WIDTH, TOP_NEWS_IMAGE_HEIGHT)];
        //占位图片
        _topNewsImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *topNewsImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topNewsImageTap:)];
        [_topNewsImageView addGestureRecognizer:topNewsImageTap];
        _topNewsImageView.image = [UIImage imageNamed:@"NewsBackgroundImage"];
    }
    return _topNewsImageView;
}

- (UILabel *)topNewsTitleLabel
{
    if (!_topNewsTitleLabel)
    {
        _topNewsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(NEWS_INNER_HOR_MARGINS, NEWS_INNER_VER_MARGINS + CGRectGetHeight(_topNewsImageView.frame) - TOP_NEWS_LABEL_HEIGHT, CGRectGetWidth(_topNewsImageView.frame), TOP_NEWS_LABEL_HEIGHT)];
        _topNewsTitleLabel.layer.backgroundColor = [[UIColor blackColor] CGColor];;
        _topNewsTitleLabel.alpha = 0.9f;
        _topNewsTitleLabel.textAlignment = NSTextAlignmentCenter;
        _topNewsTitleLabel.textColor = [UIColor whiteColor];
        _topNewsTitleLabel.font = [UIFont boldSystemFontOfSize:17.0f];
    }
    return _topNewsTitleLabel;
}


//加载数据
- (void)loadCellInfo:(ZJNewsModel *)news
{
    _newsModel = news;
    _timeLabel.text = _newsModel.newsTime;
    [_topNewsImageView setImageWithURL:[NSURL URLWithString:_newsModel.topNewsImageUrl]];
    _topNewsTitleLabel.text = _newsModel.topNewsTitle;
    
    NSArray *subNewsDataSource = _newsModel.subNewsArray;
    for (int i = 0; i < subNewsDataSource.count; i ++)
    {
        UIView *subView = [_newsView viewWithTag:(10 + i)];
        if (subView && [subView isKindOfClass:[ZJSubNewsView class]])
        {
            ZJSubNewsModel *subViewInfo = subNewsDataSource[i];
            ZJSubNewsView *subNewsView = (ZJSubNewsView *)subView;
            [subNewsView loadSubNewsView:subViewInfo];
        }
    }
}

- (void)loadCellInfo:(ZJNewsModel *)news withNewsClickBlock:(NewsClickBlock)newsClick
{
    [self loadCellInfo:news];
    _newsClickBlock = newsClick;
}

//顶图新闻的点击事件
- (void)topNewsImageTap:(UITapGestureRecognizer *)tapGesture
{
    NSString *topNewsUrl = _newsModel.topNewsLinkUrl;
    if (topNewsUrl && NSOrderedSame != [@"" compare:topNewsUrl])
    {
        _newsClickBlock(topNewsUrl);
    }
}

//子新闻点击事件
- (void)subNewsViewClick:(id)sender
{
    ZJSubNewsView *subNewsView = (ZJSubNewsView *)sender;
    ZJSubNewsModel *subNewsModel = subNewsView.subNewsModel;
    NSString *subNewsUrl = subNewsModel.subNewsLinkUrl;
    if (subNewsUrl && NSOrderedSame != [@"" compare:subNewsUrl])
    {
        _newsClickBlock(subNewsUrl);
    }
}

@end
