//
//  ZJViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-3-17.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJViewController.h"
#import "MovedTableViewCell/ZJMTableviewViewController.h"
#import "ActivityViewController/ZJActivity.h"
#import "Block/ZJBlockViewController.h"
#import "Lumberjack.h"

@interface ZJViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTableview;
@property (strong, nonatomic) NSArray *menuDatasource;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation ZJViewController

//static const int ddLogLevel = LOG_LEVEL_OFF;
//static const int ddLogLevel = LOG_LEVEL_ERROR;
static const int ddLogLevel = LOG_LEVEL_WARN;
//static const int ddLogLevel = LOG_LEVEL_INFO;
//static const int ddLogLevel = LOG_LEVEL_DEBUG;
//static const int ddLogLevel = LOG_LEVEL_VERBOSE;
- (void)ddlogTest
{
    DDLogError(@"error");
    
    DDLogWarn(@"warn");
    
    DDLogInfo(@"info");
    
    DDLogDebug(@"debug");
    
    DDLogVerbose(@"verbose");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self ddlogTest];
	// Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"Let me think how to design this project");
    self.navigationItem.title = @"ZJ Menu";
//    self.navigationController.title = @"ZJ";
    self.menuDatasource = @[@"可移动Tableviewcell",@"ZJ的ConllectionView",@"UIActivityViewController",@"block"];
    [self.menuTableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.menuDatasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.menuDatasource objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    switch (indexPath.row)
    {
        case 0:
        {
//            [self performSegueWithIdentifier:@"MovedCell" sender:self];
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ZJMTableviewViewController *zzz = (ZJMTableviewViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"MovedCell"];
            [self.navigationController pushViewController:zzz animated:YES];
        }
            break;
        case 1:
        {
            [self performSegueWithIdentifier:@"CollectionTableView" sender:self];
        }
            break;
        case 2:
        {
            @try {
                switch (0) {
                    case 0:
                    {
                        NSString *string = @"Welcome";
                        UIImage *image = [UIImage imageNamed:@"0.JPG"];
                        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
                        UIActivityViewController *activityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[string, image, url] applicationActivities:nil];
                        activityViewController.completionHandler = ^(NSString *activityType, BOOL completed){
                            //NSLog(@"activityType is %@",activityType);
                            //NSLog(@"completed is %d",completed);
                        };
                        [self.navigationController presentViewController:activityViewController animated:YES completion:^{
                            //UIActivityItemProvider
                            //UIActivity
                        }];
                    }
                        break;
                    case 1:
                    {
                        NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
                        ZJActivity *activity = [ZJActivity new];
                        //items包括标题、超链接URL、图片等信息
                        //activities是分享的图片实例对象，自定义的话要继承自UIActivity
                        UIActivityViewController *zctivityViewController = [[UIActivityViewController alloc]initWithActivityItems:@[url] applicationActivities:@[activity]];
                        [self.navigationController presentViewController:zctivityViewController animated:YES completion:nil];
                    }
                        break;
                    default:
                        break;
                }
            }
            @catch (NSException *exception) {
                NSLog(@"exception.description) is %@",exception.description);
            }
            @finally {
                
            }
        }
            break;
        case 3:
        {
            [self performSegueWithIdentifier:@"BlockPresent" sender:nil];
        }
            break;
        default:
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (segue.identifier && NSOrderedSame == [segue.identifier compare:@"MovedCell"])
    {
        
    }
    else if (segue.identifier && NSOrderedSame == [segue.identifier compare:@"CollectionTableView"])
    {
        
    }
    else if (segue.identifier && NSOrderedSame == [segue.identifier compare:@"BlockPresent"])
    {
        ZJBlockViewController *blockViewController = (ZJBlockViewController *)segue.destinationViewController;
        [blockViewController transblock:^(NSString *blockStr, BOOL BlockBool, NSInteger blockInt) {
            NSString *alertString = [NSString stringWithFormat:@"blockTest %@ - %@ - %ld",blockStr,BlockBool ? @"YES" : @"NO",(long)blockInt];
            NSLog(@"%@",alertString);
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Block CallBack" message:alertString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    NSLog(@"segue.destinationViewController is%@",segue.destinationViewController);
}


@end
