//
//  ZJContactTableViewCell.m
//  ZJTableView
//
//  Created by zhangjie on 14-5-16.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJContactTableViewCell.h"

@implementation ZJContactTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
