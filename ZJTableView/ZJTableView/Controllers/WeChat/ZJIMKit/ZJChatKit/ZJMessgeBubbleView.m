//
//  ZJMessgeBubbleView.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/15.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJMessgeBubbleView.h"
#import <CoreText/CoreText.h>
#import "MLEmojiLabel.h"

#define ADJUST_HEIGHT           20.0f
#define ADJUST_RIGHT_WIDTH      10.0f

@interface ZJMessgeBubbleView () <MLEmojiLabelDelegate>

//数据对象
@property (strong, nonatomic, readwrite) id <ZJMessageModel> message;

//文本消息控件
@property (weak, nonatomic, readwrite) UITextView *textView;
@property (weak, nonatomic, readwrite) MLEmojiLabel *textLabel;

//汽包背景图片
@property (weak, nonatomic, readwrite) UIImageView *bubbleImageView;

//语音背景图片
@property (weak, nonatomic, readwrite) UIImageView *audioImageView;

//语音时长的label
@property (weak, nonatomic, readwrite) UILabel *audioDurationLabel;

//照片的图片控件
@property (weak, nonatomic, readwrite) UIImageView *photoImageView;

//视频的图片控件
@property (weak, nonatomic, readwrite) UIImageView *videoPlayImageView;


//正在发送指示器
@property (weak, nonatomic, readwrite) UIActivityIndicatorView *sendingActivityIndicatorView;
//发送失败图片
@property (weak, nonatomic, readwrite) UIImageView *sendFailedImageView;


////手势
////单击
//@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
////长按
//@property (strong, nonatomic) UILongPressGestureRecognizer *longPressGesture;

@end

@implementation ZJMessgeBubbleView

//初始化方法
- (instancetype)initWithFrame:(CGRect)frame
                      message:(id <ZJMessageModel>)message
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _message = message;
        //初始化气泡
        if (!_bubbleImageView)
        {
            UIImageView *bubbleImageView = [[UIImageView alloc]initWithFrame:self.bounds];
            bubbleImageView.userInteractionEnabled = YES;
            [self addSubview:bubbleImageView];
            _bubbleImageView = bubbleImageView;
        }
        
        //初始化文本
