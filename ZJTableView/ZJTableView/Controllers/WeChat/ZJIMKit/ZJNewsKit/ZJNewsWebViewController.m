//
//  ZJNewsWebViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/11.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJNewsWebViewController.h"

@interface ZJNewsWebViewController ()

@end

@implementation ZJNewsWebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIWebView *newsWebView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    newsWebView.scalesPageToFit = YES;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.newsUrl]];
    [newsWebView loadRequest:request];
    [self.view addSubview:newsWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
