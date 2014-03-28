//
//  ZJViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-3-17.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJViewController.h"

@interface ZJViewController ()

@property (weak, nonatomic) IBOutlet UITableView *menuTableview;
@property (strong, nonatomic) NSArray *menuDatasource;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Let me think how to design this project");
    self.navigationItem.title = @"ZJ Menu";
//    self.navigationController.title = @"ZJ";
    self.menuDatasource = @[@"可移动Tableviewcell"];
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
    [self performSegueWithIdentifier:@"MovedCell" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (segue.identifier && NSOrderedSame == [segue.identifier compare:@"MovedCell"])
    {
        
    }
}


@end
