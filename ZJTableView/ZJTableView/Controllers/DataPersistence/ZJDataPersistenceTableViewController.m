//
//  ZJDataPersistenceTableViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-5-14.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJDataPersistenceTableViewController.h"
#import "ZJCodingArchiveViewController.h"

@interface ZJDataPersistenceTableViewController ()
{
    NSArray *dataSource;
}

@end

@implementation ZJDataPersistenceTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    dataSource = @[@[@"NSKeyedArchiver",@"NSUserDefaults+NSKeyedArchiver"],@[@"FMDB",@"EGODatabase",@"SQLite",@"Core Data"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[dataSource objectAtIndex:section] count];
}


static NSString *cellIdentifier = @"cellIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [[dataSource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    return cell;
}

static NSIndexPath *selectedIndexPath;
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    @try {
        selectedIndexPath = indexPath;
        switch (indexPath.section) {
            case 0:
            {
                [self performSegueWithIdentifier:@"CodingArchive" sender:nil];
            }
                break;
            case 1:
            {
                [self performSegueWithIdentifier:@"EgoDatabase" sender:nil];
            }
                break;
            default:
                break;
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    @try {
        if (segue)
        {
            if (segue.destinationViewController)
            {
                if (0 == selectedIndexPath.section)
                {
                    ZJCodingArchiveViewController *zjc = segue.destinationViewController;
                    switch (selectedIndexPath.row) {
                        case keyedArchiver:
                            zjc.type = keyedArchiver;
                            break;
                        case keyedArchiverUserDefault:
                            zjc.type = keyedArchiverUserDefault;
                            break;
                        default:
                            break;
                    }
                }
                NSLog(@"%@",segue.destinationViewController);
            }
        }
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
