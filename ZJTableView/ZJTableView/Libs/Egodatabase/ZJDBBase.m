//
//  ZJDBBase.m
//  ZJTableView
//
//  Created by zhangjie on 14-5-20.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJDBBase.h"
//#define DBPath      [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/interaction.db"]

@implementation ZJDBBase

+ (BOOL)launchDatabase
{
    NSLog(@"Documents path is %@",Documents);
    BOOL bLaunch = YES;
    NSFileManager *fileManeger = [[NSFileManager alloc]init];
    BOOL dbExist = [fileManeger fileExistsAtPath:DBFilePath];
    if (!dbExist)
    {
        EGODatabase *database = [self initDatabase];
        
        @try {
            [database executeUpdate:@"BEGIN"];
            //
            [database executeUpdate:@"drop table if exists P_CHILD_CLASS"];
            NSString *p_child_class_sql = @"CREATE TABLE P_CHILD_CLASS(CHILDID  VARCHAR(50) not null,CLZID VARCHAR(50) not null,SCHID VARCHAR(50) not null,TITLE VARCHAR(100) not null,SORTID INT not null default 0,primary key (CHILDID,CLZID))";
            [database executeUpdate:p_child_class_sql];
            //
            [database executeUpdate:@"drop table if exists P_CLASS_M"];
            NSString *p_class_m_sql = @"CREATE TABLE P_CLASS_M(SID VARCHAR(50) not null,CLZID VARCHAR(50) not null,CHILDID VARCHAR(50) not null,STUNAME VARCHAR(50) not null,QJTYPE SMALLINT,BJMX VARCHAR(200),SFJC int,primary key (SID, CLZID,CHILDID))";
            [database executeUpdate:p_class_m_sql];
            //
            [database executeUpdate:@"drop table if exists P_LATESTSESSION"];
            NSString *p_latestssion_sql = @"CREATE TABLE P_LATESTSESSION(SID VARCHAR(50) not null,SESSIONID VARCHAR(50) not null,TITLE VARCHAR(100) not null,MSGLABEL VARCHAR(100) not null,LASTTIME DATE not null,UNREADS smallint unsigned not null default 0,DIRECTION int not null,QUNID varchar(100),primary key (SID, SESSIONID))";
            [database executeUpdate:p_latestssion_sql];
            //
            [database executeUpdate:@"drop table if exists P_MYBZRCLASS"];
            NSString *p_mybzrclass_sql = @"CREATE TABLE P_MYBZRCLASS(SID VARCHAR(50) not null,CLZID VARCHAR(50) not null,TITLE VARCHAR(100) not null,JOINCODE varchar(50) not null,primary key (SID, CLZID))";
            [database executeUpdate:p_mybzrclass_sql];
            //
            [database executeUpdate:@"drop table if exists P_MYCHILD"];
            NSString *p_mychild_sql = @"CREATE TABLE P_MYCHILD(SID VARCHAR(50) not null,CHILDID VARCHAR(50) not null,CHILDNAME VARCHAR(50) not null,SEX INT not null,BIRTH DATE not null,primary key (SID, CHILDID))";
            [database executeUpdate:p_mychild_sql];
            //
            [database executeUpdate:@"drop table if exists P_MYPROFILE"];
            NSString *p_myprofile_sql = @"CREATE TABLE P_MYPROFILE(SID VARCHAR(50) not null,TITLE VARCHAR(20) not null,PHONE VARCHAR(12) not null,TXLTIMEOUT int not null,TXLGETTIME int not null,ISCURRENT INT not null default 1,DEVICEID VARCHAR(100) not null,LASTMSGID INT default 0,primary key (SID))";
            [database executeUpdate:p_myprofile_sql];
            //
            [database executeUpdate:@"drop table if exists P_RECORD"];
            NSString *p_record_sql = @"create table P_RECORD(RECID INTEGER PRIMARY KEY autoincrement not null,SID VARCHAR(50) not null,RECCONTENT VARCHAR(1000) not null,RECTIME DATETIME not null,FROMER VARCHAR(20) not null,FROMTITLE VARCHAR(20),STATUS smallint not null default 1)";
            [database executeUpdate:p_record_sql];
            //
            [database executeUpdate:@"create index IDX_P_REC on P_RECORD(SID)"];
            //
            [database executeUpdate:@"drop table if exists P_SESSION_M"];
            NSString *p_session_sql = @"CREATE TABLE P_SESSION_M(SID VARCHAR(50) not null,SESSIONID VARCHAR(50) not null,MEMBERID VARCHAR(50) not null,MEMBERNAME VARCHAR(100) not null,primary key (SID, SESSIONID, MEMBERID))";
            [database executeUpdate:p_session_sql];
            //
            [database executeUpdate:@"drop table if exists P_SESSION_MSG"];
            NSString *p_session_msg_sql = @"CREATE TABLE P_SESSION_MSG(MSGID INTEGER PRIMARY KEY autoincrement not null,SID VARCHAR(50) not null,SESSIONID VARCHAR(50) not null,MSGCONTENT VARCHAR(1000) not null,RECTIME DATETIME not null,FROMER VARCHAR(50) not null,STATUS smallint not null default 1,READED smallint not null default 1,QKEY VARCHAR(1000) not null)";
            [database executeUpdate:p_session_msg_sql];
            //
            [database executeUpdate:@"CREATE INDEX IDX_P_SESSION_MSG on P_SESSION_MSG(SID,SESSIONID)"];
            //
            [database executeUpdate:@"drop table if exists P_TXL_G_MEMBER"];
            NSString *p_txl_g_member_sql = @"CREATE TABLE P_TXL_G_MEMBER(SID VARCHAR(50) not null,GID VARCHAR(50) not null,MEMBERID VARCHAR(50) not null,MEMBERNAME VARCHAR(50) not null,SORTID INT not null default 0,primary key (SID, GID, MEMBERID))";
            [database executeUpdate:p_txl_g_member_sql];
            //
            [database executeUpdate:@"drop table if exists P_TXL_GROUP"];
            NSString *p_txl_group_sql = @"CREATE TABLE P_TXL_GROUP(SID VARCHAR(50) not null,GROUPID VARCHAR(50) not null,TITLE VARCHAR(100) not null,ISTEMP INT not null,SORTID INT not null default 0,primary key (SID, GROUPID))";
            [database executeUpdate:p_txl_group_sql];
            
            [database executeUpdate:@"COMMIT"];
            //NSLog(@"数据库表格创建%@",bLaunch ? @"成功" : @"失败");

        }
        @catch (NSException *exception) {
            [database executeUpdate:@"ROLLBACK"];            
        }
        @finally {
            
        }
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_CHILD_CLASS"];
//        NSString *p_child_class_sql = @"CREATE TABLE P_CHILD_CLASS(CHILDID  VARCHAR(50) not null,CLZID VARCHAR(50) not null,SCHID VARCHAR(50) not null,TITLE VARCHAR(100) not null,SORTID INT not null default 0,primary key (CHILDID,CLZID))";
//        bLaunch = bLaunch && [database executeUpdate:p_child_class_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_CLASS_M"];
//        NSString *p_class_m_sql = @"CREATE TABLE P_CLASS_M(SID VARCHAR(50) not null,CLZID VARCHAR(50) not null,CHILDID VARCHAR(50) not null,STUNAME VARCHAR(50) not null,QJTYPE SMALLINT,BJMX VARCHAR(200),SFJC int,primary key (SID, CLZID,CHILDID))";
//        bLaunch = bLaunch && [database executeUpdate:p_class_m_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_LATESTSESSION"];
//        NSString *p_latestssion_sql = @"CREATE TABLE P_LATESTSESSION(SID VARCHAR(50) not null,SESSIONID VARCHAR(50) not null,TITLE VARCHAR(100) not null,MSGLABEL VARCHAR(100) not null,LASTTIME DATE not null,UNREADS smallint unsigned not null default 0,DIRECTION int not null,QUNID varchar(100),primary key (SID, SESSIONID))";
//        bLaunch = bLaunch && [database executeUpdate:p_latestssion_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_MYBZRCLASS"];
//        NSString *p_mybzrclass_sql = @"CREATE TABLE P_MYBZRCLASS(SID VARCHAR(50) not null,CLZID VARCHAR(50) not null,TITLE VARCHAR(100) not null,JOINCODE varchar(50) not null,primary key (SID, CLZID))";
//        bLaunch = bLaunch && [database executeUpdate:p_mybzrclass_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_MYCHILD"];
//        NSString *p_mychild_sql = @"CREATE TABLE P_MYCHILD(SID VARCHAR(50) not null,CHILDID VARCHAR(50) not null,CHILDNAME VARCHAR(50) not null,SEX INT not null,BIRTH DATE not null,primary key (SID, CHILDID))";
//        bLaunch = bLaunch && [database executeUpdate:p_mychild_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_MYPROFILE"];
//        NSString *p_myprofile_sql = @"CREATE TABLE P_MYPROFILE(SID VARCHAR(50) not null,TITLE VARCHAR(20) not null,PHONE VARCHAR(12) not null,TXLTIMEOUT int not null,TXLGETTIME int not null,ISCURRENT INT not null default 1,DEVICEID VARCHAR(100) not null,LASTMSGID INT default 0,primary key (SID))";
//        bLaunch = bLaunch && [database executeUpdate:p_myprofile_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_RECORD"];
//        NSString *p_record_sql = @"create table P_RECORD(RECID INTEGER PRIMARY KEY autoincrement not null,SID VARCHAR(50) not null,RECCONTENT VARCHAR(1000) not null,RECTIME DATETIME not null,FROMER VARCHAR(20) not null,FROMTITLE VARCHAR(20),STATUS smallint not null default 1)";
//        bLaunch = bLaunch && [database executeUpdate:p_record_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"create index IDX_P_REC on P_RECORD(SID)"];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_SESSION_M"];
//        NSString *p_session_sql = @"CREATE TABLE P_SESSION_M(SID VARCHAR(50) not null,SESSIONID VARCHAR(50) not null,MEMBERID VARCHAR(50) not null,MEMBERNAME VARCHAR(100) not null,primary key (SID, SESSIONID, MEMBERID))";
//        bLaunch = bLaunch && [database executeUpdate:p_session_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_SESSION_MSG"];
//        NSString *p_session_msg_sql = @"CREATE TABLE P_SESSION_MSG(MSGID INTEGER PRIMARY KEY autoincrement not null,SID VARCHAR(50) not null,SESSIONID VARCHAR(50) not null,MSGCONTENT VARCHAR(1000) not null,RECTIME DATETIME not null,FROMER VARCHAR(50) not null,STATUS smallint not null default 1,READED smallint not null default 1,QKEY VARCHAR(1000) not null)";
//        bLaunch = bLaunch && [database executeUpdate:p_session_msg_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"CREATE INDEX IDX_P_SESSION_MSG on P_SESSION_MSG(SID,SESSIONID)"];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_TXL_G_MEMBER"];
//        NSString *p_txl_g_member_sql = @"CREATE TABLE P_TXL_G_MEMBER(SID VARCHAR(50) not null,GID VARCHAR(50) not null,MEMBERID VARCHAR(50) not null,MEMBERNAME VARCHAR(50) not null,SORTID INT not null default 0,primary key (SID, GID, MEMBERID))";
//        bLaunch = bLaunch && [database executeUpdate:p_txl_g_member_sql];
//        //
//        bLaunch = bLaunch && [database executeUpdate:@"drop table if exists P_TXL_GROUP"];
//        NSString *p_txl_group_sql = @"CREATE TABLE P_TXL_GROUP(SID VARCHAR(50) not null,GROUPID VARCHAR(50) not null,TITLE VARCHAR(100) not null,ISTEMP INT not null,SORTID INT not null default 0,primary key (SID, GROUPID))";
//        bLaunch = bLaunch && [database executeUpdate:p_txl_group_sql];
//      
//        NSLog(@"数据库表格创建%@",bLaunch ? @"成功" : @"失败");
    }
    //[fileManeger removeItemAtPath:DBFilePath error:nil];
    return bLaunch;
}


static EGODatabase *sharedDataBase = nil;
+ (id)initDatabase
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDataBase = [EGODatabase databaseWithPath:DBFilePath];
    });
    
    return sharedDataBase;
}

//+ (id)initDatabase
//{
//    EGODatabase *database = [EGODatabase databaseWithPath:DBFilePath];
//    if (database)
//        return database;
//    return nil;
//}


+(EGODatabaseResult*)executeQueryWithSql:(NSString *)sql andParameters:(NSArray *)arr
{
    EGODatabase *database = [self initDatabase];
    EGODatabaseResult *result = [database executeQuery:sql parameters:arr];
    return result;
}


+(BOOL)executeUpdateWithSql:(NSString *)sql andParameters:(NSArray *)arr
{
    EGODatabase *database = [self initDatabase];
    BOOL bOK = [database executeUpdate:sql parameters:arr];
    return  bOK;
}

@end
