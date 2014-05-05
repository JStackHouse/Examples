//
//  ZJNibCollectionViewCell.m
//  ZJTableView
//
//  Created by zhangjie on 14-4-21.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJNibCollectionViewCell.h"

@interface ZJNibCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLabel;

@end

@implementation ZJNibCollectionViewCell
static NSOperationQueue *queue = nil;
- (NSOperationQueue *)sharedQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[NSOperationQueue alloc]init];
    });
    return queue;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSLog(@"ZJNibCollectionViewCell init");
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ZJNibCollectionViewCell" owner:self options: nil];
        // 如果路径不存在，return nil
        if(arrayOfViews.count < 1){return nil;}
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[ZJNibCollectionViewCell class]]){
            return nil;
        }
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];

    }
    return self;
}

- (void)loadCell
{
//    if (queue)
//    {
//        for (; <#condition#>; <#increment#>) {
//            <#statements#>
//        }
//        [queue addOperationWithBlock:^{
//            
//        }];
//    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *imageName = [self.cellInfo objectForKey:@"imageName"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]];
        NSString *labelName = [self.cellInfo objectForKey:@"labelName"];
        dispatch_sync(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            self.cellImageView.image = image;//[UIImage imageNamed:imageName];
            self.cellNameLabel.text = labelName;
        });
    });
//    NSData *data = [NSData dataWithContentsOfFile:imageName];
//    UIImage *image = [UIImage imageWithData:data];
//    NSString *labelName = [self.cellInfo objectForKey:@"labelName"];
//    self.cellImageView.image = image;//[UIImage imageNamed:imageName];
//    self.cellNameLabel.text = labelName;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
