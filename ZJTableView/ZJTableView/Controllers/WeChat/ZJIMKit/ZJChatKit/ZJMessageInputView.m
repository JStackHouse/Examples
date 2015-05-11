//
//  ZJMessageInputView.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/18.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJMessageInputView.h"
#import "ZJMessageTextView.h"

#define SubViewSize             36
#define HorizontalPadding       8
#define VerticalPadding         4


#define TextButtonTag           10
#define AudioButtonTag          11


@interface ZJMessageInputView ()

//背景图片
@property (weak, nonatomic, readwrite) UIImageView *backgroundImageView;

//文本输入框
@property (weak, nonatomic, readwrite) ZJMessageTextView *messageTextView;

//切换文字和语音的按钮
@property (weak, nonatomic, readwrite) UIButton *wordsAudioChangeButton;

//视频的打开按钮
@property (weak, nonatomic, readwrite) UIButton *videoButton;

//录音按钮
//@property (weak, nonatomic, readwrite) UIButton *recordAudioButton;
@property (weak, nonatomic, readwrite) UIImageView *recordAudioButton;

//表情按钮
@property (weak, nonatomic, readwrite) UIButton *faceButton;

//多媒体功能按钮
@property (weak, nonatomic, readwrite) UIButton *multiMediaButton;

@end

@implementation ZJMessageInputView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor lightGrayColor];
        
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview)
    {
        //切换文字和语音的按钮
        UIButton *wordAudioChangeButton = [[UIButton alloc]initWithFrame:ccr(HorizontalPadding, VerticalPadding, SubViewSize, SubViewSize)];
        //[wordAudioChangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //[wordAudioChangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [wordAudioChangeButton setBackgroundColor:[UIColor lightGrayColor]];
        [wordAudioChangeButton setTitle:@"语音" forState:UIControlStateNormal];
        [wordAudioChangeButton addTarget:self action:@selector(wordAudioChangeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        wordAudioChangeButton.tag = TextButtonTag;
        [self addSubview:wordAudioChangeButton];
        _wordsAudioChangeButton = wordAudioChangeButton;
        
//        //视频的打开按钮
//        UIButton *videoButton = [[UIButton alloc]initWithFrame:ccr(getW(self.frame) - (HorizontalPadding + SubViewSize), VerticalPadding, SubViewSize, SubViewSize)];
//        //[wordAudioChangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        //[wordAudioChangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
//        [videoButton setBackgroundColor:[UIColor lightGrayColor]];
//        [videoButton setTitle:@"视频" forState:UIControlStateNormal];
//        [videoButton addTarget:self action:@selector(videoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:videoButton];
//        _videoButton = videoButton;
        //
        //多媒体功能按钮
        UIButton *multiMediaButton = [[UIButton alloc]initWithFrame:ccr(getW(self.frame) - (HorizontalPadding + SubViewSize), VerticalPadding, SubViewSize, SubViewSize)];
        //[wordAudioChangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //[wordAudioChangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [multiMediaButton setBackgroundColor:[UIColor lightGrayColor]];
        [multiMediaButton setTitle:@"更多" forState:UIControlStateNormal];
        [multiMediaButton addTarget:self action:@selector(multiMediaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:multiMediaButton];
        _multiMediaButton = multiMediaButton;
        
        //表情按钮
        UIButton *faceButton = [[UIButton alloc]initWithFrame:ccr(getW(self.frame) - (HorizontalPadding + SubViewSize) * 2, VerticalPadding, SubViewSize, SubViewSize)];
        //[wordAudioChangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //[wordAudioChangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [faceButton setBackgroundColor:[UIColor lightGrayColor]];
        [faceButton setTitle:@"表情" forState:UIControlStateNormal];
        //[faceButton setTitle:@"照片" forState:UIControlStateNormal];
        [faceButton addTarget:self action:@selector(multiMediaButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:faceButton];
        _faceButton = faceButton;
        
        
        //文本输入框
        CGFloat textViewWidth = getW(self.frame) - (HorizontalPadding + SubViewSize) * 3 - HorizontalPadding * 2;
        ZJMessageTextView *messageTextView = [[ZJMessageTextView alloc]initWithFrame:ccr(HorizontalPadding * 2 + SubViewSize, VerticalPadding, textViewWidth, SubViewSize)];
        messageTextView.backgroundColor = [UIColor whiteColor];
        messageTextView.layer.borderWidth = 2.0f;
        messageTextView.layer.borderColor = [[UIColor grayColor] CGColor];
        messageTextView.layer.cornerRadius = 5.0f;
        messageTextView.delegate = self;
        [self addSubview:messageTextView];
        _messageTextView = messageTextView;
        
        if (self.canSendAudio)
        {
//            UIButton *recordAudioButton = [[UIButton alloc]initWithFrame:_messageTextView.frame];
//            [recordAudioButton setTitle:@"按住 录音" forState:UIControlStateNormal];
//            [recordAudioButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [recordAudioButton setBackgroundColor:[UIColor lightGrayColor]];
//            recordAudioButton.layer.borderWidth = 2.0f;
//            recordAudioButton.layer.borderColor = [[UIColor grayColor] CGColor];
//            recordAudioButton.layer.cornerRadius = 5.0f;
//            [self addSubview:recordAudioButton];
//            recordAudioButton.alpha = 0;
//            _recordAudioButton = recordAudioButton;
            
            UIImageView *recordAudioButton = [[UIImageView alloc]initWithFrame:_messageTextView.frame];
//            [recordAudioButton setImage:@""];
            [recordAudioButton setBackgroundColor:[UIColor lightGrayColor]];
            recordAudioButton.layer.borderWidth = 2.0f;
            recordAudioButton.layer.borderColor = [[UIColor grayColor] CGColor];
            recordAudioButton.layer.cornerRadius = 5.0f;
            [self addSubview:recordAudioButton];
            
            recordAudioButton.alpha = 0;
            recordAudioButton.userInteractionEnabled = YES;
            
//            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(recordAudioTapAcion:)];
//            [recordAudioButton addGestureRecognizer:tapGesture];
            UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(recordAudioLongPress:)];
            [recordAudioButton addGestureRecognizer:longPressGesture];
            _recordAudioButton = recordAudioButton;
        }
        
    }
}

- (void)configureWordAudioChangeButtonWithTag:(int)tag
{
    switch (_wordsAudioChangeButton.tag) {
        case TextButtonTag:
        {
            _wordsAudioChangeButton.tag = AudioButtonTag;
            [_wordsAudioChangeButton setTitle:@"文本" forState:UIControlStateNormal];
            if ([self.delegate respondsToSelector:@selector(downMessageInputView)])
            {
                [self.delegate performSelector:@selector(downMessageInputView)];
            }
            //[_messageTextView resignFirstResponder];
            _messageTextView.alpha = 0;
            _recordAudioButton.alpha = 1;
        }
            break;
        case AudioButtonTag:
        {
            _wordsAudioChangeButton.tag = TextButtonTag;
            [_wordsAudioChangeButton setTitle:@"语音" forState:UIControlStateNormal];
            [_messageTextView becomeFirstResponder];
            _messageTextView.alpha = 1;
            _recordAudioButton.alpha = 0;
        }
            break;
        default:
            break;
    }
}


- (void)dealloc
{
    _backgroundImageView = nil;
    _messageTextView = nil;
    _wordsAudioChangeButton = nil;
    _videoButton = nil;
    _recordAudioButton = nil;
    _faceButton = nil;
}

#pragma mark - button click
//切换文字和语音的按钮点击
- (void)wordAudioChangeButtonClick:(id)sender
{
    UIButton *button = (UIButton *)sender;
    [UIView animateWithDuration:.2f animations:^{
        [self configureWordAudioChangeButtonWithTag:(int)button.tag];
    }];
}

//视频按钮点击
- (void)videoButtonClick:(id)sender
{
    
}


//表情按钮点击
- (void)multiMediaButtonClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedMultiMediaAction)])
    {
        [self.delegate didSelectedMultiMediaAction];
    }
}


