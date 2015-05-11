/*==============================================================*/
/* DBMS name:      MySQL 4.0                                    */
/* Created on:     2015-1-5 16:00:33                            */
/*==============================================================*/


drop index IDX_P_REC on P_RECORD;

drop index IDX_P_SESSION_MSG on P_SESSION_MSG;

drop table if exists P_CHILD_CLASS;

drop table if exists P_CLASS_M;

drop table if exists P_LATESTSESSION;

drop table if exists P_MYBZRCLASS;

drop table if exists P_MYCHILD;

drop table if exists P_MYPROFILE;

drop table if exists P_RECORD;

drop table if exists P_SESSION_M;

drop table if exists P_SESSION_MSG;

drop table if exists P_TXL_GROUP;

drop table if exists P_TXL_G_MEMBER;

/*==============================================================*/
/* Table: P_CHILD_CLASS 孩子的班级列表                            */
/*==============================================================*/
create table P_CHILD_CLASS
(
   CHILDID                        VARCHAR(50)                    not null,              //孩子ID
   CLZID                          VARCHAR(50)                    not null,              //班级ID
   SCHID                          VARCHAR(50)                    not null,              //学校ID
   TITLE                          VARCHAR(100)                   not null,              //班级名称
   SORTID                         INT                            not null default 0,    //排序
   primary key (CHILDID, CLZID)
);

/*==============================================================*/
/* Table: P_CLASS_M 班级成员列表                                  */
/*==============================================================*/
create table P_CLASS_M
(
   SID                            VARCHAR(50)                    not null,      //用户ID
   CLZID                          VARCHAR(50)                    not null,      //班级ID
   CHILDID                        VARCHAR(50)                    not null,      //学生ID
   STUNAME                        VARCHAR(50)                    not null,      //学生姓名
   QJTYPE                         SMALLINT,                                     //请假类型
   BJMX                           VARCHAR(200),                                 //病假明细
   SFJC                           int,                                          //是否就餐
   primary key (SID, CLZID)
);

/*==============================================================*/
/* Table: P_LATESTSESSION 最近会话列表                            */
/*==============================================================*/
create table P_LATESTSESSION
(
   SID                            VARCHAR(50)                    not null,              //用户ID
   SESSIONID                      VARCHAR(50)                    not null,              //会话ID
   TITLE                          VARCHAR(100)                   not null,              //最近会话标题
   MSGLABEL                       VARCHAR(100)                   not null,              //最后聊天内容摘要
   LASTTIME                       DATE                           not null,              //最后聊天时间
   UNREADS                        smallint unsigned              not null default 0,    //未读信息条数
   DIRECTION                      int                            not null,              //信息方向
   QUNID                          VARCHAR(100),                                         //群ID
   primary key (SID, SESSIONID)
);

/*==============================================================*/
/* Table: P_MYBZRCLASS 我担当班主任的班级                          */
/*==============================================================*/
create table P_MYBZRCLASS
(
   SID                            VARCHAR(50)                    not null,      //用户ID
   CLZID                          VARCHAR(50)                    not null,      //班级ID
   TITLE                          VARCHAR(100)                   not null,      //班级名称
   JOINCODE                       VARCHAR(50)                    not null,      //班级加入码
   primary key (SID, CLZID)
);

/*==============================================================*/
/* Table: P_MYCHILD 我的孩子信息                                  */
/*==============================================================*/
create table P_MYCHILD
(
   SID                            VARCHAR(50)                    not null,      //用户ID
   CHILDID                        VARCHAR(50)                    not null,      //孩子ID
   CHILDNAME                      VARCHAR(50)                    not null,      //孩子姓名
   SEX                            INT                            not null,      //孩子性别
   BIRTH                          DATE                           not null,      //孩子出生年月
   primary key (SID, CHILDID)
);

