//
//  ZJDBUtil.m
//  ZJTableView
//
//  Created by zhangjie on 15/1/14.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import "ZJDBUtil.h"
#import "AFHttpDefine.h"
#import "NSString+MD5.h"
#import "ZJVariablesUtil.h"
#import "ZJBusinessUtil.h"
#import "ZJMessageParseUtil.h"

@implementation ZJDBUtil

/**
 * EGODatabaseResult 中第一个columnString的值
 *
 * @param result        数据库查询结果
 * @param columnString  字段key
 */
+ (NSString *)firstResultStringFrom:(EGODatabaseResult *)result withColumn:(NSString *)columnString
{
    if (!result || 0 == result.count)
        return nil;
    EGODatabaseRow *row = [result rowAtIndex:0];
    NSString *string = [row stringForColumn:columnString];
    return string;
}

//查询当前登录的个人信息
+ (MyProfile *)myProfileWithCurrentUser
{
    NSLOG_STRING(@"查询当前登录的个人信息");
    EGODatabase *db = [ZJDBBase initDatabase];
    @try {
        NSString *sql = @"select SID,TXLGETTIME from P_MYPROFILE where ISCURRENT = 1";
        
        EGODatabaseResult *myProfileResult = [db executeQuery:sql];
        
        if (1 == myProfileResult.count)
        {
            EGODatabaseRow *row = myProfileResult.firstRow;
            MyProfile *profile = [[MyProfile alloc]init];
            profile.sid = [row stringForColumn:@"SID"];
            profile.txlGetTime = [row intForColumn:@"TXLGETTIME"];
            return profile;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    return nil;
}

/**
 * P_MYPROFILE  更新用户基本信息
 *
 * @param userInfo  用户基本信息
 */
+ (BOOL)updateUserInfo:(NSDictionary *)userInfo
{
//    {
//        hzphone = 18651655260;
//        i = "Fm9GQFxOX18=";
//        p = 18651655260;
//        pushid = "PUSHID_9";
//        retval = 1;
//        t = zhangjie;
//        txl =     (
//        );
//    }
    
    NSLOG_STRING(@"更新用户基本信息");
    BOOL bOk = YES;
    EGODatabase *dataBase = [ZJDBBase initDatabase];
    [dataBase open];
   @try {
        NSString *sid = userInfo[@"i"];
        NSString *title = userInfo[@"t"];
        NSString *phone = userInfo[@"p"];
        NSString *hzPhone = userInfo[@"hzphone"];
        NSString *pushId = userInfo[@"pushid"];
        
        //查询当前用户是否已经登陆过
        NSString *querySql = [NSString stringWithFormat:@"select SID from P_MYPROFILE where SID = '%@'",sid];
        EGODatabaseResult *queryResult = [dataBase executeQuery:querySql];
        
        //把所有人的都置为非当前用户
        NSString *unCurrentSql = @"update P_MYPROFILE set ISCURRENT = 0 where ISCURRENT = 1";
       
       [dataBase executeUpdate:@"BEGIN"];
       [dataBase executeUpdate:unCurrentSql];
       
        if (0 == queryResult.count)
        {
#warning deviceId
            NSString *deviceId = @"";//[[ZJVariablesUtil sid] md5];
            //插入新用户信息
            NSString *sql = [NSString stringWithFormat:@"insert into P_MYPROFILE(SID,TITLE,PHONE,TXLTIMEOUT,TXLGETTIME,ISCURRENT,DEVICEID,LASTMSGID) values ('%@','%@','%@','%@','%@','%@','%@','%@')",sid,title,phone,@"0",@"0",@"1",deviceId,@"0"];
            [dataBase executeUpdate:sql];
        }
        else
        {
            NSString *sql = [NSString stringWithFormat:@"update P_MYPROFILE set TITLE = '%@',PHONE = '%@',ISCURRENT = 1",title,phone];
            [dataBase executeUpdate:sql];
        }
       [dataBase executeUpdate:@"COMMIT"];
       
        //批量插入测试
        [self multiInsertTest];
        
        //记录当前用户是不是户主
        BOOL isHz = NSOrderedSame == [phone compare:hzPhone] ? YES : NO;
       [ZJVariablesUtil setIsHz:isHz];
        //设置户主号码
       [ZJVariablesUtil setHzPhone:hzPhone];
        //保存当前用户的PUSHID
       [ZJVariablesUtil setPushId:pushId];
    }
    @catch (NSException *exception) {
        NSString *str = [NSString stringWithFormat:@"更新用户基本信息 DB error:%@", exception.reason];
        NSLOG_STRING(str);
        [dataBase executeUpdate:@"ROLLBACK"];
        bOk = NO;
    }
    @finally {
        [dataBase close];
        return bOk;
    }
}

/**
 * 批量插入测试
 */
+ (void)multiInsertTest
{
    NSLOG_STRING(@"批量插入测试");
    NSString *testSql = @"insert  into P_MYBZRCLASS(SID,CLZID,TITLE,JOINCODE) values ('3','33','333','3333')";
//    NSString *testSql =@"insert  into P_MYBZRCLASS(SID,CLZID,TITLE,JOINCODE) values ('2','22','222','2222')"
//    "insert  into P_MYBZRCLASS(SID,CLZID,TITLE,JOINCODE) values ('3','33','333','3333')"
//    "insert  into P_MYBZRCLASS(SID,CLZID,TITLE,JOINCODE) values ('4','44','444','4444')";
    
    EGODatabase *db = [ZJDBBase initDatabase];
    [db open];
    @try {
        [db executeUpdate:@"BEGIN"];
        [db executeUpdate:testSql];
        [db executeUpdate:@"COMMIT"];
    }
    @catch (NSException *exception) {
        NSLog(@"multiInsertTest error is %@",exception.reason);
        [db executeUpdate:@"ROLLBACK"];
    }
    @finally {
        [db close];
    }
    
    
    
    
//    EGODatabase *dataBase = [ZJDBBase initDatabase];
//    [dataBase executeUpdate:@"BEGIN"];
//    [dataBase executeUpdate:testSql];
//    [dataBase executeUpdate:@"COMMIT"];
//    [dataBase close];
    //NSLog(@"批量插入 %@",[ZJDBBase executeUpdateWithSql:testSql andParameters:nil] ? @"成功": @"失败");
}

/**
 * 数据库会话表整理
 */
+ (void)cleanUpSession
{
    if (![ZJVariablesUtil sid])
        return;
    EGODatabase *dataBase = [ZJDBBase initDatabase];
    [dataBase open];
    @try {
        //获取所有没有未读信息的会话列表
        NSString *readSessionSql = [NSString stringWithFormat:@"select SESSIONID from P_LATESTSESSION where SID = '%@' and UNREADS = 0 order by LASTTIME desc",[ZJVariablesUtil sid]];
        EGODatabaseResult *readSessionResult = [dataBase executeQuery:readSessionSql];
        [dataBase executeUpdate:@"BEGIN"];
        for (int i = 0; i < readSessionResult.count; i ++)
        {
            EGODatabaseRow *session = [readSessionResult rowAtIndex:i];
            NSString *sessionId = [session stringForColumn:@"SESSIONID"];
            if (i < 100)//前100条会话
            {
                NSString *msgIdSql = [NSString stringWithFormat:@"select MSGID from P_SESSION_MSG where SID = '%@' and SESSIONID = '%@' order by MSGID asc",[ZJVariablesUtil sid],sessionId];
                EGODatabaseResult *msgIdResult = [dataBase executeQuery:msgIdSql];
                if (msgIdResult.count > 300)//如果该会话信息条数大于300,则删除老的消息
                {
                    for (int j = 0; j < msgIdResult.count - 300; j ++)
                    {
                        EGODatabaseRow *msg = [msgIdResult rowAtIndex:j];
                        NSString *msgId = [msg stringForColumn:@"MSGID"];
                        NSString *deleteMsgSql = [NSString stringWithFormat:@"delete from P_SESSION_MSG where = '%@'",msgId];
                        [dataBase executeUpdate:deleteMsgSql];
                    }
                }
            }
            else//100条以后会话，直接删除
            {
                //删除会话的消息
                NSString *deleteMsgSql = [NSString stringWithFormat:@"delete from P_SESSION_MSG where SESSIONID = '%@'",sessionId];
                [dataBase executeUpdate:deleteMsgSql];
                //删除会话成员
                NSString *deleteSessionMemberSql = [NSString stringWithFormat:@"delete from P_SESSION_M where SID = '%@' and SESSIONID = '%@'",[ZJVariablesUtil sid],sessionId];
                [dataBase executeUpdate:deleteSessionMemberSql];
                //删除该会话
                NSString *deleteSessionSql = [NSString stringWithFormat:@"delete from P_LATESTSESSION where SESSIONID = '%@'",sessionId];
                [dataBase executeUpdate:deleteSessionSql];
                //删除相关资源文件
#warning 删除相关资源文件 需补充
            }
        }
        [dataBase executeUpdate:@"COMMIT"];
    }
    @catch (NSException *exception) {
        NSString *str = [NSString stringWithFormat:@"数据库会话表整理 DB error:%@", exception.reason];
        NSLOG_STRING(str);
        [dataBase executeUpdate:@"ROLLBACK"];
    }
    @finally {
        [dataBase close];
    }
}


/**
 * 通讯录整理
 *
 * @param loginInfo 登录信息
 */
+ (void)cleanUpTxlWithLoginInfo:(NSDictionary *)loginInfo
{
    EGODatabase *dataBase = [ZJDBBase initDatabase];
    [dataBase open];
    NSTimeInterval currentTime = [[NSDate date]timeIntervalSince1970];
    //如果是在60秒之前刚刚执行过，不要再次执行
    if ([ZJVariablesUtil lastTxlTime] + 60 > currentTime)
    {
        return;
    }
    
    @try {
        [dataBase executeUpdate:@"BEGIN"];
        NSString *sid = loginInfo[@"i"];
        //清除以前信息
        NSString *deleteChildSql = [NSString stringWithFormat:@"delete from P_MYCHILD where SID = '%@'",sid];
        [dataBase executeUpdate:deleteChildSql];
        
        //处理孩子信息
        NSArray *children = loginInfo[@"chs"];
        if (children && 0 != children.count)
        {
            for (NSDictionary *childInfo in children)
            {
                NSString *childId = childInfo[@"i"];
                NSString *childName = childInfo[@"u"];
#warning BIRTH 数据如何取
//                NSString *addChildSql = [NSString stringWithFormat:@"insert into P_MYCHILD(SID,CHILDID,CHILDNAME,SEX,BIRTH) values ('%@','%@','%@','%@','%@')",sid,childId,childName,@""];
                NSString *addChildSql = [NSString stringWithFormat:@"insert into P_MYCHILD(SID,CHILDID,CHILDNAME,SEX) values ('%@','%@','%@','%@')",sid,childId,childName,@"0"];
                [dataBase executeUpdate:addChildSql];
                
                
                //处理班级列表
                //清除之前的班级列表信息
                NSString *deleteChildClassSql = [NSString stringWithFormat:@"delete from P_CHILD_CLASS where CHILDID = '%@'",childId];
                [dataBase executeUpdate:deleteChildClassSql];
                
                NSArray *classes = childInfo[@"cs"];
                if (classes && 0 != classes.count)
                {
                    //插入班级列表
                    for (int j = 0; j < classes.count; j ++)
                    {
                        NSDictionary *classInfo = classes[j];
                        NSString *addClassSql = [NSString stringWithFormat:@"insert into P_CHILD_CLASS(CHILDID,CLZID,SCHID,TITLE,SORTID) values('%@','%@','%@','%@','%@')",childId,classInfo[@"i"],classInfo[@"si"],classInfo[@"t"],@"0"];
                        [dataBase executeUpdate:addClassSql];
                    }
                }

            }
        }
        
        //担任的班级信息
        //清除历史班级信息
        NSString *deleteMyBZRClassSql = [NSString stringWithFormat:@"delete from P_MYBZRCLASS where SID = '%@'",sid];
        [dataBase executeUpdate:deleteMyBZRClassSql];
        NSString *deleteClassMemberSql = [NSString stringWithFormat:@"delete from P_CLASS_M where SID = '%@'",sid];
        [dataBase executeUpdate:deleteClassMemberSql];
        
        NSArray *bzrClasses = loginInfo[@"mc"];
        if (bzrClasses && 0 != bzrClasses.count)
        {
            for (int i = 0; i < bzrClasses.count; i ++)
            {
                NSDictionary *bzrClassInfo = bzrClasses[i];
                NSString *bzrClassId = bzrClassInfo[@"i"];
                NSString *addBZRClassSql = [NSString stringWithFormat:@"insert into P_MYBZRCLASS(SID,CLZID,TITLE,JOINCODE) values('%@','%@','%@','%@')",sid,bzrClassId,bzrClassInfo[@"t"],bzrClassInfo[@"jc"]];
                [dataBase executeUpdate:addBZRClassSql];
                
                //处理班级成员
                NSArray *classMembers = bzrClassInfo[@"ms"];
                if (classMembers)
                {
                    for (NSDictionary *classMember in classMembers)
                    {
                        NSString *addClassMemberSql = [NSString stringWithFormat:@"insert into P_CLASS_M(SID,CLZID,CHILDID,STUNAME) values('%@','%@','%@','%@')",sid,bzrClassId,classMember[@"i"],classMember[@"t"]];
                        [dataBase executeUpdate:addClassMemberSql];
                    }
                }
            }
        }

        //处理通信录信息
        //清除历史通信录
        NSString *deleteTxlGroupSql = [NSString stringWithFormat:@"delete from P_TXL_GROUP where SID = '%@'",sid];
        [dataBase executeUpdate:deleteTxlGroupSql];
        
        NSString *deleteTxlMemberSql = [NSString stringWithFormat:@"delete from P_TXL_G_MEMBER where SID = '%@'",sid];
        [dataBase executeUpdate:deleteTxlMemberSql];
        
        NSArray *groups = loginInfo[@"txl"];
        if (groups)
        {
            for (NSDictionary *group in groups)
            {
                NSString *groupId = group[@"i"];
#warning SORTID 表中字段与java接口中不一致，需确认
                NSString *addGroupSql = [NSString stringWithFormat:@"insert into P_TXL_GROUP(SID,GROUPID,TITLE,ISTEMP,SORTID) values('%@','%@','%@','%@','%@')",sid,groupId,group[@"t"],group[@"tmp"],group[@"sortid"]];
                [dataBase executeUpdate:addGroupSql];
                NSArray *members = group[@"ms"];
                if (members)
                {
                    for (NSDictionary *memberInfo in members)
                    {
#warning SORTID 表中字段与java接口中不一致，需确认
                        NSString *addMemberSql = [NSString stringWithFormat:@"insert into P_TXL_G_MEMBER(SID,GID,MEMBERID,MEMBERNAME) values('%@','%@','%@','%@')",sid,groupId,memberInfo[@"i"],memberInfo[@"t"]];
                        [dataBase executeUpdate:addMemberSql];
                    }
                }
           }
        }
        
        //更新通信录最后获取时间,取分钟即可
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
        NSDate *currentDate = [dateFormatter dateFromString:currentDateString];
        NSString *txlUpdateTimeSql =[NSString stringWithFormat:@"update P_MYPROFILE set TXLGETTIME = %@ where SID = '%@'",currentDate,sid];
        [dataBase executeUpdate:txlUpdateTimeSql];
        [dataBase executeUpdate:@"COMMIT"];
        //记录最后一次成功执行时间
        NSTimeInterval currentTimeInterval = [[NSDate date] timeIntervalSince1970];
        [ZJVariablesUtil setLastTxlTime:currentTimeInterval];
        //通信录已经加载
        [ZJVariablesUtil setTxlLoaded:YES];
        
    }
    @catch (NSException *exception) {
        NSString *str = [NSString stringWithFormat:@"整理通讯录 DB error:%@", exception.reason];
        NSLOG_STRING(str);
        [dataBase executeUpdate:@"ROLLBACK"];
    }
    @finally {
        [dataBase close];
    }
}


/**
 * 新信息处理
 *
 * @param newMsgs   未读信息
 */
+ (void)handleNewMsgsWithNewMsgs:(NSDictionary *)newMsgsInfo
{
    NSArray *msgs = newMsgsInfo[@"msgs"];
    if (msgs || 0 == msgs.count)
        return;
    
    EGODatabase *dataBase = [ZJDBBase initDatabase];
    [dataBase open];
    NSString *sid = [ZJVariablesUtil sid];
    NSString *lastMsgId = @"";
    @try {
        [dataBase executeUpdate:@"BEGIN"];
        BOOL bHasNewRecord = NO;
        
        for (NSDictionary *msgInfo in msgs)
        {
            NSString *msgId = msgInfo[@"id"];
            lastMsgId = msgId;
            NSDictionary *content = msgInfo[@"msgcontent"];
            //处理成长记录
            if (NSOrderedSame == [@"rec" compare:[content[@"at"]lowercaseString]])
            {
                NSString *sender = msgInfo[@"sender"];
                NSString *senderName = msgInfo[@"sendername"];
                //来自人姓名
                NSString *realSenderName = @"";
                NSString *selectMemberNameSql = [NSString stringWithFormat:@"select MEMBERNAME from P_TXL_G_MEMBER where SID= '%@' and MEMBERID = '%@' order by SORTID desc",sid,sender];
                EGODatabaseResult *selectMemberNameResult = [dataBase executeQuery:selectMemberNameSql];
                if (0 == selectMemberNameResult.count)
                    realSenderName = senderName;
                else
                {
                    NSString *tempSenderName = [[selectMemberNameResult rowAtIndex:0] stringForColumn:@"MEMBERNAME"];
                    if (NSOrderedSame == [tempSenderName compare:@""])
                        realSenderName = senderName;
                    else
                        realSenderName = tempSenderName;
                }
                //插入到记录册
                NSString *addRecordSql = [NSString stringWithFormat:@"insert into P_RECORD(SID,RECCONTENT,RECTIME,FROMER,FROMTITLE) values('%@','%@',%@,'%@','%@')",sid,[content JSONString],[NSDate date],sender,realSenderName];
                [dataBase executeUpdate:addRecordSql];
                bHasNewRecord = YES;
                //通知UI进行相关处理
#warning 补充
            }
            //普通消息
            else
            {
                NSString *msgType = [content[@"type"]lowercaseString];
                //if (NSOrderedSame == [@"cmd" compare:msgType])
                if (MessageTypeCmd == [ZJMessageParseUtil parseMessageType:msgType])
                {
                    NSString *cmdString = content[@"msg"];
                    //信息以logout:开头，则强制退出
                    if ([cmdString hasPrefix:@"logout:"])
                    {
                        NSString *sendToken = [cmdString substringFromIndex:@"logout:".length];
                        //检查是否为当前用户发布的，如果不是，则强制退出
                        NSString *deviceIdSql = [NSString stringWithFormat:@"selelct DEVICEID from P_MYPROFILE where SID = '%@'",sid];
                        EGODatabaseResult *deviceIdResult = [dataBase executeQuery:deviceIdSql];
                        NSString *currentToken = [self firstResultStringFrom:deviceIdResult withColumn:@"DEVICEID"];
                        if (currentToken && NSOrderedSame != [currentToken compare:sendToken])
                        {
                            //登出的回调
#warning 登出的回调
                        }
                        
                    }
                    else if ([cmdString hasPrefix:@"getuserlogin:"])
                    {
                        //刷新通信录
                        [ZJBusinessUtil txlWithUserLogin];
                    }
                }
                else
                {
                    NSString *sender = msgInfo[@"sender"];
                    NSString *scratch = msgInfo[@"scratch"];
                    NSString *inGroupId = msgInfo[@"ingroupid"];
                    NSString *qunId = msgInfo[@"qunId"];
                    if (!qunId)
                        qunId = @"";
                    NSString *senderName = msgInfo[@"sendername"];
                    NSString *realSenderName = @"";
                    
                    //从给定组中查找人名
                    if (NSOrderedSame != [@"" compare:inGroupId])
                    {
                        NSString *selectMemberNameSql = [NSString stringWithFormat:@"select MEMBERNAME from P_TXL_G_MEMBER where SID = '%@' and GID = '%@' and MEMBERID = '%@'",sid,inGroupId,sender];
                        EGODatabaseResult *selectMemberNameResult = [dataBase executeQuery:selectMemberNameSql];
                        realSenderName = [self firstResultStringFrom:selectMemberNameResult withColumn:@"MEMBERNAME"];
                    }
                    //从整个通信录中查找人名
                    if (!realSenderName || NSOrderedSame == [@"" compare:realSenderName])
                    {
                        NSString *selectMemberNameSql = [NSString stringWithFormat:@"select MEMBERNAME from P_TXL_G_MEMBER where SID = '%@' and MEMBERID = '%@'",sid,sender];
                        EGODatabaseResult *selectMemberNameResult = [dataBase executeQuery:selectMemberNameSql];
                        realSenderName = [self firstResultStringFrom:selectMemberNameResult withColumn:@"MEMBERNAME"];
                    }
                    if (!realSenderName || NSOrderedSame == [@"" compare:realSenderName])
                    {
                        if (NSOrderedSame != [@"" compare:scratch])
                            realSenderName = scratch;
                        else
                            realSenderName = senderName;
                    }
                    
                    //处理消息
                    //计算会话ID
                    NSString *sessionId = @"";
                    if (qunId && NSOrderedSame != [@"" compare:qunId])
                    {
                        sessionId = [ZJBusinessUtil calSessionIdWithIds:@[qunId]];
                    }
                    else
                    {
                        sessionId = [ZJBusinessUtil calSessionIdWithIds:@[sender]];
                    }
                    NSString *msgType = [content[@"type"]lowercaseString];
                    NSString *msgLabelString = [ZJMessageParseUtil parseShortMsg:msgType withContent:content];
                    
                    //如果是在群里面聊，前面加上来自谁
                    if (NSOrderedSame != [@"" compare:qunId])
                    {
                        msgLabelString = [NSString stringWithFormat:@"%@:%@",realSenderName,msgLabelString];
                    }
                    if (msgLabelString.length > 50)
                    {
                        msgLabelString = [[msgLabelString substringToIndex:50]stringByAppendingString:@"..."];
                    }
                    
                    //检查该会话是不是第一次
                    NSString *latestSessionSql = [NSString stringWithFormat:@"select * from P_LATESTSESSION where SID = '%@' and SESSIONID = '%@'",sid,sessionId];
                    EGODatabaseResult *latestSessionResult = [dataBase executeQuery:latestSessionSql];
                    //不存在
                    if (0 == latestSessionResult.count)
                    {
                        //插入会话
                        NSString *addLatestSessionSql = [NSString stringWithFormat:@"insert into P_LATESTSESSION(SID,SESSIONID,TITLE,MSGLABEL,LASTTIME,UNREADS,DIRECTION,QUNID) values('%@','%@','%@','%@',%@,1,0,'%@')",sid,sessionId,realSenderName,msgLabelString,[NSDate date],qunId];
                        [dataBase executeUpdate:addLatestSessionSql];
                        
                        //插入会话成员
                        NSString *addSessionMemberSql = [NSString stringWithFormat:@"insert into P_SESSION_M(SID,SESSIONID,MEMBERID,MEMBERNAME) values('%@','%@','%@','%@')",sid,sessionId,sender,realSenderName];
                        [dataBase executeUpdate:addSessionMemberSql];
                    }
                    else
                    {
                        //更新会话
                        NSString *updateLatestSessionSql = [NSString stringWithFormat:@"update P_LATESTSESSION set TITLE = '%@' and MSGLABEL = '%@' and LASTTIME = %@ and UNREADS = UNREADS+1 and DIRECTION = 0 and QUNID = '%@' where SID = '%@' and SESSIONID = '%@'",realSenderName,msgLabelString,[NSDate date],qunId,sid,sessionId];
                        [dataBase executeUpdate:updateLatestSessionSql];
                    }
                    
                    //插入信息,信息标志为未读
                    NSString *qKey = [msgLabelString stringByAppendingString:realSenderName];
                    NSString *addSessionMsgSql = [NSString stringWithFormat:@"insert into P_SESSION_MSG(SID,SESSIONID,MSGCONTENT,RECTIME,FROMER,READED,QKEY) values('%@','%@','%@','%@','%@','%d','%@')",sid,sessionId,content,[NSDate date],sender,0,qKey];
                    [dataBase executeUpdate:addSessionMsgSql];
                }
            }
            
        }
        
        [dataBase executeUpdate:@"COMMIT"];
        
        [ZJVariablesUtil setLastMsgId:lastMsgId];
        
        //是否有新的成长记录信息,供界面显示提示标志
        if (bHasNewRecord)
        {
            [ZJVariablesUtil setHasNewRecord:YES];
        }
        
#warning 通知界面做相关处理
        
        
    }
    @catch (NSException *exception) {
        NSString *str = [NSString stringWithFormat:@"新信息处理 DB error:%@", exception.reason];
        NSLOG_STRING(str);
        [dataBase executeUpdate:@"ROLLBACK"];
    }
    @finally {
        [dataBase close];
    }
    
    if (NSOrderedSame == [@"1" compare:newMsgsInfo[@"hasnewmsgs"]])
    {
        @try {
            [ZJBusinessUtil listNewMsgs];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
}

@end