//初始化输入控件的内部组件
- (void)initSubComponent
{
    
}


//动态改变高度
- (void)changeTextViewHeightBy:(CGFloat)changeHeight
{
    
}

#pragma mark - delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(inputTextViewWillBeginEditing)]) {
        [self.delegate inputTextViewWillBeginEditing];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (NSOrderedSame == [text compare:@"\n"])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didSendTextAction:)])
        {
            [self.delegate didSendTextAction:_messageTextView.text];
        }
        return NO;
    }
    return YES;
}

#pragma mark - RecordAudio  Gesture
static NSString *__filePath = nil;
- (void)recordAudioLongPress:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //录音按钮换个图片
            NSLog(@"开始录音");
            [[ZJAudioPlayer sharedAudioPlayer] startRecordAudioFile];
            [[ZJAudioHud sharedAudioHud] startHudAnimatingInView:self.superview];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            //录音按钮换个图片
            NSLog(@"结束录音");
            [[ZJAudioPlayer sharedAudioPlayer] stopRecording];
            [[ZJAudioHud sharedAudioHud] stopHudAnimating];
            NSString *fileName = [[ZJAudioPlayer sharedAudioPlayer] fileName];
            NSString *duration = [[ZJAudioPlayer sharedAudioPlayer] audioDuration];
            if (self.delegate && [self.delegate respondsToSelector:@selector(didSendAudioAction:withDuraion:)])
            {
                [self.delegate didSendAudioAction:fileName withDuraion:duration];
            }
        }
            break;
        default:
            break;
    }
}

//- (void)recordAudioTapAcion:(UITapGestureRecognizer *)gesture
//{
//    switch (gesture.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            //录音按钮换个图片
//            NSLog(@"录音时间太短");
//        }
//            break;
//        default:
//            break;
//    }
//}


#pragma mark - UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (actionSheet.tag == photoActionSheetTag) {
//        switch (buttonIndex) {
//            case 0:
//            {
//                //相册
//                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
//                    
//                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
//                    imagePicker.delegate = self;
//                    
//                    imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//                    
//                    [UIApplication sharedApplication].window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
////                    [[AppDelegate sharedAppDelegate].window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
//                    
//                }
//                else
//                {
//                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"无法获取照片" message:@"目前相册不可用！" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
//                    [alertView show];
//                }
//            }
//                break;
//            case 1:
//            {
//                //拍照
//                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//                    
//                    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
//                    imagePicker.delegate = self;
//                    
//                    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//                    
//                    [[AppDelegate sharedAppDelegate].window.rootViewController presentViewController:imagePicker animated:YES completion:nil];
//                    
//                }
//                else
//                {
//                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"无法获取照片" message:@"目前相机不可用！" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
//                    [alertView show];
//                }
//            }
//                break;
//            default:
//                break;
//        }
//    }
//}

@end
