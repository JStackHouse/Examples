//
//  ZJNewsViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/10.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJNewsViewController.h"
#import "ZJNewsModel.h"
#import "ZJNewsTableViewCell.h"
#import "ZJNewsWebViewController.h"

@interface ZJNewsViewController ()

@end

@implementation ZJNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.newsTableView = [[UITableView alloc]initWithFrame:CGRectOffset(self.view.bounds, 0, 20) style:UITableViewStylePlain];
//    self.newsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.newsTableView.dataSource = self;
    self.newsTableView.delegate = self;
    self.newsTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.newsTableView];
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
    ZJSubNewsModel *subNewsOne = [[ZJSubNewsModel alloc]init];
    subNewsOne.subNewsTitle = @"插画设计风格的俄罗斯啤酒包装品牌设计";
    subNewsOne.subNewsImageUrl = @"http://www.vartcn.com/art/UploadFiles/201209/2012091009064727.jpg";
    subNewsOne.subNewsLinkUrl = @"http://www.vartcn.com/art/UploadFiles/201209/2012091009064727.jpg";
    
    ZJSubNewsModel *subNewsTwo = [[ZJSubNewsModel alloc]init];
    subNewsTwo.subNewsTitle = @"典雅而有趣的蜜蜂产品包装典雅而有趣的蜜蜂产品包装";
    subNewsTwo.subNewsImageUrl = @"http://img.zjol.com.cn/pic/0/02/16/58/2165810_672072.jpg";
    subNewsTwo.subNewsLinkUrl = @"http://img.zjol.com.cn/pic/0/02/16/58/2165810_672072.jpg";

    ZJSubNewsModel *subNewsThree = [[ZJSubNewsModel alloc]init];
    subNewsThree.subNewsTitle = @"国外公寓精致装修设计作品国外公寓精致装修设计作品";
    subNewsThree.subNewsImageUrl = @"http://uploadfile.ju51.com/fckeditor/2009/3/20/20090320173111375.jpg";
    subNewsThree.subNewsLinkUrl = @"http://uploadfile.ju51.com/fckeditor/2009/3/20/20090320173111375.jpg";
    
    ZJNewsModel *newsOne = [[ZJNewsModel alloc]init];
    newsOne.newsTime = @"今天 14：32";
    newsOne.topNewsTitle = @"法国音乐节的创意海报欣赏";
    newsOne.topNewsImageUrl = @"http://images.takungpao.com/2013/0214/20130214081043521.jpg";
    newsOne.topNewsLinkUrl = @"http://images.takungpao.com/2013/0214/20130214081043521.jpg";
    newsOne.subNewsArray = @[subNewsOne,subNewsTwo,subNewsThree];
    
    self.newsDataSource = @[newsOne];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.newsDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"NewsCell";
    ZJNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell)
    {
        cell = [[ZJNewsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ZJNewsModel *newsInfo = self.newsDataSource[indexPath.row];
//    [cell loadCellInfo:newsInfo];
    [cell loadCellInfo:newsInfo withNewsClickBlock:^(NSString *newsUrl) {
        [self didSelectNewsWithUrl:newsUrl];
    }];
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 440.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didSelectNewsWithUrl:(NSString *)url
{
    ZJNewsWebViewController *newsWebViewController = [[ZJNewsWebViewController alloc]init];
    newsWebViewController.newsUrl = url;
    [self.navigationController pushViewController:newsWebViewController animated:YES];
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