//        if (!_textView)
//        {
//            UITextView *textView = [[UITextView alloc]initWithFrame:CGRectZero];
//            textView.backgroundColor = TextBackgroundColor;
//            textView.font = [UIFont systemFontOfSize:15.0f];
//            textView.editable = NO;
//            textView.selectable = YES;
//            textView.dataDetectorTypes = UIDataDetectorTypeAll;
//            //textView.userInteractionEnabled = NO;
//            [self addSubview:textView];
//            _textView = textView;
//        }
        
        if (!_textLabel)
        {
            MLEmojiLabel *textLabel = [[MLEmojiLabel alloc]initWithFrame:CGRectZero];
            textLabel.numberOfLines = 0;
            textLabel.font = [UIFont systemFontOfSize:15.0f];
            textLabel.textAlignment = NSTextAlignmentLeft;
            textLabel.backgroundColor = [UIColor clearColor];
            textLabel.delegate = self;
            textLabel.isNeedAtAndPoundSign = NO;
            [self addSubview:textLabel];
            _textLabel = textLabel;
        }
        
        //初始化语音时长文本
        if (!_audioDurationLabel)
        {
            UILabel *audioDurationLabel = [[UILabel alloc]initWithFrame:ccr(0, 0, audioLabelWidth, audioLabelHeight)];
            audioDurationLabel.textColor = [UIColor lightGrayColor];
            audioDurationLabel.backgroundColor = [UIColor clearColor];
            audioDurationLabel.font = [UIFont systemFontOfSize:10.0f];
            audioDurationLabel.hidden = YES;
            [self addSubview:audioDurationLabel];
            _audioDurationLabel = audioDurationLabel;
        }
        
        //初始化图片控件
        if (!_photoImageView)
        {
            UIImageView *photoImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
            photoImageView.backgroundColor = [UIColor clearColor];
            photoImageView.image = [UIImage imageNamed:@"sharemore_placeholder"];
//            photoImageView.layer.cornerRadius = 5.0f;
            photoImageView.userInteractionEnabled = YES;
            
            //
            photoImageView.layer.cornerRadius = 10.0f;
            photoImageView.layer.masksToBounds = YES;
            [photoImageView setContentMode:UIViewContentModeScaleAspectFill];
            [photoImageView setClipsToBounds:YES];
            photoImageView.layer.shadowColor = [UIColor whiteColor].CGColor;
            photoImageView.layer.shadowOffset = CGSizeMake(4.0, 4.0);
            photoImageView.layer.shadowOpacity = 0.5;
            photoImageView.layer.shadowRadius = 2.0;
            photoImageView.layer.borderColor = [UIColor whiteColor].CGColor;
            photoImageView.layer.borderWidth = 2.0f;
            [self addSubview:photoImageView];
            _photoImageView = photoImageView;
            
            
            if (!_videoPlayImageView)
            {
                UIImageView *videoImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MessageVideoPlay"]];
                videoImageView.frame = ccr(0, 0, videoImageSize, videoImageSize);
                videoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
                [_photoImageView addSubview:videoImageView];
                _videoPlayImageView = videoImageView;
            }
        }
        
        //初始化正在发送指示器
        if (!_sendingActivityIndicatorView)
        {
            UIActivityIndicatorView *sendingActivityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            sendingActivityIndicatorView.center = self.center;
            [self addSubview:sendingActivityIndicatorView];
            [sendingActivityIndicatorView startAnimating];
            _sendingActivityIndicatorView = sendingActivityIndicatorView;
            
            
            UIImageView *sendFailImageView = [[UIImageView alloc]initWithFrame:ccr(0, 0, 20, 20)];
            sendFailImageView.image = [UIImage imageNamed:@"sharemore_location"];
            sendFailImageView.center = self.center;
            [self addSubview:sendFailImageView];
            _sendFailedImageView = sendFailImageView;
            _sendFailedImageView.hidden = YES;
        }
        
        
        
//        //初始化单击
//        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bubbleImageViewTap:)];
//        _tapGesture = tapGesture;
//        //初始化长按
//        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(bubbleImageViewLongPress:)];
//        _longPressGesture = longPressGesture;
        
    }
    return self;
}


- (void)dealloc
{
    _message = nil;
//    _textView = nil;
    _textLabel = nil;
    _bubbleImageView = nil;
    _audioImageView = nil;
    _audioDurationLabel = nil;
}

//不重用textView
- (void)notReuseTextView
{
//    _textView.editable = NO;
//    _textView.selectable = NO;
//    
//    _textView.editable = NO;
//    _textView.selectable = YES;
}


//根据数据来配置bubble
- (void)configureBubbleWithMessage:(id <ZJMessageModel>)message
{
    _message = message;
    [self configureBubbleImageWithMessage:message];
    [self configureMediaWithMessage:message];
}
- (void)configureBubbleWithMessage:(id <ZJMessageModel>)message
                          tapBlock:(BubbleTapBlock)tapBlock
                    longPressBlock:(BubbleLongPressBlock)longPressBlock
{
    _message = message;
    _bubbleTapBlock = tapBlock;
    _bubbleLongPressBlock = longPressBlock;
    [self configureBubbleImageWithMessage:message];
    [self configureMediaWithMessage:message];
}

