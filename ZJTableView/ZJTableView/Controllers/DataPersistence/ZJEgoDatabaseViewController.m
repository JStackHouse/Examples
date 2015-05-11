//
//  ZJEgoDatabaseViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-5-16.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJEgoDatabaseViewController.h"
#import "ZJContactTableViewCell.h"

@interface ZJEgoDatabaseViewController ()
{
    NSString *dbPath;
    NSMutableArray *dataSource;
}

@end

@implementation ZJEgoDatabaseViewController

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
    self.navigationItem.title = @"联系人";
    UIBarButtonItem *newContactButton = [[UIBarButtonItem alloc]initWithTitle:@"新增联系人" style:UIBarButtonItemStylePlain target:self action:@selector(newContact:)];
    self.navigationItem.rightBarButtonItem = newContactButton;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    dataSource = [[NSMutableArray alloc]init];
//    [dataSource addObject:@{@"contactName":@"张三",@"contactType":@"住宅",@"contactNumber":@"025-12345678"}];
//    [dataSource addObject:@{@"contactName":@"李四",@"contactType":@"工作",@"contactNumber":@"025-23456789"}];
//    [dataSource addObject:@{@"contactName":@"王二",@"contactType":@"生活",@"contactNumber":@"18888888888"}];
    
//    dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/zjTable.db"];
//    EGODatabase *egoDatabase = [EGODatabase databaseWithPath:dbPath];
}

- (void)viewWillAppear:(BOOL)animated
{
    [dataSource removeAllObjects];
    
    NSString *selectSql = @"SELECT * FROM CONTACT";
    EGODatabase *database = [ZJDBBase initDatabase];
    EGODatabaseResult *result = [database executeQuery:selectSql];
    for (EGODatabaseRow *row in result)
    {
        NSString *name = [row stringForColumn:@"NAME"];
        NSString *phone = [row stringForColumn:@"PHONE"];
        NSString *des = [row stringForColumn:@"DES"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:name,@"contactName",phone,@"contactType",des,@"contactNumber", nil];
        [dataSource addObject:dic];
    }
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newContact:(UIButton *)button
{
    [self performSegueWithIdentifier:@"NewContact" sender:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdendifier = @"cellIdendifier";
    ZJContactTableViewCell *cell = (ZJContactTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdendifier];
    if (nil == cell)
    {
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"ZJContactTableViewCell" owner:self options:nil];
        for (UIView *view in nibs)
        {
            if ([view isKindOfClass:[ZJContactTableViewCell class]])
            {
                cell = (ZJContactTableViewCell *)view;
            }
        }
    }
    NSDictionary *contactDic = [dataSource objectAtIndex:indexPath.row];
    cell.contactName.text = [contactDic objectForKey:@"contactName"];
    cell.contactType.text = [contactDic objectForKey:@"contactType"];
    cell.contactNumber.text = [contactDic objectForKey:@"contactNumber"];
    
    return cell;
}

#pragma mark - UITableViewDelegate


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
