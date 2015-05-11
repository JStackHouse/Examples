//
//  ZJNetworkingViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/5.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJNetworkingViewController.h"
#import "AFHttpUtil.h"
#import "AFHttpInterfaceUtil.h"
#import "AFHttpDefine.h"
#import "NSString+MD5.h"

#import "ZJBusinessUtil.h"
#import "ZJDBUtil.h"
#import "ZJVariablesUtil.h"


@interface ZJNetworkingViewController ()

@end

@implementation ZJNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //存入错误的token
    //[ZJVariablesUtil setAccessToken:@"531c404d059d15c9028c9cd1c366cf11"];
    
    
    //获取access token    √
    //[self accessToken];
    
    //发送验证码给已经注册的号码     √
    //[self sendYzm4RegedPhone];
    
    //发送验证码给未注册的号码      √
    //[self sendYzm4UnRegedPhone];

    //判断号码是否已经注册    √
    //[self checkPhoneReged];
    
    //获取添加家庭成员许可码   √
    //[self xkmOfAddingMember];
    
    //注册    √
    //[self registration];
    
    //登录，需要先调用接口给已注册用户发送验证码     √
    //[self login];
    
    //获取用户配置    √
    //[self myProfile];
    
    //得到用户登录信息      √
    //[self userLogin];
    
    //绑定孩子的接送卡      √
    //[self bindCard];
    
    //获取孩子列表    √
    //[self listChildren];
    
    //添加孩子信息    √
    //[self addChild];
    
    //加入班级      √
    //[self joinClass];
    
    //更换手机号码，需要先调用接口给要换的未注册的手机号发送验证码    √
    //[self changePhone];
    
    //添加孩子其他家长      √
    //[self addOtherParent];
    
    //信息发送      √
    //[self sendMessage];
    
    //发送成长记录    √
    //[self sendRecord];
    
    //获取未读信息    √
    //[self listNewMessages];
    
    //文件上传
    //[self upload];
    
    //文件下载      √
    //[self file];
    
    //扫描登陆二维码   √
    //[self returnQRCodeSM];
    
    //教师提交每日考勤确认信息      √
    //[self postDayKQ];

    //多图信息发送    √
    //[self sendMsgPics];
    
    //发送多图成长记录      √
    //[self sendRecordPics];
    

    
    
//    [ZJDBUtil multiInsertTest];
    
    
    [ZJBusinessUtil loginWithPhone:@"18651655260" withYzm:@"735292" loginBlock:^(int loginFlag, NSDictionary *loginInfo) {
        NSLog(@"登录 %@",1 == loginFlag ? @"成功": @"失败");
    }];

    return;
    
    [self initUserInfo];
    
}

