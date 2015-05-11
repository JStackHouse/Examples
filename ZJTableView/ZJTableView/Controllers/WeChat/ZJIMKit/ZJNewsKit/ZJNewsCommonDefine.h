//
//  ZJNewsCommonDefine.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/10.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#ifndef ZJTableView_ZJNewsCommonDefine_h
#define ZJTableView_ZJNewsCommonDefine_h

#define SUB_NEWS_COUNT              3


//时间标题高度
#define NEWS_TIME_HEIGHT            20

//外部边距
#define NEWS_OUT_MARGINS            15
//内部水平边距
#define NEWS_INNER_HOR_MARGINS      10
//内部垂直边距
#define NEWS_INNER_VER_MARGINS      10

//整个新闻的宽度
#define NEWS_VIEW_WIDTH             (CGRectGetWidth([UIScreen mainScreen].bounds) - NEWS_OUT_MARGINS * 2)

//顶部新闻的高度
#define TOP_NEWS_HEIGHT             180
//顶图的宽度
#define TOP_NEWS_IMAGE_WIDTH        (CGRectGetWidth([UIScreen mainScreen].bounds) - NEWS_OUT_MARGINS * 2 - NEWS_INNER_HOR_MARGINS * 2)
//顶图的高度
#define TOP_NEWS_IMAGE_HEIGHT       (TOP_NEWS_HEIGHT - NEWS_INNER_VER_MARGINS * 2)
//顶部标题的高度
#define TOP_NEWS_LABEL_HEIGHT       30

//子新闻的高度
#define SUB_NEWS_HEIGHT             60
//子新闻的内边距
#define SUB_NEWS_INNER_MARGINS      10
//子新闻的标题宽度
#define SUB_NEWS_LABLE_WIDTH        (CGRectGetWidth([UIScreen mainScreen].bounds) - NEWS_OUT_MARGINS * 2 - NEWS_INNER_HOR_MARGINS * 3 - SUB_NEWS_IMAGE_HEIGHT)
//子新闻的标题高度
#define SUB_NEWS_LABLE_HEIGHT       (SUB_NEWS_HEIGHT - SUB_NEWS_INNER_MARGINS * 2)
//子新闻图片的垂直边距
#define SUB_NEWS_IMAGE_VER_MARGINS  5
//子新闻图片的高度
#define SUB_NEWS_IMAGE_HEIGHT       (SUB_NEWS_HEIGHT - SUB_NEWS_IMAGE_VER_MARGINS * 2)
//子新闻图片的宽度
#define SUB_NEWS_IMAGE_WIDTH        SUB_NEWS_IMAGE_HEIGHT



#endif
