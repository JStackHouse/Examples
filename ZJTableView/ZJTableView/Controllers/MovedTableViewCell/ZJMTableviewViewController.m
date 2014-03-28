//
//  ZJMTableviewViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14-3-27.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJMTableviewViewController.h"

@interface ZJMTableviewViewController ()
@property (weak, nonatomic) IBOutlet UITableView *movedTableView;

@property (strong, nonatomic) NSMutableArray *movedDatasource;

@end

@implementation ZJMTableviewViewController

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
    self.movedDatasource = [NSMutableArray arrayWithArray:@[@"AAA",@"BBB",@"CCC",@"DDD",@"EEE",@"FFF"]];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [self.movedTableView addGestureRecognizer:longPress];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.movedDatasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [self.movedDatasource objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - action
- (void)longPressAction:(UILongPressGestureRecognizer *)gesture
{
    UIGestureRecognizerState state = gesture.state;
    CGPoint locationPoint = [gesture locationInView:gesture.view];
    NSIndexPath *indexpath = [self.movedTableView indexPathForRowAtPoint:locationPoint];
    
    static UIView *snapshot = nil;
    static NSIndexPath *sourceIndexpath = nil;
    
    switch (state) {
        case UIGestureRecognizerStateBegan:
        {
            sourceIndexpath = indexpath;
            UITableViewCell *cell = [self.movedTableView cellForRowAtIndexPath:indexpath];
            snapshot = [self customSnapshotFromView:cell];
            
            // Add the snapshot as subview, centered at cell's center...
            __block CGPoint center = cell.center;
            snapshot.center = center;
            snapshot.alpha = 0.0;
            [self.movedTableView addSubview:snapshot];
            [UIView animateWithDuration:0.25 animations:^{
                
                // Offset for gesture location.
                center.y = locationPoint.y;
                snapshot.center = center;
                snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                snapshot.alpha = 0.98;
                
                // Black out. 
                cell.backgroundColor = [UIColor grayColor]; 
            } completion:nil]; 
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint center = snapshot.center;
            center.y = locationPoint.y;
            snapshot.center = center;
            
            if (indexpath && ![indexpath isEqual:sourceIndexpath])
            {
                //NSLog(@"indexpath.row : %d;sourceIndexpath.row : %d \nself.movedDatasource is %@",indexpath.row,sourceIndexpath.row,self.movedDatasource);
                [self.movedDatasource exchangeObjectAtIndex:indexpath.row withObjectAtIndex:sourceIndexpath.row];
                [self.movedTableView moveRowAtIndexPath:sourceIndexpath toIndexPath:indexpath];
                sourceIndexpath = indexpath;
            }
        }
            break;
        default:
        {
            UITableViewCell *cell = [self.movedTableView cellForRowAtIndexPath:sourceIndexpath];
            [UIView animateWithDuration:.25 animations:^{
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0f;
                cell.backgroundColor = [UIColor whiteColor];
            } completion:^(BOOL finished) {
                [snapshot removeFromSuperview];
                snapshot = nil;
            }];
            sourceIndexpath = nil;
        }
            break;
    }
}

- (UIView *)customSnapshotFromView:(UIView *)inputView {
    
    UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
} 



@end
