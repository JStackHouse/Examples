//
//  ZJMessageInputView.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/18.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  ZJMessageTextView;


@protocol ZJMessageInputViewDelegate <NSObject>

- (void)inputTextViewWillBeginEditing;

//发送文本
- (void)didSendTextAction:(NSString *)text;

//发送语音
- (void)didSendAudioAction:(NSString *)fileName withDuraion:(NSString *)duration;

//点击多媒体按钮
- (void)didSelectedMultiMediaAction;

@end



@interface ZJMessageInputView : UIView <UITextViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate>

//delegate
@property (weak, nonatomic) id <ZJMessageInputViewDelegate> delegate;

//能否发送语音
@property (assign, nonatomic) BOOL canSendAudio;

//能否发送视频
@property (assign, nonatomic) BOOL canSendVideo;

//能否发送图片
@property (assign, nonatomic) BOOL canSendPhoto;

//能否发送表情
@property (assign, nonatomic) BOOL canSendFace;


//背景图片
@property (weak, nonatomic, readonly) UIImageView *backgroundImageView;

//文本输入框
@property (weak, nonatomic, readonly) ZJMessageTextView *messageTextView;

//切换文字和语音的按钮
@property (weak, nonatomic, readonly) UIButton *wordsAudioChangeButton;

//视频的打开按钮
@property (weak, nonatomic, readonly) UIButton *videoButton;

//录音按钮
//@property (weak, nonatomic, readonly) UIButton *recordAudioButton;
@property (weak, nonatomic, readonly) UIImageView *recordAudioButton;

//表情按钮
@property (weak, nonatomic, readonly) UIButton *faceButton;

//多媒体功能按钮
@property (weak, nonatomic, readonly) UIButton *multiMediaButton;


//动态改变高度
- (void)changeTextViewHeightBy:(CGFloat)changeHeight;




@end