//重新配置气泡
- (void)configureBubbleImageWithMessage:(id <ZJMessageModel>)message
{
    ZJMessageMediaType mediaType = message.messageMediaType;
    switch (mediaType) {
        case ZJMessageMediaTypeText:
        {
            _bubbleImageView.frame = [ZJMessgeBubbleView bubbleFrameWithMessage:message];
            _bubbleImageView.image = [self bubbleImageWithMessage:message];
            _bubbleImageView.hidden = NO;
            
//            _textView.hidden = NO;
            _textLabel.hidden = NO;
            _audioImageView.hidden = YES;
            _audioDurationLabel.hidden = YES;
            _photoImageView.hidden = YES;
            _photoImageView.image = nil;
            _videoPlayImageView.hidden = YES;
        }
            break;
        case ZJMessageMediaTypeAudio:
        {
            _bubbleImageView.frame = [ZJMessgeBubbleView bubbleFrameWithMessage:message];
            _bubbleImageView.image = [self bubbleImageWithMessage:message];
            _bubbleImageView.hidden = NO;
            
            [_audioImageView removeFromSuperview];
            _audioImageView = nil;
            
            //语音动效
            UIImageView *audioImageView = [self messageVoiceAnimationImageViewWithBubbleMessageType:message.messageReceiveSendType];
            [self addSubview:audioImageView];
            _audioImageView = audioImageView;
//            _textView.hidden = YES;
            _textLabel.hidden = YES;
            _audioImageView.hidden = NO;
            _audioDurationLabel.hidden = NO;
            _photoImageView.hidden = YES;
            _photoImageView.image = nil;
            _videoPlayImageView.hidden = YES;
        }
            break;
        case ZJMessageMediaTypePhoto:
        {
            _photoImageView.hidden = NO;
            
//            _textView.hidden = YES;
            _textLabel.hidden = YES;
            _bubbleImageView.hidden = YES;
            _audioImageView.hidden = YES;
            _audioDurationLabel.hidden = YES;
            _videoPlayImageView.hidden = YES;
        }
            break;
        case ZJMessageMediaTypeVideo:
        {
            _photoImageView.hidden = NO;
            _videoPlayImageView.hidden = NO;
            
//            _textView.hidden = YES;
            _textLabel.hidden = YES;
           _bubbleImageView.hidden = YES;
            _audioImageView.hidden = YES;
            _audioDurationLabel.hidden = YES;
        }
            break;
        default:
            break;
    }
    
    
    //发送状态，文字和音频放在气泡左侧
    if (mediaType == ZJMessageMediaTypeText || mediaType == ZJMessageMediaTypeAudio)
    {
        CGFloat distance = mediaType == ZJMessageMediaTypeText ? 20.0f : 40.0f;
        CGPoint center = ccp(CGRectGetMinX(_bubbleImageView.frame) - distance, _bubbleImageView.center.y);
        _sendingActivityIndicatorView.center = center;
        _sendFailedImageView.center = center;
        [self configureSendingStateWithMessage:message];
    }

}

