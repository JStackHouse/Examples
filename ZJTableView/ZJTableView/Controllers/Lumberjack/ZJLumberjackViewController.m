//
//  ZJLumberjackViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-5-4.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJLumberjackViewController.h"

@interface ZJLumberjackViewController ()

@end

@implementation ZJLumberjackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 1.@DDLog（整个框架的基础）
 2.@DDASLLogger（发送日志语句到苹果的日志系统，以便它们显示在Console.app上）
 3.@DDTTYLoyger（发送日志语句到Xcode控制台，如果可用）
 4.@DDFIleLoger（把日志语句发送至文件）
*/

/*
 配置框架
 首先，你想要在你的应用程序中配置这个日志框架，通常在applicationDidFinishLaunching方法中配置。
 
 开始时，你需要下面两行代码：
 [DDLog addLogger:[DDASLLogger sharedInstance]];
 [DDLog addLogger:[DDTTYLogger sharedInstance]];
 这将在你的日志框架中添加两个“logger”。也就是说你的日志语句将被发送到Console.app和Xcode控制 台（就像标准的NSLog）
 */

/*
 这个框架的好处之一就是它的灵活性，如果你还想要你的日志语句写入到一个文件中，你可以添加和配置一个file logger:
 fileLogger = [[DDFileLogger alloc] init];
 fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
 fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
 
 [DDLog addLogger:fileLogger];
 
 上面的代码告诉应用程序要在系统上保持一周的日志文件。
 */

/*
 你所要做的就是决定每个NSlog语句属于哪种日志级别。DDLog默认有四种级别的日志，分别是：
 1.@DDlogError
 2.@DDlogWarn
 3.@DDlogInfo
 4.@DDlogVerbose
 当然选择哪个NSLog语句取决于你的消息的严重程度。
 
 下面的这些不同的日志等级也许正有你所需要的：
 1.如果你将日志级别设置为 LOG_LEVEL_ERROR，那么你只会看到DDlogError语句。
 2.如果你将日志级别设置为LOG_LEVEL_WARN，那么你只会看到DDLogError和DDLogWarn语句。
 3.如果您将日志级别设置为 LOG_LEVEL_INFO,那么你会看到error、Warn和Info语句。
 4.如果您将日志级别设置为LOG_LEVEL_VERBOSE,那么你会看到所有DDLog语句。
 5.如果您将日志级别设置为 LOG_LEVEL_OFF,你将不会看到任何DDLog语句。
 */

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
