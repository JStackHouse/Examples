//
//  ZJMultiMediaView.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/25.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJMultiMediaView.h"




@interface ZJMultiMediaView ()

@property (strong, nonatomic) UIScrollView *multiMediaScrollView;

@property (strong, nonatomic) UIPageControl *multiMediaPageControl;

@end

@implementation ZJMultiMediaView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initSubviews];
    }
    return self;
}

const CGFloat pageControlHeight = 30.0f;

- (void)initSubviews
{
    if (!_multiMediaScrollView)
    {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - pageControlHeight)];
        scrollView.delegate = self;
        scrollView.backgroundColor = self.backgroundColor;//[UIColor redColor];//self.backgroundColor;
        scrollView.pagingEnabled = YES;
        scrollView.bounces = YES;
        scrollView.alwaysBounceHorizontal = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
        _multiMediaScrollView = scrollView;
    }
    
    if (!_multiMediaPageControl)
    {
        UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMaxY(_multiMediaScrollView.frame), CGRectGetWidth(self.bounds), pageControlHeight)];
        pageControl.backgroundColor = [UIColor lightGrayColor];//self.backgroundColor;//[UIColor orangeColor];
        [self addSubview:pageControl];
        _multiMediaPageControl = pageControl;
    }
}

//
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview)
    {
        [self reloadData];
    }
}


const CGFloat paddingX = 16.0f;
const CGFloat paddingY = 10.0f;

const CGFloat itemWidth = 60.0f;
const CGFloat itemHeight = 80.0f;
const CGFloat titleHeight = 20.0f;

#define ItemColumNum    4
#define ItemRowNum      2

//调整布局
- (void)reloadData
{
    if (!self.multiMediaItems || 0 == self.multiMediaItems.count)
        return;
    
    [self.multiMediaScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    
    int pageNum = ceilf(self.multiMediaItems.count * 1.0f / (ItemColumNum * ItemRowNum));
    _multiMediaScrollView.contentSize = ccs(getW(self.bounds) * pageNum, getH(_multiMediaScrollView.frame));
    _multiMediaPageControl.numberOfPages = pageNum;
    
    for (int i = 0; i < self.multiMediaItems.count; i ++)
    {
        //int count = (int)self.multiMediaItems.count;
        int pageIndex = [self pageIndex:i];
        int rowIndex = [self rowIndex:i];
        int columIndex = [self columIndex:i];
        
        ZJMultiMediaItem *item = self.multiMediaItems[i];
        UIButton *imageButton = [[UIButton alloc]initWithFrame:ccr(pageIndex * getW(self.bounds) + + paddingX+ (paddingX + itemWidth) * columIndex, paddingX + (paddingY + itemHeight) * rowIndex, itemWidth, itemWidth)];
        imageButton.tag = i;
        [imageButton setImage:[UIImage imageNamed:item.imageName] forState:UIControlStateNormal];
        [imageButton addTarget:self action:@selector(multiMediaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:ccr(CGRectGetMinX(imageButton.frame), CGRectGetMaxY(imageButton.frame), getW(imageButton.frame), titleHeight)];
        titleLabel.text = item.title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor darkGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:12.0f];
        titleLabel.backgroundColor = self.backgroundColor;//[UIColor greenColor];
        
        [_multiMediaScrollView addSubview:imageButton];
        [_multiMediaScrollView addSubview:titleLabel];
    }
}

//哪一页
- (int)pageIndex:(int)index
{
    int minPageIndex = (index + 1) / (ItemColumNum * ItemRowNum);
    int pageIndex = (0 == (index + 1) % (ItemColumNum * ItemRowNum)) ? minPageIndex - 1 : minPageIndex;
    return pageIndex;
}

//哪一行
- (int)rowIndex:(int)index
{
    int realCount = index % (ItemColumNum * ItemRowNum) + 1;
    int minRow = realCount / ItemColumNum;
    int rowIndex = (0 == realCount % ItemColumNum) ? minRow - 1 : minRow;
    return rowIndex;
}

//哪一列
- (int)columIndex:(int)index
{
    int realCount = index % (ItemColumNum * ItemRowNum) + 1;
    int colum = realCount % ItemColumNum;
    int columIndex = (0 == colum) ? (ItemColumNum - 1) : (colum - 1);
    return columIndex;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int currentPageIndex = scrollView.contentOffset.x / getW(scrollView.frame);
    _multiMediaPageControl.currentPage = currentPageIndex;
}

#pragma mark - item click

- (void)multiMediaButtonClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    int tag = (int)button.tag;
    ZJMultiMediaItem *item = self.multiMediaItems[tag];
    //NSLog(@"Item title :%@",item.title);
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelecteMediaItem:atIndexPath:)])
    {
        [self.delegate didSelecteMediaItem:item atIndexPath:tag];
    }
}


@end
