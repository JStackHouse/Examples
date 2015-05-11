//
//  ZJCommonDefine.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/16.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#ifndef ZJTableView_ZJCommonDefine_h
#define ZJTableView_ZJCommonDefine_h


#define ccr(__x,__y,__w,__h)    CGRectMake(__x,__y,__w,__h)
#define ccs(__w,__h)            CGSizeMake(__w,__h)
#define ccp(__x,__y)            CGPointMake(__x,__y)

#define getW(__bounds)          CGRectGetWidth(__bounds)
#define getH(__bounds)          CGRectGetHeight(__bounds)


// iPad
#define IsiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//系统版本
#define CURRENT_SYS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//图片背景适配
#define IMAGE_STRETCH(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])






//调试相关
#define IfDebug                         NO//YES
#define ChatTableViewSeparatorStyle     (IfDebug == YES ? UITableViewCellSeparatorStyleSingleLine :UITableViewCellSeparatorStyleNone)
#define BubbleBackgroundColor           (IfDebug == YES ? [UIColor orangeColor] : [UIColor clearColor])
#define TextBackgroundColor             (IfDebug == YES ? [UIColor grayColor] : [UIColor clearColor])


//微网定制
#define IfWenet                         NO//YES
#define AvatorSizeDefine                (IfWenet ? 0.0f : 40.0f)
#define messageTimeFontSize             (IfWenet == YES ? 9.0f : 9.0f)

#endif