//重新配置多媒体
- (void)configureMediaWithMessage:(id<ZJMessageModel>)message
{
    ZJMessageMediaType mediaType = message.messageMediaType;
    switch (mediaType) {
        case ZJMessageMediaTypeText:
        {
//            self.textView.text = _message.text;
#define textWith    (CGRectGetWidth([[UIScreen mainScreen] bounds]) * (IsiPad ? 0.8 : 0.55))
//            CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (IsiPad ? 0.8 : 0.55);
//            CGSize textSize = [self.textView sizeThatFits:CGSizeMake(maxWidth, FLT_MAX)];
//            NSLog(@"textSize.height is %.2f",textSize.height);
            CGRect frame = CGRectIntegral([self textFrameWithBubbleFrame:[ZJMessgeBubbleView bubbleFrameWithMessage:message]]);;
//            self.textView.frame = ccr(frame.origin.x, frame.origin.y, textSize.width, textSize.height);
            _textLabel.text = _message.text;
            CGSize size = [_textLabel preferredSizeWithMaxWidth:textWith];
            _textLabel.frame = ccr(frame.origin.x, frame.origin.y + textLabelPadding, size.width, size.height);
            NSLog(@"_textLabel frame is %.2f,%.2f,%.2f,%.2f",_textLabel.frame.origin.x,_textLabel.frame.origin.y,_textLabel.frame.size.width,_textLabel.frame.size.height);
            
//            _textView.frame = CGRectIntegral([self textFrameWithBubbleFrame:[ZJMessgeBubbleView bubbleFrameWithMessage:message]]);
        }
            break;
        case ZJMessageMediaTypeAudio:
        {
            CGRect audioImageViewFrame = _audioImageView.frame;
            CGPoint audioImageViewOriginal = [self audioOriginalPointWithBubbleFrame:[ZJMessgeBubbleView bubbleFrameWithMessage:message]];
            _audioImageView.frame = ccr(audioImageViewOriginal.x, audioImageViewOriginal.y, audioImageViewFrame.size.width, audioImageViewFrame.size.height);
            
            CGRect audioLabelFrame = _audioDurationLabel.frame;
            CGPoint audioLabelOriginal = [self audioDurationOriginalPointWithBubbleFrame:[ZJMessgeBubbleView bubbleFrameWithMessage:message]];
            _audioDurationLabel.frame = ccr(audioLabelOriginal.x, audioLabelOriginal.y, audioLabelFrame.size.width, audioLabelFrame.size.height);
            _audioDurationLabel.text = [NSString stringWithFormat:@"%@''",message.audioDuration];
            _audioDurationLabel.textAlignment = (message.messageReceiveSendType == ZJMessageTypeReceive ? NSTextAlignmentLeft: NSTextAlignmentRight);
            
        }
            break;
        case ZJMessageMediaTypePhoto:
        case ZJMessageMediaTypeVideo:
        {
            _photoImageView.frame = [self photoFrameWithBubbleFrame:[ZJMessgeBubbleView bubbleFrameWithMessage:message]];
            _videoPlayImageView.center = _photoImageView.center;
            if (message.photo || message.videoScreenshotPhoto)
                _photoImageView.image = (ZJMessageMediaTypePhoto == message.messageMediaType ? message.photo : message.videoScreenshotPhoto);
            else if (message.thumbnailPhotoPath)
                _photoImageView.image = [UIImage imageWithContentsOfFile:message.thumbnailPhotoPath];
            
            
            //发送状态，图片和视频没有气泡，放在图片左侧
            CGPoint center = ccp(CGRectGetMinX(_photoImageView.frame) - 20.0f, _photoImageView.center.y);
            _sendingActivityIndicatorView.center = center;
            _sendFailedImageView.center = center;
            [self configureSendingStateWithMessage:message];
        }
            break;
        default:
            break;
    }
}

//设置发送控件的状态
- (void)configureSendingStateWithMessage:(id<ZJMessageModel>)message
{
    if (ZJMessageTypeSend == message.messageReceiveSendType)
    {
        switch (message.messageSendStateType) {
            case ZJMessageSendStateNone:
            case ZJMessageSendStateSuccess:
            {
                [_sendingActivityIndicatorView stopAnimating];
                _sendingActivityIndicatorView.hidden = YES;
                _sendFailedImageView.hidden = YES;
            }
                break;
            case ZJMessageSendStateSending:
            {
                [_sendingActivityIndicatorView startAnimating];
                _sendingActivityIndicatorView.hidden = NO;
                _sendFailedImageView.hidden = YES;
            }
                break;
            case ZJMessageSendStateFail:
            {
                [_sendingActivityIndicatorView stopAnimating];
                _sendingActivityIndicatorView.hidden = YES;
                _sendFailedImageView.hidden = NO;
            }
            default:
                break;
        }
    }
    else
    {
        [_sendingActivityIndicatorView stopAnimating];
        _sendingActivityIndicatorView.hidden = YES;
        _sendFailedImageView.hidden = YES;
    }
}


static const CGFloat bubbleMarginTop = 8.0f;
static const CGFloat bubbleMarginBottom = 2.0f;

static const CGFloat textLabelPadding = 10;

static const CGFloat bubblePaddingRight = 10.0f;
static const CGFloat bubbleArrowPaddingWidth = 5.0f;

static const CGFloat maxAudioDuration = 60.0f;
static const CGFloat audioBubbleHeight = 36.0f;
static const CGFloat audioPadding = 20.0f;
static const CGFloat audioLabelWidth = 40.0f;
static const CGFloat audioLabelHeight = 20.0f;
static const CGFloat audioLabelPadding = 0.0f;

static const CGFloat photoImageSize = 100.0f;
static const CGFloat videoImageSize = 80.0f;