//初始化用户环境,在APP启动时候执行
- (void)initUserInfo
{
    [ZJBusinessUtil initUserWithBlock:^(BOOL success, MyProfile *myProfile) {
        NSLog(@"初始化 %@",success ? @"成功": @"失败");
        switch (success) {
            case YES:
            {
                //页面跳转进主面板
                NSLog(@"页面跳转进主面板");
            }
                break;
            case NO:
            {
                //页面跳转进登录注册
                switch (2) {
                    case 1:
                    {
                        NSLog(@"页面跳转进注册");
                        [ZJBusinessUtil sendYzm4UnRegedPhoneWithPhone:@"18651655268" sendYzmUnRegedBlock:^(int sendFlag) {
                            NSLog(@"发送验证码给未注册用户 %@",1 == sendFlag ? @"成功": @"失败");
                            if (1 == sendFlag)
                            {
//                                [ZJBusinessUtil regWithPhone:@"18651655268" withUserName:@"zhangjie-1" withYzm:@"123456" regBlock:^(int regFalg, NSDictionary *regInfo) {
//                                    NSLog(@"注册后登录 %@",1 == regFalg ? @"成功": @"失败");
//                                }];
                            }
                        }];
                    }
                        break;
                    case 2:
                    {
                        NSLog(@"页面跳转进登录");
                        [ZJBusinessUtil sendYzm4RegedPhoneWithPhone:@"18651655260" sendYzmRegedBlock:^(int sendFlag) {
                            NSLog(@"发送验证码给已注册用户 %@",1 == sendFlag ? @"成功": @"失败");
                            if (1 == sendFlag)
                            {
//                                [ZJBusinessUtil loginWithPhone:@"18651655260" withYzm:@"123456" loginBlock:^(int loginFlag, NSDictionary *loginInfo) {
//                                    NSLog(@"登录 %@",1 == loginFlag ? @"成功": @"失败");
//                                }];
                            }
                        }];
                    }
                    default:
                        break;
                }
                
            }
                break;
            default:
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//获取access token
- (void)accessToken
{
    [AFHttpInterfaceUtil accessTokenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"responseObject is %@",responseObject);
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"获取access token 返回结果 %@",result);
        NSString *access_token = result[@"access_token"];
        [ZJVariablesUtil setAccessToken:access_token];
        //531c404d059d15c9028c9cd1c366cfee
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取access token 错误结果 %@",error.description);
    }];
}

//发送验证码给已经注册的号码
- (void)sendYzm4RegedPhone
{
    [AFHttpInterfaceUtil sendYZM4RegedPhoneWithPhone:@"18651655260" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"发送验证码给已经注册的号码 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送验证码给已经注册的号码 错误结果 %@",error.description);
    }];
}

//发送验证码给未注册的号码
- (void)sendYzm4UnRegedPhone
{
    [AFHttpInterfaceUtil sendYZM4UnRegedPhoneWithPhone:@"18651655269" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"发送验证码给未注册的号码 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送验证码给未注册的号码 错误结果 %@",error.description);
    }];
}

//判断号码是否已经注册
- (void)checkPhoneReged
{
    //小史账号：15952054491
    [AFHttpInterfaceUtil checkPhoneRegedWithPhone:@"15952054491" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"判断号码是否已经注册 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"判断号码是否已经注册 错误结果 %@",error.description);
    }];
}

//获取添加家庭成员许可码
- (void)xkmOfAddingMember
{
    [AFHttpInterfaceUtil xkmOfAddingMemberWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"获取添加家庭成员许可码 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取添加家庭成员许可码 错误结果 %@",error.description);
    }];
}

//注册
- (void)registration
{
    [AFHttpInterfaceUtil regWithPhone:@"18651655268" withUserName:@"zhangjie1" withYzm:@"345712" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"注册 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"注册 错误结果 %@",error.description);
    }];
}

//获取用户配置
- (void)myProfile
{
    [AFHttpInterfaceUtil myProfileWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"获取用户配置 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取用户配置 错误结果 %@",error.description);
    }];
}

//登录
- (void)login
{
    [AFHttpInterfaceUtil loginByYzmWithPhone:@"18651655260" withYzm:@"123456" isFirstLogin:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"登录 返回结果 %@",result);
        if (NSOrderedSame == [@"1" compare:result[@"retval"]])
        {
            NSString *sid = result[@"i"];
            [ZJVariablesUtil setSid:sid];
            //18651655269对应的sid是：Hh9vRkBcTl9f
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"登录 错误结果 %@",error.description);
    }];
}


//得到用户登录信息
- (void)userLogin
{
    [AFHttpInterfaceUtil userLoginWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"得到用户登录信息 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"得到用户登录信息 错误结果 %@",error.description);
    }];
}

//绑定孩子的接送卡
- (void)bindCard
{
    [AFHttpInterfaceUtil bindCardWithChildId:@"7" cardId:@"0008736028" schoolId:@"2" isAppend:YES success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"绑定孩子的接送卡 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"绑定孩子的接送卡 错误结果 %@",error.description);
    }];
}

//获取孩子列表
- (void)listChildren
{
    [AFHttpInterfaceUtil listChildrenWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"获取孩子列表 返回结果 %@",result);
        if(NSOrderedSame == [@"1" compare:result[@"retval"]])
        {
            NSArray *children = result[@"children"];
            for (NSDictionary *child in children)
            {
                NSString *childName = child[@"username"];
                NSLog(@"孩子姓名：%@",childName);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取孩子列表 错误结果 %@",error.description);
    }];
}

