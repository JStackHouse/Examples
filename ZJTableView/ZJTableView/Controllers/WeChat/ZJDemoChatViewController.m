//
//  ZJDemoChatViewController.m
//  ZJTableView
//
//  Created by zhangjie on 14/12/12.
//  Copyright (c) 2014年 zhangjie. All rights reserved.
//

#import "ZJDemoChatViewController.h"
#import "ZJAudioPlayer.h"

@implementation ZJDemoChatViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    ZJMessage *messageOne = [[ZJMessage alloc]initWithText:@"1111111111111" sender:@"Jason" time:@"2014-12-16 20:21:30"];
    messageOne.avatorUrl = @"chat_other@2x";
    messageOne.messageReceiveSendType = ZJMessageTypeReceive;
    messageOne.messageSendStateType = ZJMessageSendStateNone;
    
    ZJMessage *messageTwo = [[ZJMessage alloc]initWithText:@"222222222222222222222222222222222222222222" sender:@"Jason" time:@"2014-12-16 20:22:20"];
    messageTwo.avatorUrl = @"chat_self@2x";
    messageTwo.messageReceiveSendType = ZJMessageTypeSend;
    messageTwo.messageSendStateType = ZJMessageSendStateNone;
    
    ZJMessage *messageThree = [[ZJMessage alloc]initWithText:@"《爱运维》安卓端OSS一点通模块" sender:@"Jason" time:@"2014-12-16 20:23:40"];
    messageThree.avatorUrl = @"chat_other@2x";
    messageThree.messageReceiveSendType = ZJMessageTypeReceive;
    messageThree.messageSendStateType = ZJMessageSendStateNone;
    
    ZJMessage *messageFour = [[ZJMessage alloc]initWithText:@"最新修改已经完成，源文件及状态效果图在附件中" sender:@"Jason" time:@"2014-12-16 20:24:00"];
    messageFour.avatorUrl = @"chat_other@2x";
    messageFour.messageReceiveSendType = ZJMessageTypeReceive;
    messageFour.messageSendStateType = ZJMessageSendStateNone;
    
    ZJMessage *messageFive = [[ZJMessage alloc]initWithText:@"OSS一点通最新修改.zip）压缩文件当中。" sender:@"Jason" time:@"2014-12-16 20:25:30"];
    messageFive.avatorUrl = @"chat_other@2x";
    messageFive.messageReceiveSendType = ZJMessageTypeReceive;
    messageFive.messageSendStateType = ZJMessageSendStateNone;

    ZJMessage *messageSix = [[ZJMessage alloc]initWithText:@"3333333333333333333" sender:@"Jason" time:@"2014-12-16 20:22:20"];
    messageSix.avatorUrl = @"chat_self@2x";
    messageSix.messageReceiveSendType = ZJMessageTypeSend;
    messageSix.messageSendStateType = ZJMessageSendStateNone;
    
    self.messages = [NSMutableArray arrayWithArray:@[messageOne,messageTwo,messageThree,messageFour,messageFive,messageSix]];
    
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    //multiMedia
    NSArray *images = [NSArray arrayWithObjects:@"sharemore_pic",@"sharemore_video",@"sharemore_videovoip",@"sharemore_placeholder",@"sharemore_placeholder",@"sharemore_placeholder",@"sharemore_placeholder",@"sharemore_placeholder",@"sharemore_placeholder",@"sharemore_placeholder", nil];
    NSArray *titles = [NSArray arrayWithObjects:@"照片",@"拍摄",@"视频",@"AA",@"BB",@"CC",@"DD",@"EE",@"FF",@"GG", nil];
    NSMutableArray *items = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i < images.count; i ++)
    {
        NSString *image = images[i];
        NSString *title = titles[i];
        ZJMultiMediaItem *item = [[ZJMultiMediaItem alloc]initWithItemImage:image withTitle:title];
        [items addObject:item];
    }
    self.multiMediaItems = items;
}