/*==============================================================*/
/* Table: P_MYPROFILE 个人配置                                   */
/*==============================================================*/
create table P_MYPROFILE
(
   SID                            VARCHAR(50)                    not null,              //用户ID
   TITLE                          VARCHAR(20)                    not null,              //姓名
   PHONE                          VARCHAR(12),                                          //手机号码
   TXLTIMEOUT                     int                            not null,              //通讯论超时时间
   TXLGETTIME                     int                            not null,              //通讯录上次更新时间
   ISCURRENT                      INT                            not null default 1,    //是否为当前登录用户
   DEVICEID                       VARCHAR(100)                   not null,              //设备ID
   LASTMSGID                      INT                            default 0,             //最后获取的一条信息ID
   primary key (SID)
);

/*==============================================================*/
/* Table: P_RECORD 成长脚印记录                                   */
/*==============================================================*/
create table P_RECORD
(
   RECID                          INT                            not null,              //记录ID
   SID                            VARCHAR(50)                    not null,              //用户ID
   RECCONTENT                     VARCHAR(1000)                  not null,              //记录内容
   RECTIME                        DATETIME                       not null,              //记录时间
   FROMER                         VARCHAR(20)                    not null,              //来自
   FROMTITLE                      VARCHAR(20),                                          //来自姓名
   STATUS                         smallint                       not null default 1,    //发送状态
   primary key (RECID)
);

/*==============================================================*/
/* Index: IDX_P_REC 在成长记录表上创建用户索引                      */
/*==============================================================*/
create index IDX_P_REC on P_RECORD
(
   SID
);

/*==============================================================*/
/* Table: P_SESSION_M 会话成员列表                                */
/*==============================================================*/
create table P_SESSION_M
(
   SID                            VARCHAR(50)                    not null,      //用户ID
   SESSIONID                      VARCHAR(50)                    not null,      //会话ID
   MEMBERID                       VARCHAR(50)                    not null,      //成员ID
   MEMBERNAME                     VARCHAR(100)                   not null,      //成员名称
   primary key (SID, SESSIONID, MEMBERID)
);

/*==============================================================*/
/* Table: P_SESSION_MSG 会话信息明细列表                           */
/*==============================================================*/
create table P_SESSION_MSG
(
   MSGID                          INT                            not null AUTO_INCREMENT,   //信息ID
   SID                            VARCHAR(50)                    not null,                  //用户ID
   SESSIONID                      VARCHAR(50)                    not null,                  //会话ID
   MSGCONTENT                     VARCHAR(1000)                  not null,                  //信息内容
   RECTIME                        DATETIME                       not null,                  //接收时间
   FROMER                         VARCHAR(50)                    not null,                  //来自成员
   STATUS                         smallint                       not null default 1,        //消息发送状态
   READED                         smallint                       default 1,                 //消息阅读标识
   QKEY                           VARCHAR(1000)                  not null,                  //检索时的KEY
   primary key (MSGID)
);

/*==============================================================*/
/* Index: IDX_P_SESSION_MSG                                     */
/*==============================================================*/
create index IDX_P_SESSION_MSG on P_SESSION_MSG
(
   SID,
   SESSIONID
);

/*==============================================================*/
/* Table: P_TXL_GROUP 通讯录组                                   */
/*==============================================================*/
create table P_TXL_GROUP
(
   SID                            VARCHAR(50)                    not null,              //用户ID
   GROUPID                        VARCHAR(50)                    not null,              //组ID
   TITLE                          VARCHAR(100)                   not null,              //组名称
   ISTEMP                         INT                            not null,              //是否为临时组
   SORTID                         INT                            not null default 0,    //显示顺序
   primary key (SID, GROUPID)
);

/*==============================================================*/
/* Table: P_TXL_G_MEMBER 通讯录组成员                             */
/*==============================================================*/
create table P_TXL_G_MEMBER
(
   SID                            VARCHAR(50)                    not null,      //用户ID
   GID                            VARCHAR(50)                    not null,      //组ID
   MEMBERID                       VARCHAR(50)                    not null,      //成员ID
   MEMBERNAME                     VARCHAR(50)                    not null,      //成员名称
   primary key (SID, GID, MEMBERID)
);

