//
//  AFHttpInterfaceUtil.h
//  ZJTableView
//
//  Created by zhangjie on 15/1/6.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AFHttpInterfaceUtil : NSObject


/**
 * Json数据解析
 *
 * @param object 解析对象
 */
+ (NSDictionary *)jsonParseWithObject:(id)object;

/**
 * 判断是否token非法
 *
 * @param object    返回判断对象
 */
+ (BOOL)isAccessTokenLegal:(id)object;

/**
 * 获取access token
 *
 * 取到access token 需存入NSUserDefault
 */
+ (void)accessTokenWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 发送验证码给已经注册的号码
 *
 *  @param phoneNum 电话号码
 */
+ (void)sendYZM4RegedPhoneWithPhone:(NSString *)phoneNum
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;

/**
 * 发送验证码给未注册的号码
 *
 *  @param phoneNum 电话号码
 */
+ (void)sendYZM4UnRegedPhoneWithPhone:(NSString *)phoneNum
                            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;

/**
 * 判断号码是否已经注册
 *
 * @param phoneNum 电话号码
 */
+ (void)checkPhoneRegedWithPhone:(NSString *)phoneNum
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 获取添加家庭成员许可码
 */
+ (void)xkmOfAddingMemberWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 注册
 *
 * @param phoneNum  电话号码
 * @param userName  姓名
 * @param yzm       短信验证码MD5加密
 */
+ (void)regWithPhone:(NSString *)phoneNum
        withUserName:(NSString *)userName
             withYzm:(NSString *)yzm
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 获取用户配置
 */
+ (void)myProfileWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 登录
 *
 * @param phoneNum      电话号码
 * @param yzm           短信验证码
 * @param isFirstLogin  是否为第一次登录
 */
+ (void)loginByYzmWithPhone:(NSString *)phoneNum
                    withYzm:(NSString *)yzm
               isFirstLogin:(BOOL)isFirstLogin
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;




/**
 * 得到用户登录信息
 */
+ (void)userLoginWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 绑定孩子的接送卡
 *
 * @param childId       孩子ID
 * @param cardId        接送卡号
 * @param schId         学校ID
 * @param isAppendCard  是否是追加新卡，1 表示是，0表示否
 */
+ (void)bindCardWithChildId:(NSString *)childId
                     cardId:(NSString *)cardId
                   schoolId:(NSString *)schId
                   isAppend:(BOOL)isAppendCard
                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 获取孩子列表
 */
+ (void)listChildrenWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;

/**
 * 添加孩子信息
 *
 * @param childName 孩子姓名
 * @param sex       性别
 * @param birthday  出生年月
 * @param p2s       家长与孩子关系
 */
+ (void)addChildWithName:(NSString *)childName
                 withSex:(NSString *)sex
            withBirthday:(NSString *)birthday
                 withP2s:(NSString *)p2s
                 success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                 failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 加入班级
 *
 * @param childId   孩子ID
 * @param joinCode  班级加入码
 */
+ (void)joinClassWithChildId:(NSString *)childId
                withJoinCode:(NSString *)joinCode
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;



/**
 * 更换手机号码
 *
 * @param aNewPhone     新手机号码
 * @param yzm           短信验证码
 */
+ (void)changePhoneWithANewPhone:(NSString *)aNewPhone
                         withYzm:(NSString *)yzm
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 添加孩子其他家长
 *
 * @param parentPhone   家长号码
 * @param p2s           与孩子关系
 * @param xkm           许可码
 */
+ (void)addOtherParentWithParentPhone:(NSString *)parentPhone
                              withP2s:(NSString *)p2s
                              withXkm:(NSString *)xkm
                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 信息发送
 *
 * @param message   信息内容
 * @param scratch   信息签名
 * @param receivers 接收人列表
 */
+ (void)sendMsgWithMessageContent:(NSString *)message
                    withReceivers:(NSString *)receivers
                      withScratch:(NSString *)scratch
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 发送成长记录
 *
 * @param message   信息内容
 */
+ (void)sendRecordWithMessageContent:(NSString *)message
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 获取未读信息
 *
 * @param lastMessageId     最后一次得到的消息ID
 */
+ (void)listNewMsgsWithLastMsgId:(NSString *)lastMessageId
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;



/**
 * 文件上传
 *
 * @param fileData  文件对象
 * @param text      文本
 */
+ (void)uploadWithFile:(NSData *)fileData
              withText:(NSString *)text
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;

/**
 * 文件下载
 *
 * @param fileId  文件ID
 */
+ (void)fileWithFid:(NSString *)fileId
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 扫描登陆二维码
 *
 * @param logineToken  登陆令牌
 */
+ (void)returnQRCodeSMWithLoginToken:(NSString *)logineToken
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;

/**
 * 教师提交每日考勤确认信息
 *
 * @param   异常考勤明细
 */
+ (void)postDayKQWithYclb:(NSString *)yclb
                  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                  failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 多图信息发送
 *
 * @param files     文件对象，序号从0开始
 * @param scratch   信息签名
 * @param receivers 接收人列表
 */
+ (void)sendMsgPicsWithFiles:(NSArray *)files
                 withScratch:(NSString *)scratch
               withReceivers:(NSString *)receivers
                     success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                     failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


/**
 * 发送多图成长记录
 *
 * @param files     文件对象，序号从0开始
 */
+ (void)sendRecordPicsWithFiles:(NSArray *)files
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;


@end