static int i = 2;
//测试新增
- (void)rightItemClick:(id)sender
{
    NSMutableString *text = [NSMutableString stringWithString:@""];
    for (int k = 0; k < i; k++)
    {
        [text appendFormat:@"%02d",k];
    }
    ZJMessage *message = [[ZJMessage alloc]initWithText:text sender:@"Jason" time:@"2014-12-16 10:10:10"];
    message.avatorUrl = i % 2 == 0 ? @"chat_self@2x" : @"chat_other@2x";
    message.messageReceiveSendType = (i % 2 == 0 ? ZJMessageTypeSend : ZJMessageTypeReceive);
    message.messageSendStateType = ZJMessageSendStateNone;
    [self addMessage:message];
    
    i ++;
}
//测试批量加载旧消息
- (NSMutableArray *)loadMoreOldMessages
{
    ZJMessage *messageOne = [[ZJMessage alloc]initWithText:@"国家主席习近平23日在人民大会堂会见泰国总理巴育。" sender:@"Jason" time:@"2014-12-24 11:30:30"];
    messageOne.avatorUrl = @"chat_other@2x";
    messageOne.messageReceiveSendType = ZJMessageTypeReceive;
    messageOne.messageSendStateType = ZJMessageSendStateNone;

    ZJMessage *messageTwo = [[ZJMessage alloc]initWithAudioPath:@"" localPath:@"" duration:@"20" sender:@"Jason" time:@"2014-12-24 11:40:30"];
    messageTwo.avatorUrl = @"chat_other@2x";
    messageTwo.messageReceiveSendType = ZJMessageTypeReceive;
    messageTwo.messageSendStateType = ZJMessageSendStateNone;
    
    ZJMessage *messageThree = [[ZJMessage alloc]initWithText:@"中国在职公务员数量约为700万，126万个各类事业单位在职人员3000多万。" sender:@"Jason" time:@"2014-12-24 11:50:30"];
    messageThree.avatorUrl = @"chat_self@2x";
    messageThree.messageReceiveSendType = ZJMessageTypeSend;
    messageThree.messageSendStateType = ZJMessageSendStateNone;
    
    NSMutableArray *oldMessagesArray = [NSMutableArray arrayWithCapacity:0];
    [oldMessagesArray addObject:messageOne];
    [oldMessagesArray addObject:messageTwo];
    [oldMessagesArray addObject:messageThree];
    
    return oldMessagesArray;
}


//配置cell的样式或者字体
- (void)configureCell:(ZJChatTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
}

//设置cell上的时间标签显示与否
- (BOOL)wouldShowMessageTimeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
        return YES;
    
    id <ZJMessageModel> preMessage = self.messages[indexPath.row - 1];
    id <ZJMessageModel> nowMessage = self.messages[indexPath.row];
    NSTimeInterval timeInterval = [ZJCommonUtil timeIntervalFromDateString:preMessage.messageTime toDateString:nowMessage.messageTime];
    
    //小于60秒，不重新显示时间标签
    if (fabsf(timeInterval) <= 60)
        return NO;
    return YES;
}

//是否自动加载信息时不干扰用户手动操作
- (BOOL)wouldPreventUserScrolling
{
    return NO;
}

//是否滚动到顶端时自动加载旧信息
- (BOOL)wouldLoadMoreMessagesWhenScrollToTop
{
    return YES;
}

//滚动到顶端时自动加载旧信息处理
- (void)loadMoreMessagesWhenScrollToTop
{
    if (!self.isLoadingMoreMessages)
    {
        self.isLoadingMoreMessages = YES;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *oldMessages = [self loadMoreOldMessages];
        sleep(1);
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf insertOldMessages:oldMessages];
            weakSelf.isLoadingMoreMessages = NO;
        });
    });
}