//添加孩子信息
- (void)addChild
{
    [AFHttpInterfaceUtil addChildWithName:@"拉普拉多阿加西" withSex:@"1" withBirthday:@"2014-10-10" withP2s:@"1" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"添加孩子信息 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"添加孩子信息 错误结果 %@",error.description);
    }];
}

//加入班级
- (void)joinClass
{
    [AFHttpInterfaceUtil joinClassWithChildId:@"7" withJoinCode:@"0731#14" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"加入班级 返回结果 %@",result);
        if (NSOrderedSame == [@"1" compare:result[@"retval"]])
        {
            NSString *clztitle = result[@"clztitle"];
            NSLog(@"clztitle is %@",clztitle);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"加入班级 错误结果 %@",error.description);
    }];
}


//更换手机号码
- (void)changePhone
{
    [AFHttpInterfaceUtil changePhoneWithANewPhone:@"18651655269" withYzm:@"546982" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"更换手机号码 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"更换手机号码 错误结果 %@",error.description);
    }];
}


//添加孩子其他家长
- (void)addOtherParent
{
    //18651655269 对应的xmk：7951
    [AFHttpInterfaceUtil addOtherParentWithParentPhone:@"18651655270" withP2s:@"2" withXkm:@"7951" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"添加孩子其他家长 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"添加孩子其他家长 错误结果 %@",error.description);
    }];
}

//信息发送
- (void)sendMessage
{
    //18651655269对用的id:10
    //18651655260对应的id:9
    //15952054491对应的id:4
    //NSJSONSerialization
    NSString *message = @"末大幅电饭锅";
    NSDictionary *messageDic = @{@"type":@"text",@"msg":message};
    NSString *jsonMessage = [messageDic JSONString];
#warning 发送信息需要根据类型来封装
    [AFHttpInterfaceUtil sendMsgWithMessageContent:jsonMessage withReceivers:@"4" withScratch:@"test" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"信息发送 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"信息发送 错误结果 %@",error.description);
    }];
}

//发送成长记录
- (void)sendRecord
{
    NSString *message = @"成长记录素材发送测试";
    NSDictionary *messageDic = @{@"type":@"text",@"msg":message,@"writer":@"Jason",@"writername":@"Jason"};
    NSString *jsonMessage = [messageDic JSONString];
    
    [AFHttpInterfaceUtil sendRecordWithMessageContent:jsonMessage success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"发送成长记录 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送成长记录 错误结果 %@",error.description);
    }];
}

//获取未读信息
- (void)listNewMessages
{
    [AFHttpInterfaceUtil listNewMsgsWithLastMsgId:@"" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"获取未读信息 返回结果 %@",result);
        if (NSOrderedSame == [@"1" compare:result[@"retval"]])
        {
            NSArray *messages = result[@"msgs"];
            for (NSDictionary *message in messages)
            {
                //NSLog(@"message is %@",message);
                //NSString *messageContent = message[@"msgcontent"];
                NSData *messageContent = [message[@"msgcontent"] dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                NSDictionary *messageContentDic = [NSJSONSerialization JSONObjectWithData:messageContent options:NSJSONReadingAllowFragments error:&error];//[AFHttpInterfaceUtil jsonParseWithObject:messageContent];
                NSString *msg = messageContentDic[@"msg"];
                NSLog(@"message is %@",msg);
                NSLog(@"sendername is %@",message[@"sendername"]);
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取未读信息 错误结果 %@",error.description);
    }];
}

//文件上传
- (void)upload
{
    //NSString *filePath = [[NSBundle mainBundle]pathForResource:@"chat_placeholder@2x" ofType:@"png"];
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"1_full" ofType:@"JPG"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    [AFHttpInterfaceUtil uploadWithFile:data withText:@"123456789" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"文件上传 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"文件上传 错误结果 %@",error.description);
    }];
}