////计算气泡的size
//- (CGSize)bubbleSize
//{
//    CGSize size;
//    ZJMessageMediaType mediaType = _message.messageMediaType;
//    switch (mediaType) {
//        case ZJMessageMediaTypeText:
//        {
//            NSString *text = _message.text;
//            CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (IsiPad ? 0.8 : 0.55);
//            
//            NSDictionary *textAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f]};
//            CGRect textRect = [text boundingRectWithSize:ccs(maxWidth, MAXFLOAT) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:textAttribute context:nil];
//            
//            size = ccs(getW(textRect) + bubblePaddingRight * 2 + bubbleArrowPaddingWidth, getH(textRect));
//        }
//            break;
//            
//        default:
//            break;
//    }
//    return size;
//}

//计算气泡的size
+ (CGSize)bubbleSizeWithMessage:(id <ZJMessageModel>)message
{
    CGSize size;
    ZJMessageMediaType mediaType = message.messageMediaType;
    switch (mediaType) {
        case ZJMessageMediaTypeText:
        {
            //方案一
//            NSString *text = message.text;
//            CGFloat maxWidth = CGRectGetWidth([[UIScreen mainScreen] bounds]) * (IsiPad ? 0.8 : 0.55);
//
//            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//            paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//            NSDictionary *textAttribute = @{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],NSParagraphStyleAttributeName:paragraphStyle.copy};
//
//            CGRect textRect = [text boundingRectWithSize:ccs(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:textAttribute context:nil];
//            CGSize tempSize = ccs(getW(textRect) + bubblePaddingRight * 2 + bubbleArrowPaddingWidth, getH(textRect) + bubbleMarginTop * 2 + bubbleMarginBottom);
//            size = ccs(tempSize.width + ADJUST_RIGHT_WIDTH, tempSize.height);// - ADJUST_RIGHT_WIDTH);
            
            MLEmojiLabel *tempLabel = [[MLEmojiLabel alloc]init];
            tempLabel.numberOfLines = 0;
            tempLabel.font = [UIFont systemFontOfSize:15.0f];
            tempLabel.text = message.text;
            CGSize labelSize = [tempLabel preferredSizeWithMaxWidth:textWith];
            CGSize tempSize = ccs(labelSize.width + textLabelPadding * 2 + bubbleArrowPaddingWidth, labelSize.height + textLabelPadding * 2);
#warning xxxxxx
//            CGRect textRect = [text boundingRectWithSize:ccs(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:textAttribute context:nil];
//            CGSize tempSize = ccs(getW(textRect) + bubblePaddingRight * 2 + bubbleArrowPaddingWidth, getH(textRect) + bubbleMarginTop * 2 + bubbleMarginBottom);
            size = ccs(tempSize.width + ADJUST_RIGHT_WIDTH, tempSize.height);// - ADJUST_RIGHT_WIDTH);

            
            //方案二
//            NSAttributedString *attri = [[NSAttributedString alloc]initWithString:text attributes:textAttribute];
//            CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attri);
//            CGSize targetSize = CGSizeMake(maxWidth, CGFLOAT_MAX);
//            CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, [text length]), NULL, targetSize, NULL);
//            CFRelease(framesetter);
//            
//            size = ccs(fitSize.width + bubblePaddingRight * 2 + bubbleArrowPaddingWidth, fitSize.height + bubbleMarginTop * 2 + bubbleMarginBottom);
            
        }
            break;
        case ZJMessageMediaTypeAudio:
        {
            NSString *audioDuration = message.audioDuration;
            float duration = [audioDuration floatValue];
            CGFloat audioWidth = 80 + duration / maxAudioDuration * 150;
            size = ccs(audioWidth, audioBubbleHeight);
            
        }
            break;
        case ZJMessageMediaTypePhoto:
        case ZJMessageMediaTypeVideo:
        {
            size = ccs(photoImageSize, photoImageSize);
        }
            break;
        default:
            break;
    }
    return size;
}


