//
//  ZJChatTableViewCell.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/15.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJMessgeBubbleView;

@protocol ZJChatTableViewCellDelegate <NSObject>


//单击气泡的回调
- (void)didTapBubbleWithMessage:(id <ZJMessageModel>)message withAudioImageView:(UIImageView *)imageView;
//长按气泡的回调
- (void)didLongPressBubbleWithMessage:(id <ZJMessageModel>)message;

//单击图片的回调：拍照和视频
- (void)didTapImageViewWithMessage:(id <ZJMessageModel>)message;


@end


@interface ZJChatTableViewCell : UITableViewCell


@property (weak, nonatomic) id <ZJChatTableViewCellDelegate> delegate;

//自定义消息视图
@property (weak, nonatomic, readonly) ZJMessgeBubbleView *messageBubbleView;

//头像按钮
@property (weak, nonatomic, readonly) UIButton *avatorButton;

//时间轴Label
@property (weak, nonatomic, readonly) UILabel *messageTimeLabel;

//cell所在的位置
@property (strong, nonatomic) NSIndexPath *indexPath;

//获取消息的收发类型
//- (ZJMessageReceiveSendType)receiveSendType;


//初始化cell
- (instancetype)initWithMessage:(id <ZJMessageModel>)message
                showMessageTime:(BOOL)showMessageTime
                reuseIdentifier:(NSString *)cellIdentifier;

//重新配置cell
- (void)configureCellWithMessage:(id <ZJMessageModel>)message
                 showMessageTime:(BOOL)showMessageTime;


//计算cell高度
+ (CGFloat)calculateCellHeightWithMessage:(id <ZJMessageModel>)message
                          showMessageTime:(BOOL)showMessageTime;
@end