#pragma mark - ZJMultiMediaViewDelegate
//多媒体具体功能的点击
- (void)didSelecteMediaItem:(ZJMultiMediaItem *)item atIndexPath:(NSInteger)index
{
    NSLog(@"ZJMultiMediaViewDelegate item is %@",item.title);
    switch (index) {
        case 0://照片
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = self;
                
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                
                [self presentViewController:imagePicker animated:YES completion:nil];
                
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"无法获取照片" message:@"目前相册不可用！" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alertView show];
            }
        }
            break;
        case 1://拍照
        {
            //拍照
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = self;
                
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
                imagePicker.showsCameraControls = YES;
                imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
                imagePicker.allowsEditing = YES;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"无法获取照片" message:@"目前相机不可用！" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alertView show];
            }
        }
            break;
        case 2://视频
        {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = self;
                
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                imagePicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
                imagePicker.showsCameraControls = YES;
                imagePicker.mediaTypes = @[(NSString *)kUTTypeMovie];
                imagePicker.videoMaximumDuration = 6.0f;
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"无法获取照片" message:@"目前相机不可用！" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil];
                [alertView show];
            }
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if (NSOrderedSame == [type compare:(NSString *)kUTTypeImage])
    {
        NSLog(@"didFinishPickingMediaWithInfo-拍照");
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //图片处理
//        UIImage* newImage;
        
//        //将照片压缩成 225*225的大小
//        if (originImage.size.width > 225.0 || originImage.size.height > 225.0) {
//            CGSize newSize = CGSizeMake(225.0f, 225.0f);
//            UIGraphicsBeginImageContext(newSize);
//            // Tell the old image to draw in this new context, with the desired
//            // new size
//            [originImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
//            // Get the new image from the context
//            newImage = UIGraphicsGetImageFromCurrentImageContext();
//            // End the context
//            UIGraphicsEndImageContext();
//        }
        
#define PhotoPath           [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Photo"]
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL bExist = [fileManager fileExistsAtPath:PhotoPath isDirectory:&isDir];
        if (bExist == NO || isDir == NO)
        {
            [fileManager createDirectoryAtPath:PhotoPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *filePath = [[PhotoPath stringByAppendingPathComponent:[ZJCommonUtil currentDateString]]stringByAppendingPathExtension:@"jpg"];
        
        BOOL success = [UIImageJPEGRepresentation(originImage,0.25) writeToFile:filePath atomically:NO];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        BOOL success = [data writeToFile:filePath atomically:NO];
        NSLog(@"图片保存%@",success ? @"成功" : @"失败");

        
        ZJMessage *photoMessage = [[ZJMessage alloc]initWithPhoto:nil thumbnailPath:@"" originalPath:@"" sender:@"Jason" time:[ZJCommonUtil currentDateString]];//[[ZJMessage alloc]initWithText:text sender:@"Jason" time:@"2014-12-16 x:x"];
        photoMessage.avatorUrl = @"chat_self@2x";
        photoMessage.thumbnailPhotoPath = filePath;
        photoMessage.messageReceiveSendType = ZJMessageTypeSend;
        photoMessage.messageSendStateType = ZJMessageSendStateSending;
        [self addMessage:photoMessage];
    }
    else if (NSOrderedSame == [type compare:(NSString *)kUTTypeMovie])
    {
        NSLog(@"didFinishPickingMediaWithInfo-视频");
        NSURL *url = [info
                      objectForKeyedSubscript:UIImagePickerControllerMediaURL];
        NSLog(@"视频 URL :%@",url);
        
#define VideoPath           [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"Video"]
        BOOL isDir = NO;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL bExist = [fileManager fileExistsAtPath:VideoPath isDirectory:&isDir];
        if (bExist == NO || isDir == NO)
        {
            [fileManager createDirectoryAtPath:VideoPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *filePath = [[VideoPath stringByAppendingPathComponent:[ZJCommonUtil currentDateString]]stringByAppendingPathExtension:@"MOV"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        BOOL success = [data writeToFile:filePath atomically:NO];
        NSLog(@"视频数据大小：%d,视频保存%@",(int)data.length,success ? @"成功" : @"失败");
        
        ZJMessage *videoMessage = [[ZJMessage alloc]initWithVideoPath:[UIImage imageNamed:@"chat_placeholder"] serverPath:@"" localPath:@"" sender:@"Jason" time:[ZJCommonUtil currentDateString]];
        videoMessage.avatorUrl = @"chat_other@2x";
        videoMessage.videoLocalPath = filePath;
        videoMessage.messageReceiveSendType = ZJMessageTypeSend;
        videoMessage.messageSendStateType = ZJMessageSendStateSending;
        [self addMessage:videoMessage];
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
