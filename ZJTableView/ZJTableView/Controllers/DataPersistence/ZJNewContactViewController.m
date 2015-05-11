//
//  ZJNewContactViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-5-16.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJNewContactViewController.h"

@interface ZJNewContactViewController ()
@property (weak, nonatomic) IBOutlet UITextField *ContactNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ContactPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *ContactDesTextField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveNewContactItem;

@end

@implementation ZJNewContactViewController

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
    [self.saveNewContactItem setTarget:self];
    [self.saveNewContactItem setAction:@selector(saveNewContact:)];
    self.navigationItem.rightBarButtonItem = self.saveNewContactItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.ContactNameTextField becomeFirstResponder];
}

- (IBAction)saveNewContact:(id)sender
{
    NSString *name = [self.ContactNameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *phone = [self.ContactPhoneTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *des = [self.ContactDesTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (!name || !phone || !des)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"警告" message:@"信息不完整" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    //保存
    EGODatabase *dataBase = [ZJDBBase initDatabase];
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO CONTACT ('NAME','PHONE','DES') VALUES ('%@','%@','%@')",name,phone,des];
    EGODatabaseResult *result = [dataBase executeQuery:sql];
    NSLog(@"result is %@",result);
    
    [self.navigationController popViewControllerAnimated:YES];
}

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
