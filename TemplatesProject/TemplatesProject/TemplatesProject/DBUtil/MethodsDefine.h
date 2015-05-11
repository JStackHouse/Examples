//
//  MethodsDefine.h
//  TemplatesProject
//
//  Created by zhangjie on 15/5/8.
//  Copyright (c) 2015年 stack. All rights reserved.
//

#ifndef TemplatesProject_MethodsDefine_h
#define TemplatesProject_MethodsDefine_h

/**
 * 方法的宏定义
 */

//打印日志相关
#define DebugLog(fmt, ...) NSLog((@"\n[文件名:%s]\n""[函数名:%s]\n""[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);

//颜色处理相关
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorWithRGB(r, g, b) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1.0f]

#define UIColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)]

//图片处理相关
#define ImageStretch(image, edgeInsets) (CURRENT_SYS_VERSION < 6.0 ? [image stretchableImageWithLeftCapWidth:edgeInsets.left topCapHeight:edgeInsets.top] : [image resizableImageWithCapInsets:edgeInsets resizingMode:UIImageResizingModeStretch])

#define LoadImage(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
#define LoadCatchImage(imageName)      [UIImage imageNamed:imageName]

//字体相关
#define Font(f)             [UIFont systemFontOfSize:f]

//文件路径相关
#define DocumentsPath     [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]


//Frame相关
#define ccr(__x,__y,__w,__h)    CGRectMake(__x,__y,__w,__h)
#define ccp(__x,__y)            CGPointMake(__x,__y)
#define ccs(__w,__h)            CGSizeMake(__w,__h)

#define getW(__bounds)          CGRectGetWidth(__bounds)
#define getH(__bounds)          CGRectGetHeight(__bounds)

#define ScreenHeight    [[UIScreen mainScreen]bounds].size.height
#define ScreenWidth     [[UIScreen mainScreen]bounds].size.width

//角度\弧度转换相关
#define DegreesToRadian(x)      (M_PI * (x) / 180.0)
#define RadianToDegrees(radian) (radian*180.0)/(M_PI)

//系统\硬件相关
//返回当前系统的整型值
#define SystemVersion   [[[UIDevice currentDevice] systemVersion] intValue]

//返回是否为ios7的布尔值
#define IOS7            SystemVersion == 7 ? YES : NO
//返回>=ios7的布尔值
#define IOS7ABOVE       SystemVersion >= 7 ? YES : NO
//返回是否为ios6的布尔值
#define IOS6            SystemVersion == 6 ? YES : NO


// 是否模拟器
#define isSimulator (NSNotFound != [[[UIDevice currentDevice] model] rangeOfString:@"Simulator"].location)
// 是否iPad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
// 是否iPad
#define someThing (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? ipad: iphone

#endif
