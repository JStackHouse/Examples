//
//  ZJChatTableViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/12.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJChatTableViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "ZJMediaDisplayViewController.h"
#import "AFHttpUtil.h"


@interface ZJChatTableViewController ()

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIActivityIndicatorView *loadMoreActivityIndicatorView;

//显示消息的tableview
@property (weak, nonatomic, readwrite) UITableView *chatTableView;
//输入工具条
@property (weak, nonatomic, readwrite) ZJMessageInputView *messageInputView;
//多媒体展示视图
@property (weak, nonatomic, readwrite) ZJMultiMediaView *multiMediaView;


//操作类型
@property (assign, nonatomic) ZJInputViewType inputType;


//音频管理类
//@property (strong, nonatomic)

//配置参数
- (void)setupParas;
//初始化控件
- (void)initializeControllers;

//计算Cell的高度
- (CGFloat)calculateCellHeightWithMessage:(id <ZJMessageModel>)message atIndexPath:(NSIndexPath *)indexPath;

//发送文本消息

@end

@implementation ZJChatTableViewController


#pragma mark - Properties

- (void)initMessages
{
    if (!_messages)
    {
        _messages = [[NSMutableArray alloc]initWithCapacity:0];
    }
//    return _messages;
}

const CGFloat headViewHeight = 44.0f;
- (UIView *)headerView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), headViewHeight)];
        _headerView.backgroundColor = self.chatTableView.backgroundColor;
        [_headerView addSubview:self.loadMoreActivityIndicatorView];
    }
    return _headerView;
}

- (UIActivityIndicatorView *)loadMoreActivityIndicatorView
{
    if (!_loadMoreActivityIndicatorView)
    {
        _loadMoreActivityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadMoreActivityIndicatorView.center = _headerView.center;
        _loadMoreActivityIndicatorView.color = [UIColor blackColor];
        [_loadMoreActivityIndicatorView startAnimating];
    }
    return _loadMoreActivityIndicatorView;
}

- (void)setIsLoadingMoreMessages:(BOOL)isLoadingMoreMessages
{
    _isLoadingMoreMessages = isLoadingMoreMessages;
    if (_isLoadingMoreMessages)
        [self.loadMoreActivityIndicatorView startAnimating];
    else
        [self.loadMoreActivityIndicatorView stopAnimating];
}

#pragma mark - Life cycle
- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //先初始化参数
    [self setupParas];
}

- (void)viewWillAppear:(BOOL)animated
{
    //后初始化控件
    [self initializeControllers];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
}




const CGFloat BarViewHeight = 64.0f;
const CGFloat InputViewHeight = 44.0f;
const CGFloat MultiMediaViewHeight = 216.0f;

- (void)initializeControllers
{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    //tableView
    if (!_chatTableView)
    {
        CGRect frame = ccr(0, 64, getW(self.view.bounds), getH(self.view.bounds) - InputViewHeight - BarViewHeight);
        UITableView *tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = ChatTableViewSeparatorStyle;
        tableView.tableHeaderView = self.headerView;
        tableView.contentOffset = ccp(0, getH(self.headerView.frame));
        self.view.backgroundColor = [UIColor whiteColor];
        tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tableView];
        _chatTableView = tableView;
        [self scrollToBottomWitnAnimation:NO];
    }
    
    //inputView
    if (!_messageInputView)
    {
        CGRect inputViewFrame = ccr(0.0f, getH(self.view.frame) - InputViewHeight, getW(self.view.frame), InputViewHeight);
        ZJMessageInputView *inputView = [[ZJMessageInputView alloc]initWithFrame:inputViewFrame];
        inputView.canSendAudio = self.canSendAudio;
        inputView.canSendPhoto = self.canSendPhoto;
        inputView.canSendFace = self.canSendFace;
        inputView.canSendVideo = self.canSendVideo;
        inputView.delegate = self;
        
        [self.view addSubview:inputView];
        [self.view bringSubviewToFront:inputView];
        _messageInputView = inputView;
    }
    
    //更多功能视图
    if (!_multiMediaView)
    {
        ZJMultiMediaView *multiMediaView = [[ZJMultiMediaView alloc]initWithFrame:ccr(0, getH(self.view.bounds), getW(self.view.bounds), MultiMediaViewHeight)];
        multiMediaView.delegate = self;
        multiMediaView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
        multiMediaView.alpha = 0.0f;
        multiMediaView.multiMediaItems = self.multiMediaItems;
        [self.view addSubview:multiMediaView];
        _multiMediaView = multiMediaView;
    }
}

