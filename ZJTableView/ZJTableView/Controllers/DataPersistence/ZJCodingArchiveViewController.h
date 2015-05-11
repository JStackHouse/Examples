//
//  ZJCodingArchiveViewController.h
//  ZJTableView
//
//  Created by zhangjie on 14-5-14.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    keyedArchiver = 0,
    keyedArchiverUserDefault
}ArchiveEnum;

@interface ZJCodingArchiveViewController : UIViewController

@property (assign, nonatomic) ArchiveEnum type;
@property (weak, nonatomic) IBOutlet UITextField *autherField;
@property (weak, nonatomic) IBOutlet UITextField *priceField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *availableSeg;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@interface Book : NSObject <NSCoding>

@property (strong, nonatomic) NSString *auther;
@property (assign, nonatomic) NSInteger num;
@property (assign ,nonatomic) BOOL available;

@end