////计算气泡的frame
//- (CGRect)bubbleFrame
//{
//    CGSize bubbleSize = [self bubbleSize];
//    
//    CGRect bubbleRect = ccr((_message.messageReceiveSendType == ZJMessageTypeSend) ? getW(self.bounds) - bubbleSize.width : 0.0f, bubbleMarginTop, bubbleSize.width, bubbleSize.height + bubbleMarginTop + bubbleMarginBottom);
//    return bubbleRect;
//}
static const CGFloat AvatorPaddingX = 8.0f;
//static const CGFloat AvatorPaddingY = 15.0f;
static const CGFloat AvatorSize = AvatorSizeDefine;
//计算气泡的frame
+ (CGRect)bubbleFrameWithMessage:(id <ZJMessageModel>)message
{
    CGSize bubbleSize = [ZJMessgeBubbleView bubbleSizeWithMessage:message];
    
    CGRect bubbleRect = ccr((message.messageReceiveSendType == ZJMessageTypeSend) ? getW([[UIScreen mainScreen] bounds]) - bubbleSize.width - (AvatorSize + AvatorPaddingX * 2): 0.0f, bubbleMarginTop, bubbleSize.width, bubbleSize.height);
    NSLog(@"气泡的frame：%.2f-%.2f/%.2f-%.2f",bubbleRect.origin.x,bubbleRect.origin.y,bubbleRect.size.width,bubbleRect.size.height);
    
    return bubbleRect;
}


//计算文本的frame
- (CGRect)textFrameWithBubbleFrame:(CGRect)bubbleFrame
{
    CGFloat frameX = (self.message.messageReceiveSendType == ZJMessageTypeReceive) ? CGRectGetMinX(bubbleFrame) + bubblePaddingRight + bubbleArrowPaddingWidth * 2: CGRectGetMinX(bubbleFrame) + bubblePaddingRight;
    CGRect frame = ccr(frameX, CGRectGetMinY(bubbleFrame), getW(bubbleFrame) - bubblePaddingRight * 2 - bubbleArrowPaddingWidth, getH(bubbleFrame) - bubbleMarginBottom);
//    NSLog(@"文本的frame：%.2f-%.2f/%.2f-%.2f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    return frame;
}

//计算Audio的frame
- (CGPoint)audioOriginalPointWithBubbleFrame:(CGRect)bubbleFrame
{
    CGFloat frameX = (self.message.messageReceiveSendType == ZJMessageTypeReceive) ? CGRectGetMinX(bubbleFrame) + bubblePaddingRight + bubbleArrowPaddingWidth + audioPadding : CGRectGetMinX(bubbleFrame) + getW(bubbleFrame) - bubblePaddingRight * 2 - bubbleArrowPaddingWidth - audioPadding;
    CGPoint original = ccp(frameX, bubblePaddingRight + 10);
    return original;
}

//计算audio时长的frame
- (CGPoint)audioDurationOriginalPointWithBubbleFrame:(CGRect)bubbleFrame
{
    CGFloat frameX = (self.message.messageReceiveSendType == ZJMessageTypeReceive) ? CGRectGetMinX(bubbleFrame) + getW(bubbleFrame) + audioLabelPadding : CGRectGetMinX(bubbleFrame) - audioLabelPadding - audioLabelWidth;
    CGPoint original = ccp(frameX, bubblePaddingRight + 10);
    return original;
}

//计算photo的frame
- (CGRect)photoFrameWithBubbleFrame:(CGRect)bubbleFrame
{
    CGRect frame = ccr(CGRectGetMinX(bubbleFrame), CGRectGetMinY(bubbleFrame), photoImageSize, photoImageSize);
    return frame;
}


//根据数据计算高度
+ (CGFloat)calculateCellHeightWithMessage:(id <ZJMessageModel>)message
{
    CGRect bubbleFrame = [ZJMessgeBubbleView bubbleFrameWithMessage:message];
//    NSLog(@"cell高度：%.2f",CGRectGetHeight(CGRectIntegral(bubbleFrame)));
    return CGRectGetHeight(CGRectIntegral(bubbleFrame));
//    NSLog(@"cell高度：%.2f",CGRectGetHeight(CGRectIntegral(bubbleFrame)) + bubbleMarginTop + bubbleMarginBottom);
//    return CGRectGetHeight(CGRectIntegral(bubbleFrame)) + bubbleMarginTop + bubbleMarginBottom;
}

