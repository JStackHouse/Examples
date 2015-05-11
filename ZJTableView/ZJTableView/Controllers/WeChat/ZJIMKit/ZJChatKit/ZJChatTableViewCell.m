//
//  ZJChatTableViewCell.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/15.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJChatTableViewCell.h"

@interface ZJChatTableViewCell ()


//自定义消息视图
@property (weak, nonatomic, readwrite) ZJMessgeBubbleView *messageBubbleView;

//头像按钮
@property (weak, nonatomic, readwrite) UIButton *avatorButton;

//时间轴Label
@property (weak, nonatomic, readwrite) UILabel *messageTimeLabel;


//
@property (assign, nonatomic) BOOL showMessageTimeLabel;


//配置时间标签
- (void)configureTimeLabel:(id <ZJMessageModel>)message showMessageTimeLabel:(BOOL)showMessageTime;

//配置头像
- (void)configureAvatorWithMessage:(id <ZJMessageModel>)message;

//配置消息内容
- (void)configureMessageBubbleViewWithMessage:(id <ZJMessageModel>)message;
//配置手势
- (void)configureGestureWithMessage:(id <ZJMessageModel>)message;

@end


@implementation ZJChatTableViewCell


//获取消息的收发类型
//- (ZJMessageReceiveSendType)receiveSendType
//{
//    return 0;
//}


#pragma mark - 初始化cell

static const CGFloat TimeLabelPadding = 5.0f;
static const CGFloat TimeLabelHeight = 20.0f;
static const CGFloat TimeLabelWidth = 100.0f;

static const CGFloat AvatorPaddingX = 8.0f;
static const CGFloat AvatorPaddingY = 15.0f;
static const CGFloat AvatorSize = AvatorSizeDefine;

static const CGFloat BubbleViewPadding = 8.0f;


//初始化cell
- (instancetype)initWithMessage:(id <ZJMessageModel>)message
                showMessageTime:(BOOL)showMessageTime
                reuseIdentifier:(NSString *)cellIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    if (self)
    {
        //初始化时间标签
        if (!_messageTimeLabel)
        {
            UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, TimeLabelPadding, TimeLabelWidth, TimeLabelHeight)];
            timeLabel.center = ccp(self.contentView.center.x, timeLabel.center.y);//self.contentView.center;
            timeLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
            timeLabel.layer.backgroundColor = [[UIColor lightGrayColor]CGColor];
            timeLabel.layer.cornerRadius = 5.0f;
            timeLabel.textAlignment = NSTextAlignmentCenter;
            timeLabel.textColor = [UIColor whiteColor];
            timeLabel.font = [UIFont systemFontOfSize:messageTimeFontSize];
            [self.contentView addSubview:timeLabel];
            [self.contentView bringSubviewToFront:timeLabel];
            _messageTimeLabel = timeLabel;
        }
        
        //初始化头像
        if (!_avatorButton)
        {
            CGRect avatorFrame;
            switch (message.messageReceiveSendType) {
                case ZJMessageTypeReceive:
                {
                    avatorFrame = CGRectMake(AvatorPaddingX, AvatorPaddingY + (showMessageTime ? TimeLabelHeight : 0), AvatorSize, AvatorSize);
                }
                    break;
                case ZJMessageTypeSend:
                {
                    avatorFrame = CGRectMake(CGRectGetWidth(self.contentView.bounds) - AvatorSize - AvatorPaddingX, AvatorPaddingY + (showMessageTime ? TimeLabelHeight : 0), AvatorSize, AvatorSize);
                }
                    break;
                default:
                    break;
            }
            
            UIButton *avatorButton = [[UIButton alloc]initWithFrame:avatorFrame];
            [avatorButton setImage:[UIImage imageNamed:@"chat_placeholder@2x"] forState:UIControlStateNormal];
            avatorButton.layer.cornerRadius = 5.0f;
            [avatorButton addTarget:self action:@selector(avatorButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:avatorButton];
            _avatorButton = avatorButton;
        }
        
        //初始化显示内容
        if (!_messageBubbleView)
        {
            CGFloat bubbleX = 0.0f;
            CGFloat bubbleOffX = 0.0f;
            if (message.messageReceiveSendType)
                bubbleX = AvatorSize + AvatorPaddingX * 2;
            else
                bubbleOffX = AvatorSize+ AvatorPaddingX * 2;
            
            CGRect bubbleFrame = ccr(bubbleX, BubbleViewPadding + (self.showMessageTimeLabel ? (TimeLabelHeight + TimeLabelPadding) : TimeLabelPadding), getW(self.contentView.bounds) - bubbleX- bubbleOffX, getW(self.contentView.bounds) - (BubbleViewPadding + (self.showMessageTimeLabel ? TimeLabelHeight + TimeLabelPadding : TimeLabelPadding)));
            
            ZJMessgeBubbleView *messageBubbleView = [[ZJMessgeBubbleView alloc]initWithFrame:bubbleFrame message:message];
            messageBubbleView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight |UIViewAutoresizingFlexibleBottomMargin;
            messageBubbleView.backgroundColor = BubbleBackgroundColor;
            [self.contentView addSubview:messageBubbleView];
            [self.contentView sendSubviewToBack:messageBubbleView];
            _messageBubbleView = messageBubbleView;
        }
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return self;
}

