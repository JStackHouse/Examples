//
//  ZJNewsModel.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/10.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJNewsModel : NSObject

@property (strong, nonatomic) NSString *newsTime;

@property (strong, nonatomic) NSString *topNewsTitle;
@property (strong, nonatomic) NSString *topNewsImageUrl;
@property (strong, nonatomic) NSString *topNewsLinkUrl;

//存储ZJSubNewsModel对象
@property (strong, nonatomic) NSArray *subNewsArray;


@end

@interface ZJSubNewsModel : NSObject

@property (strong, nonatomic) NSString *subNewsTitle;
@property (strong, nonatomic) NSString *subNewsImageUrl;
@property (strong, nonatomic) NSString *subNewsLinkUrl;


@end
