//
//  ZJBlockViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-4-30.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJBlockViewController.h"

@interface ZJBlockViewController ()

@property (weak, nonatomic) IBOutlet UITextField *bTextField;
@property (weak, nonatomic) IBOutlet UIButton *bButton;

@end

@implementation ZJBlockViewController

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
    [_bButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
    _zjBlock(_bTextField.text, YES, 2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transblock:(ZJBlock)aZjBlock
{
    _zjBlock = aZjBlock;
}

//void (^zjBlock)(NSString *)
//{
//    
//}
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