#pragma mark - Life cycle

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat avatorOriginY = AvatorPaddingY + (self.showMessageTimeLabel ? TimeLabelHeight : 0.0f);
    CGRect avatorFrame = self.avatorButton.frame;
    avatorFrame.origin.y = avatorOriginY;
    avatorFrame.origin.x = ([self bubbleMessageReceiveSendType] == ZJMessageTypeReceive) ? AvatorPaddingX : (getW(self.bounds) - AvatorPaddingX - AvatorSize);
    
    CGFloat bubbleOriginY = BubbleViewPadding + (self.showMessageTimeLabel ? TimeLabelHeight : 0.0f);
    CGRect bubbleViewFrame = self.messageBubbleView.frame;
    bubbleViewFrame.origin.y = bubbleOriginY;
    
    CGFloat bubbleX = 0.0f;
    if ([self bubbleMessageReceiveSendType] == ZJMessageTypeReceive)
    {
        bubbleX = AvatorSize + AvatorPaddingX * 2;
    }
    bubbleViewFrame.origin.x = bubbleX;
    bubbleViewFrame.size.height = [ZJMessgeBubbleView calculateCellHeightWithMessage:self.messageBubbleView.message];
    
    self.avatorButton.frame = avatorFrame;
    self.messageBubbleView.frame = bubbleViewFrame;
}


- (ZJMessageReceiveSendType)bubbleMessageReceiveSendType
{
    return self.messageBubbleView.message.messageReceiveSendType;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [_messageBubbleView notReuseTextView];
}


#pragma mark - 配置

//重新配置cell
- (void)configureCellWithMessage:(id <ZJMessageModel>)message
                 showMessageTime:(BOOL)showMessageTime
{
    //配置时间标签
    [self configureTimeLabel:message showMessageTimeLabel:showMessageTime];
    //配置头像
    [self configureAvatorWithMessage:message];
    //配置消息内容
    [self configureMessageBubbleViewWithMessage:message];
}

//配置时间标签
- (void)configureTimeLabel:(id <ZJMessageModel>)message showMessageTimeLabel:(BOOL)showMessageTime
{
    self.showMessageTimeLabel = showMessageTime;
    self.messageTimeLabel.text = message.messageTime;
//    [self.messageTimeLabel sizeToFit];
//    [self.messageTimeLabel sizeThatFits:CGSizeZero];
    self.messageTimeLabel.hidden = !self.showMessageTimeLabel;
}

//配置头像
- (void)configureAvatorWithMessage:(id <ZJMessageModel>)message
{
    if(message.avatorUrl)
    {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:message.avatorUrl ofType:@"png"];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSData *imageData = [fileManager contentsAtPath:filePath];
        if (imageData.length)
        {
            UIImage *image = [UIImage imageWithData:imageData];
            if (image)
            {
                [self.avatorButton setImage:image forState:UIControlStateNormal];
            }
        }
    }
}

//配置消息内容
- (void)configureMessageBubbleViewWithMessage:(id <ZJMessageModel>)message
{
    [self.messageBubbleView configureBubbleWithMessage:message];
    [self configureGestureWithMessage:message];
    return;
    //单击、长按事件改在cell中处理
    
    __weak typeof(self) weakSelf = self;
    
    [self.messageBubbleView configureBubbleWithMessage:message
                                              tapBlock:^(id<ZJMessageModel> message, UIImageView *audioImageView) {
                                                  [weakSelf bubbleTap:message withAudioImageView:audioImageView];
                                              } longPressBlock:^(id<ZJMessageModel> message) {
                                                  [weakSelf bubbleLongPress:message];
                                              }
     ];
}