//文件下载
- (void)file
{
    //chat_placeholder@2x.png 对应的 fid = "151/315600f318e50ec2e767b7ef24cd0a48.png";
    //NSString *fileId = @"151/acd3d188db2465857b6f7f54d5ff8b36.jpg";
    
    //0_full.JPG 对应的 fid = "151/413a02c929d6d5ad7c63c6cd3b61539c.jpg"
    //1_full.JPG 对应的 fid = "151/10b08f367e2e15df59ef747aad7911e2.jpg"
    NSString *fileId = @"151/9550a1bc87d9ce7729409be3f520926a.jpg";
    [AFHttpInterfaceUtil fileWithFid:fileId success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"文件下载 返回结果 %@",responseObject);
        NSData *data = [NSData dataWithData:responseObject];
#warning NSData保存文件需要封装
        UIImage *image = [[UIImage alloc]initWithData:data];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"文件下载 错误结果 %@",error.description);
    }];
}

//扫描登陆二维码
- (void)returnQRCodeSM
{
    [AFHttpInterfaceUtil returnQRCodeSMWithLoginToken:BASE_URL success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"扫描登陆二维码 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"扫描登陆二维码 错误结果 %@",error.description);
    }];
}

//教师提交每日考勤确认信息
- (void)postDayKQ
{
#warning 班级异常考勤明细的封装
#warning 意外伤害明细的封装
#warning 病假明细的封装
    NSDictionary *yclbDic = @{@"i": @"4",@"list": @{@"si": @"3",@"lx": @"2",@"bjmx":@"",@"bjc":@"",@"ywsh":@""}};
    NSString *yclbString = [yclbDic JSONString];
    
    [AFHttpInterfaceUtil postDayKQWithYclb:yclbString success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"教师提交每日考勤确认信息 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"教师提交每日考勤确认信息 错误结果 %@",error.description);
    }];
}

//多图信息发送
- (void)sendMsgPics
{
    NSString *pathOne = [[NSBundle mainBundle]pathForResource:@"chat_self@2x" ofType:@"png"];
    NSData *dataOne = [NSData dataWithContentsOfFile:pathOne];
    NSDictionary *dicOne = @{AFFileKey: @"file0", AFFileType: @"png", AFFileData: dataOne};
    
    NSString *pathTwo = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"JPG"];
    NSData *dataTwo = [NSData dataWithContentsOfFile:pathTwo];
    NSDictionary *dicTwo = @{AFFileKey: @"file1", AFFileType: @"jpg", AFFileData: dataTwo};
    
    NSArray *files = @[dicOne,dicTwo];
    [AFHttpInterfaceUtil sendMsgPicsWithFiles:files withScratch:@"zj" withReceivers:@"4" success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"多图信息发送 返回结果 %@",result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"多图信息发送 错误结果 %@",error.description);
    }];
    
}

//发送多图成长记录
- (void)sendRecordPics
{
    NSString *pathOne = [[NSBundle mainBundle]pathForResource:@"1" ofType:@"JPG"];
    NSData *dataOne = [NSData dataWithContentsOfFile:pathOne];
    NSDictionary *dicOne = @{AFFileKey: @"file0", AFFileType: @"jpg", AFFileData: dataOne};
    
    NSString *pathTwo = [[NSBundle mainBundle]pathForResource:@"2" ofType:@"JPG"];
    NSData *dataTwo = [NSData dataWithContentsOfFile:pathTwo];
    NSDictionary *dicTwo = @{AFFileKey: @"file1", AFFileType: @"jpg", AFFileData: dataTwo};
    
    NSArray *files = @[dicOne,dicTwo];
    NSLog(@"sendRecordPics begin is %@",[NSDate date]);
    [AFHttpInterfaceUtil sendRecordPicsWithFiles:files success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = [AFHttpInterfaceUtil jsonParseWithObject:responseObject];
        NSLog(@"发送多图成长记录 返回结果 %@",result);
        NSLog(@"sendRecordPics end is %@",[NSDate date]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发送多图成长记录 错误结果 %@",error.description);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