//根据发送状态设置展示控件
- (void)configureSendingSuccess:(BOOL)success
{
    [_sendingActivityIndicatorView stopAnimating];
    _sendingActivityIndicatorView.hidden = YES;
    _sendFailedImageView.hidden = success;
}


#pragma mark - other funs
//气泡背景图片
- (UIImage *)bubbleImageWithMessage:(id <ZJMessageModel>)message
{
    NSMutableString *imageName = [NSMutableString stringWithString:@"weChatBubble"];
    ZJMessageReceiveSendType receiveSendType = message.messageReceiveSendType;
    switch (receiveSendType) {
        case ZJMessageTypeReceive:
            [imageName appendString:@"_Receiving"];
            break;
        case ZJMessageTypeSend:
            [imageName appendString:@"_Sending"];
            break;
        default:
            break;
    }
    
    ZJMessageMediaType mediaType = message.messageMediaType;
    switch (mediaType) {
        case ZJMessageMediaTypeText:
        case ZJMessageMediaTypeAudio:
            [imageName appendString:@"_Solid"];
            break;
        case ZJMessageMediaTypePhoto:
        case ZJMessageMediaTypeVideo:
            [imageName appendString:@"_Solid"];
            break;
        default:
            break;
    }
    
    UIImage *image = [UIImage imageNamed:imageName];
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(30, 28, 85, 28);
    return IMAGE_STRETCH(image, edgeInsets);
}

- (UIImageView *)messageVoiceAnimationImageViewWithBubbleMessageType:(ZJMessageReceiveSendType)type
{
    UIImageView *messageVoiceAniamtionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    NSString *imageSepatorName;
    switch (type) {
        case ZJMessageTypeSend:
            imageSepatorName = @"Sender";
            break;
        case ZJMessageTypeReceive:
            imageSepatorName = @"Receiver";
            break;
        default:
            break;
    }
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:4];
    for (NSInteger i = 0; i < 4; i ++) {
        UIImage *image = [UIImage imageNamed:[imageSepatorName stringByAppendingFormat:@"VoiceNodePlaying00%ld", (long)i]];
        if (image)
            [images addObject:image];
    }
    
    messageVoiceAniamtionImageView.image = [UIImage imageNamed:[imageSepatorName stringByAppendingString:@"VoiceNodePlaying"]];
    messageVoiceAniamtionImageView.animationImages = images;
    messageVoiceAniamtionImageView.animationDuration = 1.0;
    [messageVoiceAniamtionImageView stopAnimating];
    
    return messageVoiceAniamtionImageView;
}


#pragma mark - Gesture
- (void)bubbleImageViewTap:(UIGestureRecognizer *)gesture
{
    switch (_message.messageMediaType) {
        case ZJMessageMediaTypeAudio:
        {
            _bubbleTapBlock(_message,_audioImageView);
        }
            break;
            
        default:
            break;
    }
}

- (void)bubbleImageViewLongPress:(UILongPressGestureRecognizer *)gesture
{
    
}

#pragma mark - MLEmojiLabelDelegate
- (void)mlEmojiLabel:(MLEmojiLabel*)emojiLabel didSelectLink:(NSString*)link withType:(MLEmojiLabelLinkType)type
{
    switch(type){
        case MLEmojiLabelLinkTypeURL:
            NSLog(@"点击了链接%@",link);
            break;
        case MLEmojiLabelLinkTypePhoneNumber:
            NSLog(@"点击了电话%@",link);
            break;
        case MLEmojiLabelLinkTypeEmail:
            NSLog(@"点击了邮箱%@",link);
            break;
        case MLEmojiLabelLinkTypeAt:
            NSLog(@"点击了用户%@",link);
            break;
        case MLEmojiLabelLinkTypePoundSign:
            NSLog(@"点击了话题%@",link);
            break;
        default:
            NSLog(@"点击了不知道啥%@",link);
            break;
    }
    
}


@end
