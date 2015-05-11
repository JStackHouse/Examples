//
//  ZJContactTableViewCell.h
//  ZJTableView
//
//  Created by zhangjie on 14-5-16.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJContactTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contactName;

@property (weak, nonatomic) IBOutlet UILabel *contactType;

@property (weak, nonatomic) IBOutlet UILabel *contactNumber;
@end