//配置参数
- (void)setupParas
{
    _canSendAudio = YES;
    _canSendPhoto = YES;
    _canSendVideo = YES;
    _canSendFace = YES;
    _isUserScrolling = NO;
    
    self.delegate = self;
    self.dataSource = self;
    
    [self initMessages];
    
    //键盘的出现和隐藏监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Keyboard show hide
- (void)keyboardWillShow:(NSNotification *)notification
{
    //键盘的frame
    CGRect keyboardRect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    //键盘出现的动画效果
    UIViewAnimationCurve curve = [[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    //键盘出现的时长
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if (_inputType == ZJInputViewTypeText) {
        [UIView animateWithDuration:duration
                              delay:0.0f
                            options:[self animationOptionsForCurve:curve]
                         animations:^{
                             CGFloat keyboardY = [self.view convertRect:keyboardRect fromView:nil].origin.y;
                             CGRect inputViewFrame = self.messageInputView.frame;
                             CGFloat inputViewFrameY = keyboardY - getH(inputViewFrame);
                             
                             
                             self.messageInputView.frame = ccr(inputViewFrame.origin.x, inputViewFrameY, getW(inputViewFrame), getH(inputViewFrame));
                             
                             //multiMediaView的移动,确保multiMediaView在messageInputView的下方
                             if (CGRectGetMaxY(self.messageInputView.frame) == CGRectGetMaxY(self.view.bounds))
                             {
                                 self.multiMediaView.frame = ccr(0, CGRectGetMaxY(self.messageInputView.frame), getW(self.messageInputView.frame), getH(self.multiMediaView.frame));
                             }
                             
                             //tableview的内容偏移
                             [self configureTableViewInsetsWithBottomValue:(getH(self.chatTableView.frame) - inputViewFrameY) + BarViewHeight];
                             //tableview滚动到底部
                             [self scrollToBottomWitnAnimation:YES];
                         }
                         completion:nil];
    }
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    
}

//动画类的转换
- (UIViewAnimationOptions)animationOptionsForCurve:(UIViewAnimationCurve)curve {
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
            
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
            
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
            
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
            
        default:
            return kNilOptions;
    }
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <ZJMessageModel> message = [self.messages objectAtIndex:indexPath.row];
    
    BOOL showMessageTime = YES;
    if ([self.delegate respondsToSelector:@selector(wouldShowMessageTimeForRowAtIndexPath:)])
    {
        showMessageTime = [self.delegate wouldShowMessageTimeForRowAtIndexPath:indexPath];
    }
    
    static NSString *cellIdentifier = @"ZJChatTableViewCell";
    ZJChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (nil == cell)
    {
        cell = [[ZJChatTableViewCell alloc]initWithMessage:message showMessageTime:showMessageTime reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    
    cell.indexPath = indexPath;
    [cell configureCellWithMessage:message showMessageTime:showMessageTime];
    if ([self.delegate respondsToSelector:@selector(configureCell:atIndexPath:)])
    {
        [self.delegate configureCell:cell atIndexPath:indexPath];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (self.inputType) {
        case ZJInputViewTypeText:
        {
            [_messageInputView.messageTextView resignFirstResponder];
        }
            break;
        case ZJInputViewTypeMediaMenu:
        {
            [self showMultiMediaView:NO];
            [self configureTableViewInsetsWithBottomValue:0];
            self.inputType = ZJInputViewTypeNone;
        }
            break;
        case ZJInputViewTypeAudio:
        {
            
        }
            break;
        default:
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id <ZJMessageModel> message = [self.messages objectAtIndex:indexPath.row];
    CGFloat height = [self calculateCellHeightWithMessage:message atIndexPath:indexPath];
    return height;
}

#pragma Private funs
//计算Cell的高度
- (CGFloat)calculateCellHeightWithMessage:(id <ZJMessageModel>)message atIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    BOOL showMessageTime = YES;
    if ([self.delegate respondsToSelector:@selector(wouldShowMessageTimeForRowAtIndexPath:)]) {
        showMessageTime = [self.delegate wouldShowMessageTimeForRowAtIndexPath:indexPath];
    }
    cellHeight = [ZJChatTableViewCell calculateCellHeightWithMessage:message showMessageTime:showMessageTime];
    
    return cellHeight;
}

#pragma mark - chatTableView action : 添加、删除
- (void)changeDataSourceQueue:(void (^)())queue
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), queue);
}

- (void)changeTableViewMainQueue:(void (^)())queue
{
    dispatch_async(dispatch_get_main_queue(), queue);
}


//添加一条信息
- (void)addMessage:(id <ZJMessageModel>)object
{
    [self changeDataSourceQueue:^{
        NSMutableArray *tempMessages = [NSMutableArray arrayWithArray:self.messages];
//        ZJMessage *xxmessage = object;
//        xxmessage.messageSendStateType = ZJMessageSendStateSuccess;
       [tempMessages addObject:object];
        
        NSIndexPath *addIndexPath = [NSIndexPath indexPathForRow:(tempMessages.count - 1) inSection:0];
        NSArray *addIndexPaths = @[addIndexPath];
        
        typeof(self) __weak weakSelf = self;
        [self changeTableViewMainQueue:^{
            weakSelf.messages = tempMessages;
            [weakSelf.chatTableView insertRowsAtIndexPaths:addIndexPaths withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf scrollToBottomWitnAnimation:YES];

        
#warning 网络交互、存进本地数据库等
            [self changeDataSourceQueue:^{
                sleep(1.5f);
                [AFHttpUtil getRequestWithActionName:@"getAccessToken"
                                                para:@{@"Appid": @"iosapp", @"Secret": @"123456789"}
                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                 //NSLog(@"responseObject is %@",responseObject);
                                                 NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                                                 //NSLog(@"Get返回结果 %@",result);
                                                 int retval = [result[@"retval"]intValue];
                                                 if (1 == retval)
                                                     ((ZJMessage *)object).messageSendStateType = ZJMessageSendStateSuccess;
                                                 else
                                                     ((ZJMessage *)object).messageSendStateType = ZJMessageSendStateFail;
                                                 
                                                 NSInteger index = [weakSelf.messages indexOfObject:object];
                                                 NSArray *indexs = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil];
                                                 [weakSelf.chatTableView reloadRowsAtIndexPaths:indexs withRowAnimation:UITableViewRowAnimationNone];
                                                 
                                             }
                                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 //NSLog(@"Get错误结果 %@",error.description);
                                                 ((ZJMessage *)object).messageSendStateType = ZJMessageSendStateFail;
                                                 NSInteger index = [weakSelf.messages indexOfObject:object];
                                                 NSArray *indexs = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:index inSection:0], nil];
                                                 [weakSelf.chatTableView reloadRowsAtIndexPaths:indexs withRowAnimation:UITableViewRowAnimationNone];
                                                 
                                             }];
            }];
        }];

    }];
}