//配置手势
- (void)configureGestureWithMessage:(id <ZJMessageModel>)message
{
    //删除手势
    for (UIGestureRecognizer *gesture in self.messageBubbleView.bubbleImageView.gestureRecognizers)
    {
        [self.messageBubbleView.bubbleImageView removeGestureRecognizer:gesture];
    }
    for (UIGestureRecognizer *gesture in self.messageBubbleView.photoImageView.gestureRecognizers)
    {
        [self.messageBubbleView.photoImageView removeGestureRecognizer:gesture];
    }
    
    //重新添加手势
    switch (message.messageMediaType) {
        case ZJMessageMediaTypeText:
        {
            //单击内容：电话、超链接跳转，徐富文本支持
            //长按气泡：复制、转发、删除、收藏
        }
            break;
        case ZJMessageMediaTypeAudio:
        {
            //单击气泡：播放、暂停
            //长按气泡：转发、删除、收藏
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [self.messageBubbleView.bubbleImageView addGestureRecognizer:tapGesture];
        }
            break;
        case ZJMessageMediaTypePhoto:
        {
            //单击图片：相册展示
            //长按气泡：转发、删除、收藏
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [self.messageBubbleView.photoImageView addGestureRecognizer:tapGesture];
        }
            break;
        case ZJMessageMediaTypeVideo:
        {
            //单击图片：视频播放
            //长按气泡：转发、删除、收藏
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
            [self.messageBubbleView.photoImageView addGestureRecognizer:tapGesture];
        }
            break;
            
        default:
            break;
    }
}


//计算cell高度
+ (CGFloat)calculateCellHeightWithMessage:(id <ZJMessageModel>)message
                          showMessageTime:(BOOL)showMessageTime
{
    CGFloat messageTimeHeight = showMessageTime ? (TimeLabelHeight + TimeLabelPadding * 2) : TimeLabelPadding;
    CGFloat avatorHeight = AvatorSize;
    CGFloat subviewHeight = messageTimeHeight + BubbleViewPadding * 2;
    CGFloat bubbleHeight = [ZJMessgeBubbleView calculateCellHeightWithMessage:message];
    CGFloat height = subviewHeight + MAX(avatorHeight, bubbleHeight);
    return height;
}

#pragma mark - 按钮 点击
//头像点击事件
- (void)avatorButtonClick:(id)sender
{
    
}

#pragma mark - 气泡 手势
- (void)tapAction:(UITapGestureRecognizer *)gesture
{
    id <ZJMessageModel> message = self.messageBubbleView.message;
    
    
    switch (message.messageMediaType) {
        case ZJMessageMediaTypeText:
        {
            //单击内容：电话、超链接跳转，徐富文本支持
            NSLog(@"单击内容：电话、超链接跳转，徐富文本支持");
        }
            break;
        case ZJMessageMediaTypeAudio:
        {
            //单击气泡：播放、暂停
            NSLog(@"单击气泡：播放、暂停");
            [self bubbleTap:self.messageBubbleView.message withAudioImageView:self.messageBubbleView.audioImageView];
        }
            break;
        case ZJMessageMediaTypePhoto:
        {
            //单击图片：相册展示
            NSLog(@"单击图片：相册展示");
            [self imageViewTap:message];
        }
            break;
        case ZJMessageMediaTypeVideo:
        {
            //单击图片：视频播放
            NSLog(@"单击图片：视频播放");
            [self imageViewTap:message];
       }
            break;
        default:
            break;
    }
    
}

//气泡单击
- (void)bubbleTap:(id <ZJMessageModel>)message withAudioImageView:(UIImageView *)imageView
{
    switch (message.messageMediaType) {
        case ZJMessageMediaTypeAudio:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(didTapBubbleWithMessage:withAudioImageView:)])
            {
                [self.delegate didTapBubbleWithMessage:message withAudioImageView:imageView];
            }
        }
            break;
            
        default:
            break;
    }
}


//气泡长按
- (void)bubbleLongPress:(id <ZJMessageModel>)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didLongPressBubbleWithMessage:)])
    {
        [self.delegate didLongPressBubbleWithMessage:message];
    }
}

//图片单击
- (void)imageViewTap:(id <ZJMessageModel>)message
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didTapImageViewWithMessage:)]) {
        [self.delegate didTapImageViewWithMessage:message];
    }
}

@end
