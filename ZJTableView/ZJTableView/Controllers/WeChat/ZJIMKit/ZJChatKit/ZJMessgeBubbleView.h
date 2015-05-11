//
//  ZJMessgeBubbleView.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/15.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MLEmojiLabel;

typedef void(^BubbleTapBlock)(id <ZJMessageModel> message, UIImageView *audioImageView);
typedef void(^BubbleLongPressBlock)(id <ZJMessageModel> message);


@interface ZJMessgeBubbleView : UIView

//单击回调
@property (strong, nonatomic) BubbleTapBlock bubbleTapBlock;
//长按回调
@property (strong, nonatomic) BubbleLongPressBlock bubbleLongPressBlock;


//数据对象
@property (strong, nonatomic, readonly) id <ZJMessageModel> message;

//汽包背景图片
@property (weak, nonatomic, readonly) UIImageView *bubbleImageView;

//文本消息控件
@property (weak, nonatomic, readonly) UITextView *textView;
@property (weak, nonatomic, readonly) MLEmojiLabel *textLabel;

//语音背景图片
@property (weak, nonatomic, readonly) UIImageView *audioImageView;

//语音时长的label
@property (weak, nonatomic, readonly) UILabel *audioDurationLabel;

//照片的图片控件
@property (weak, nonatomic, readonly) UIImageView *photoImageView;

//视频的图片控件
@property (weak, nonatomic, readonly) UIImageView *videoPlayImageView;



//正在发送指示器
@property (weak, nonatomic, readonly) UIActivityIndicatorView *sendingActivityIndicatorView;
//发送失败图片
@property (weak, nonatomic, readonly) UIImageView *sendFailedImageView;

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                      message:(id <ZJMessageModel>)message;


//根据数据来配置bubble
- (void)configureBubbleWithMessage:(id <ZJMessageModel>)message;
- (void)configureBubbleWithMessage:(id <ZJMessageModel>)message
                          tapBlock:(BubbleTapBlock)tapBlock
                    longPressBlock:(BubbleLongPressBlock)longPressBlock;

//根据数据计算高度
+ (CGFloat)calculateCellHeightWithMessage:(id <ZJMessageModel>)message;


//根据发送状态设置展示控件
- (void)configureSendingSuccess:(BOOL)success;

//不重用textView
- (void)notReuseTextView;


@end