static CGPoint contentOffSet = {0, 0};
//在头部插入旧消息
- (void)insertOldMessages:(NSArray *)oldMessages
{
    __weak typeof(self) weakSelf = self;
    [self changeDataSourceQueue:^{
        NSMutableArray *tempMessages = [[NSMutableArray alloc]initWithArray:oldMessages];
        [tempMessages addObjectsFromArray:self.messages];
        
        contentOffSet = weakSelf.chatTableView.contentOffset;
        NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:oldMessages.count];
        [oldMessages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:0];
            [indexPaths addObject:indexPath];
            
            contentOffSet.y += [weakSelf calculateCellHeightWithMessage:[oldMessages objectAtIndex:idx] atIndexPath:indexPath];
        }];
        
        [weakSelf changeTableViewMainQueue:^{
            [UIView setAnimationsEnabled:NO];
            [weakSelf.chatTableView beginUpdates];
            
            weakSelf.messages = tempMessages;
            [weakSelf.chatTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
            [weakSelf.chatTableView setContentOffset:contentOffSet];
            [weakSelf.chatTableView endUpdates];
            [UIView setAnimationsEnabled:YES];
        }];
    }];
}



#pragma mark - chatTableView scroll : 滚动相关
//chatTableView 滚动到底部
- (void)scrollToBottomWitnAnimation:(BOOL)hasAnimation
{
    if (![self canAutoScroll])
    {
        return;
    }
    
    NSInteger rows = [self.chatTableView numberOfRowsInSection:0];
    if (rows > 0)
    {
        [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(rows-1) inSection:0]
                                  atScrollPosition:UITableViewScrollPositionBottom
                                          animated:hasAnimation];
    }
}

