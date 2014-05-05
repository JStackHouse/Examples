//
//  ZJNibCollectionViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-4-21.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJNibCollectionViewController.h"
#import "ZJNibCollectionViewCell.h"
#define NibCell     @"nibCell"

@interface ZJNibCollectionViewController ()

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UICollectionView *nibCollectionView;
@end

@implementation ZJNibCollectionViewController

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
    self.dataSource = [NSMutableArray array];
    [self.dataSource addObject:@{@"imageName": @"http://www.vartcn.com/art/UploadFiles/201209/2012091009064727.jpg",@"labelName": @"AppIcon1"}];
    [self.dataSource addObject:@{@"imageName": @"http://images.takungpao.com/2013/0214/20130214081043521.jpg",@"labelName": @"AppIcon2"}];
    [self.dataSource addObject:@{@"imageName": @"http://img.zjol.com.cn/pic/0/02/16/58/2165810_672072.jpg",@"labelName": @"AppIcon3"}];
    [self.dataSource addObject:@{@"imageName": @"http://www.htjdhs.com/news/UploadFiles_5960/201301/20130124172001635.jpg",@"labelName": @"AppIcon4"}];
    [self.dataSource addObject:@{@"imageName": @"http://uploadfile.ju51.com/fckeditor/2009/3/20/20090320173111375.jpg",@"labelName": @"AppIcon5"}];

//    [self.dataSource addObject:@{@"imageName": @"0.JPG",@"labelName": @"AppIcon1"}];
//    [self.dataSource addObject:@{@"imageName": @"1.JPG",@"labelName": @"AppIcon2"}];
//    [self.dataSource addObject:@{@"imageName": @"2.JPG",@"labelName": @"AppIcon3"}];
//    [self.dataSource addObject:@{@"imageName": @"3.JPG",@"labelName": @"AppIcon4"}];
//    [self.dataSource addObject:@{@"imageName": @"4.JPG",@"labelName": @"AppIcon5"}];
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.minimumLineSpacing = 10.0f;
//    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
//    [self.nibCollectionView setCollectionViewLayout:flowLayout];
    [self.nibCollectionView registerClass:[ZJNibCollectionViewCell class] forCellWithReuseIdentifier:NibCell];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJNibCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NibCell forIndexPath:indexPath];
    cell.cellInfo = [self.dataSource objectAtIndex:indexPath.row];
//    UILabel *label = [[UILabel alloc]initWithFrame:cell.frame];
//    label.text = [NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.item];
//    [cell addSubview:label];
    [cell loadCell];
//    cell.backgroundColor = [UIColor greenColor];
    return cell;
}


#pragma mark - UICollectionViewDelegate

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
