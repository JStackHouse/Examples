//
//  ZJDBBase.h
//  ZJTableView
//
//  Created by zhangjie on 14-5-20.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

//Documents目录
#define Documents       [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
//Images目录
#define Images          [Documents stringByAppendingPathComponent:@"Images"]
//.db
#define DBFilePath      [Documents stringByAppendingPathComponent:@"xhd.db"]

@interface ZJDBBase : NSObject

+ (BOOL)launchDatabase;

+ (id)initDatabase;

+(EGODatabaseResult*)executeQueryWithSql:(NSString *)sql andParameters:(NSArray *)arr;//查询操作

+(BOOL)executeUpdateWithSql:(NSString *)sql andParameters:(NSArray *)arr; //插入、更新、删除操作

@end