//chatTableView 能否自动滚动
- (BOOL)canAutoScroll
{
    if (_isUserScrolling)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(wouldPreventUserScrolling)] && ![self wouldPreventUserScrolling])
        {
            return NO;
        }
        return YES;
    }
    return YES;
}

//设置tableview的内容偏移
- (void)configureTableViewInsetsWithBottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, bottom, 0);
    _chatTableView.contentInset = insets;
    _chatTableView.scrollIndicatorInsets = insets;
}


//生成tableview的内容偏移对象
- (UIEdgeInsets)tableViewInsetsWithBottomValue:(CGFloat)bottom
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, bottom, 0);
    return insets;
}

#pragma mark - UIScrollViewDelegate
static BOOL firstTime = YES;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //第一次进来不加载就数据
    if (firstTime)
    {
        firstTime = !firstTime;
        return;
    }
    if (!self.delegate || ![self.delegate respondsToSelector:@selector(wouldLoadMoreMessagesWhenScrollToTop)])
        return;
    if (![self.delegate wouldLoadMoreMessagesWhenScrollToTop])
        return;
    
    if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y <= headViewHeight)
    {
        if (!self.isLoadingMoreMessages)
        {
            if ([self.delegate respondsToSelector:@selector(loadMoreMessagesWhenScrollToTop)])
            {
                [self.delegate loadMoreMessagesWhenScrollToTop];
            }
        }
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _isUserScrolling = YES;
    [self downMessageInputView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _isUserScrolling = NO;
}

#pragma mark - ZJMessageInputViewDelegate
- (void)inputTextViewWillBeginEditing
{
    self.inputType = ZJInputViewTypeText;
}

//发送文本
- (void)didSendTextAction:(NSString *)text
{
    ZJMessage *textMessage = [[ZJMessage alloc]initWithText:text sender:nil time:[ZJCommonUtil currentDateString]];
    textMessage.messageReceiveSendType = ZJMessageTypeSend;
    textMessage.messageSendStateType = ZJMessageSendStateSending;
    textMessage.avatorUrl = @"chat_self@2x";
    
    [self addMessage:textMessage];
    _messageInputView.messageTextView.text = @"";
}

//发送语音
- (void)didSendAudioAction:(NSString *)fileName withDuraion:(NSString *)duration
{
    self.inputType = ZJInputViewTypeAudio;
    
    NSString *localPath = [[ZJAudioPlayer sharedAudioPlayer] audioFilePathFromfileName:fileName withType:@"wav"];
    
    ZJMessage *audioMessage = [[ZJMessage alloc]initWithAudioPath:nil localPath:localPath duration:duration sender:nil time:[ZJCommonUtil currentDateString]];
    audioMessage.messageReceiveSendType = ZJMessageTypeSend;
    audioMessage.messageSendStateType = ZJMessageSendStateSending;
    audioMessage.avatorUrl = @"chat_self@2x";
    
    [self addMessage:audioMessage];
}


//点击多媒体按钮
- (void)didSelectedMultiMediaAction
{
    self.inputType = ZJInputViewTypeMediaMenu;
    [self showMultiMediaView:YES];
    
}
//多媒体展现与否
- (void)showMultiMediaView:(BOOL)show
{
    [self.messageInputView.messageTextView resignFirstResponder];
    [UIView animateWithDuration:0.2f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         __block CGRect inputViewFrame = self.messageInputView.frame;
                         __block CGRect multiMediaFrame;
                         
                         void (^multiMediaViewAnimation)(BOOL show) = ^(BOOL show)
                         {
                             multiMediaFrame = self.multiMediaView.frame;
                             multiMediaFrame.origin.y = (show ? getH(self.view.bounds) - getH(multiMediaFrame) : getH(self.view.bounds));
                             self.multiMediaView.alpha = show;
                             self.multiMediaView.frame = multiMediaFrame;
                         };
                         
                         
                         void (^messageInputViewAnimation)(BOOL show) = ^(BOOL show)
                         {
                             //inputViewFrame.origin.y = (show ? (CGRectGetMinY(multiMediaFrame) - CGRectGetHeight(inputViewFrame)): (CGRectGetHeight(self.view.bounds) - CGRectGetHeight(inputViewFrame)));
                             inputViewFrame.origin.y = CGRectGetMinY(multiMediaFrame) - getH(inputViewFrame);
                             self.messageInputView.frame = inputViewFrame;
                         };
                         
                         
                         if (show)
                         {
                             switch (self.inputType) {
                                 case ZJInputViewTypeMediaMenu:
                                     multiMediaViewAnimation(show);
                                     break;
                                 case ZJInputViewTypeFace:
                                     
                                     break;
                                 default:
                                     break;
                             }
                         }
                         else
                         {
                             switch (self.inputType) {
                                 case ZJInputViewTypeMediaMenu:
                                     multiMediaViewAnimation(show);
                                     break;
                                 case ZJInputViewTypeFace:
                                     
                                     break;
                                 default:
                                     break;
                             }
                         }
                         
                         messageInputViewAnimation(!show);
                         [self configureTableViewInsetsWithBottomValue:(getH(self.view.frame) - CGRectGetMinY(self.messageInputView.frame) - 44)];
                         [self scrollToBottomWitnAnimation:NO];
                     }
                     completion:^(BOOL finished) {
        
                     }
     ];
}

