//
//  ZJChatTableViewController.h
//  ZJTableView
//
//  Created by zhangjie on 14/12/12.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZJMessage;
@class ZJChatTableViewCell;
@class ZJMessageInputView;
@class ZJMultiMediaView;
@class ZJMultiMediaItem;
@protocol ZJChatTableViewCellDelegate;
@protocol ZJMessageInputViewDelegate;
@protocol ZJMultiMediaViewDelegate;


@protocol ZJChatTableViewControllerDelegate <NSObject>

@required

//是否滚动到顶端时自动加载旧信息
- (BOOL)wouldLoadMoreMessagesWhenScrollToTop;

@optional

//配置cell的样式或者字体
- (void)configureCell:(ZJChatTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

//设置cell上的时间标签显示与否
- (BOOL)wouldShowMessageTimeForRowAtIndexPath:(NSIndexPath *)indexPath;

//是否自动加载信息时不干扰用户手动操作
- (BOOL)wouldPreventUserScrolling;

//滚动到顶端时自动加载旧信息处理
- (void)loadMoreMessagesWhenScrollToTop;


@end

@protocol ZJChatTableViewControllerDataSource <NSObject>



@end


@interface ZJChatTableViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,ZJChatTableViewControllerDelegate,ZJChatTableViewControllerDataSource,ZJChatTableViewCellDelegate,ZJMessageInputViewDelegate,ZJMultiMediaViewDelegate>
//delegate
@property (weak, nonatomic) id <ZJChatTableViewControllerDelegate> delegate;
//datasource
@property (weak, nonatomic) id <ZJChatTableViewControllerDataSource> dataSource;

//数据源
@property (strong, nonatomic) NSMutableArray *messages;

//更多功能
@property (strong, nonatomic) NSArray *multiMediaItems;

//显示消息的tableview
@property (weak, nonatomic, readonly) UITableView *chatTableView;

#warning 其他控件：输入工具条；更多功能视图；
//输入工具条
@property (weak, nonatomic, readonly) ZJMessageInputView *messageInputView;

//多媒体展示视图
@property (weak, nonatomic, readonly) ZJMultiMediaView *multiMediaView;


//是否在加载以往的旧消息
@property (assign, nonatomic) BOOL isLoadingMoreMessages;

//能否发送语音
@property (assign, nonatomic) BOOL canSendAudio;

//能否发送视频
@property (assign, nonatomic) BOOL canSendVideo;

//能否发送图片
@property (assign, nonatomic) BOOL canSendPhoto;

//能否发送表情
@property (assign, nonatomic) BOOL canSendFace;

//用户是否在滚动屏幕
@property (assign, nonatomic) BOOL isUserScrolling;


//添加一条信息
- (void)addMessage:(ZJMessage *)object;

//删除一条信息
- (void)removeMessageAtIndexPath:(NSIndexPath *)indexPath;

//在头部插入旧消息
- (void)insertOldMessages:(NSArray *)oldMessages;

//chatTableView 滚动到底部
- (void)scrollToBottomWitnAnimation:(BOOL)hasAnimation;

//如果键盘或者多媒体正在展示，输入视图回到底部
- (void)downMessageInputView;

@end