//多媒体是否正在展示
- (BOOL)isShowingMultiMediaView
{
    BOOL isShowing = YES;
    if (CGRectGetMaxY(self.messageInputView.frame) == getH(self.view.bounds))
    {
        isShowing = NO;
    }
    NSLog(@"%@展示多媒体工具栏",isShowing ? @"正在" : @"不在");
    return isShowing;
}


//如果键盘或者多媒体正在展示，输入视图回到底部
- (void)downMessageInputView
{
    if ([_messageInputView.messageTextView isFirstResponder])
    {
        [_messageInputView.messageTextView resignFirstResponder];
    }
    else if ([self isShowingMultiMediaView])
    {
        [self showMultiMediaView:NO];
    }
}

#pragma mark - ZJChatTableViewCellDelegate
//单击气泡的回调
- (void)didTapBubbleWithMessage:(id <ZJMessageModel>)message withAudioImageView:(UIImageView *)imageView
{
    NSString *path = message.audioLocalPath;
    if (!path || NSOrderedSame == [path compare:@""])
        return;
    ZJAudioPlayer *player = [ZJAudioPlayer sharedAudioPlayer];
    [player setAnimationImageView:imageView];
    if ([player isPlaying])
    {
        [player pausePlaying];
    }
    else
    {
        [player playAudioFileWithPath:path];
    }
}
//长按气泡的回调
- (void)didLongPressBubbleWithMessage:(id <ZJMessageModel>)message
{
    
}

//单击图片的回调：拍照和视频
- (void)didTapImageViewWithMessage:(id <ZJMessageModel>)message
{
    switch (message.messageMediaType) {
//        case ZJMessageMediaTypePhoto:
//        {
//            
//        }
//            break;
        case ZJMessageMediaTypePhoto:
        case ZJMessageMediaTypeVideo:
        {
            
            ZJMediaDisplayViewController *mediaDisplayViewController = [[ZJMediaDisplayViewController alloc]initWithMessage:message];
            [self.navigationController pushViewController:mediaDisplayViewController animated:YES];
            
//            NSString *path = [[NSBundle mainBundle]pathForResource:@"tempVideo" ofType:@"mp4"];
//            MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL fileURLWithPath:path]];
//            moviePlayer.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//            MPMoviePlayerController *player = [moviePlayer moviePlayer];
//            player.controlStyle = MPMovieControlStyleEmbedded;
//            player.scalingMode = MPMovieScalingModeAspectFit;
//            [self presentMoviePlayerViewControllerAnimated:moviePlayer];
//            [player play];
            
            
//            MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc]initWithContentURL:[NSURL fileURLWithPath:path]];
////            MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc]init];
//            moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
////            moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
//            moviePlayer.view.frame = self.view.frame;
//            [self.view addSubview:moviePlayer.view];
////            [[[UIApplication sharedApplication]keyWindow]addSubview:moviePlayer.view];
//            [moviePlayer play];
        }
            break;
        default:
            break;
    }
}

@end
