//
//  ZJWebViewController.m
//  ZJTableView
//
//  Created by zhangjie on 15/3/20.
//  Copyright (c) 2015年 zhangjie. All rights reserved.
//

#import "ZJWebViewController.h"
#import "XiaoJiInterface.h"
#import "EasyJSWebView.h"
#import "EasyJSWebViewProxyDelegate.h"

enum
{
    GESTURE_STATE_NONE = 0,
    GESTURE_STATE_START = 1,
    GESTURE_STATE_MOVE = 2,
    GESTURE_STATE_END = 4,
    GESTURE_STATE_ACTION = (GESTURE_STATE_START | GESTURE_STATE_END),
};

static NSString* const kTouchJavaScriptString=
@"document.ontouchstart=function(event){\
x=event.targetTouches[0].clientX;\
y=event.targetTouches[0].clientY;\
document.location=\"myweb:touch:start:\"+x+\":\"+y;};\
document.ontouchmove=function(event){\
x=event.targetTouches[0].clientX;\
y=event.targetTouches[0].clientY;\
document.location=\"myweb:touch:move:\"+x+\":\"+y;};\
document.ontouchcancel=function(event){\
document.location=\"myweb:touch:cancel\";};\
document.ontouchend=function(event){\
document.location=\"myweb:touch:end\";};";

@interface ZJWebViewController () <UIWebViewDelegate,UIActionSheetDelegate>
{
    NSTimer *_timer;    // 用于UIWebView保存图片
    int _gesState;      // 用于UIWebView保存图片
    NSString *_imgURL;  // 用于UIWebView保存图片
}

@property (strong, nonatomic) EasyJSWebView *zWebView;

@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

@property (strong, nonatomic) EasyJSWebViewProxyDelegate *delegate;

@end

@implementation ZJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStyleBordered target:self action:@selector(more:)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    
    EasyJSWebView *webView = [[EasyJSWebView alloc]initWithFrame:self.view.bounds];
//    webView.proxyDelegate.parent = self;
    //self.delegate = webView.proxyDelegate;
    webView.delegate = self;
    webView.hidden = NO;
    [self.view addSubview:webView];
    _zWebView = webView;
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"xiaoji" ofType:@"html"];
    
    // webview加载页面
    //NSLog(@"DEBUG: path is %@",path);
    //_webPath = path;//[[NSURL alloc] initFileURLWithPath:path];

    
    
//    _webPath = @"http://www.baidu.com";
    _webPath = @"http://view.inews.qq.com/q/WXN20150320066299061?refer=mobileqq&plg_auth=1";
    //_webPath = @"http://open.wenet980.com/d/";
    
//    _webPath = [[NSBundle mainBundle]pathForResource:@"xxx" ofType:@"html"];
    
    XiaoJiInterface *interface = [[XiaoJiInterface alloc]init];
    [_zWebView addJavascriptInterfaces:interface WithName:@"XiaoJi"];
    
    //[_zWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] 																		 pathForResource:@"xiaoji" ofType:@"html"]isDirectory:NO]]];
    
    [_zWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webPath]]];
    
    
//    [_zWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webPath]]
//                  progress:^(NSUInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
//                      NSLog(@"百分比为 %.2f",bytesWritten * 1.0f / totalBytesWritten);
//                  }
//                   success:^NSString *(NSHTTPURLResponse *response, NSString *HTML) {
//                       NSLog(@"response is %@",response);
//                       NSLog(@"HTML is %@",HTML);
//                       return @"xxx";
//                   }
//                   failure:^(NSError *error) {
//                       NSLog(@"网页请求失败");
//                   }
//     ];
    
//    NSString *js = [NSString stringWithFormat:@"function getUsername(){ return '%@'; }", @"bill"];
//    [_zWebView stringByEvaluatingJavaScriptFromString:js];
//
//    NSString *js1 = [NSString stringWithFormat:JsStr, @"bill"];
//    [_zWebView stringByEvaluatingJavaScriptFromString:js1];
}

#define JsStr @"var test = {}; (function initialize() { test.getUsername = function () { return '%@';};})(); " 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - UIWebViewDelegate
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    NSLog(@"request.mainDocumentURL.relativePath is %@",request.mainDocumentURL.relativePath);
//    if ( [request.mainDocumentURL.relativePath isEqualToString:@"/1"] )
//    {
//        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"成功"
//                                                     message:@"从网页中调用的" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
//        [alert show];
//        return false;
//    }
//
//    return true;
//}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // 处理事件
    NSString *requestString = [[request URL] absoluteString];
    NSArray *components = [requestString componentsSeparatedByString:@"::"];
    if (components != nil && [components count] > 0)
    { NSString *pocotol = [components objectAtIndex:0];
        if ([pocotol isEqualToString:@"test"])
        {
            NSString *commandStr = [components objectAtIndex:1];
            NSArray *commandArray = [commandStr componentsSeparatedByString:@":"];
            if (commandArray != nil && [commandArray count] > 0)
            {
                NSString *command = [commandArray objectAtIndex:0];
                if ([command isEqualToString:@"login"])
                {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"消息" message:@"网页发出了登录请求" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alert show];
                }
            }
            return NO;
        }
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)_request navigationType:(UIWebViewNavigationType)navigationType {
//    NSString *host=[[_request URL].host lowercaseString];
//    if([host hasSuffix:@"itunes.apple.com"])
//    {
//        [[UIApplication sharedApplication] openURL:[_request URL]];
//        return NO;
//    }
//    
//    NSString *requestString = [[_request URL] absoluteString];
//    NSArray *components = [requestString componentsSeparatedByString:@":"];
//    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0]isEqualToString:@"myweb"])
//    {
//        if([(NSString *)[components objectAtIndex:1] isEqualToString:@"touch"])
//        {
//            //NSLog(@"you are touching!");
//            //NSTimeInterval delaytime = Delaytime;
//            if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"start"])
//            {
//                /*
//                 @需延时判断是否响应页面内的js...
//                 */
//                _gesState = GESTURE_STATE_START;
//                //NSLog(@"touch start!");
//                
//                float ptX = [[components objectAtIndex:3]floatValue];
//                float ptY = [[components objectAtIndex:4]floatValue];
//                //NSLog(@"touch point (%f, %f)", ptX, ptY);
//                
//                NSString *js = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).tagName", ptX, ptY];
//                NSString * tagName = [_zWebView stringByEvaluatingJavaScriptFromString:js];
//                _imgURL = nil;
//                if ([tagName isEqualToString:@"IMG"]) {
//                    _imgURL = [NSString stringWithFormat:@"document.elementFromPoint(%f, %f).src", ptX, ptY];
//                }
//                if (_imgURL) {
//                    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleLongTouch) userInfo:nil repeats:NO];
//                }
//            }
//            else if ([(NSString *)[components objectAtIndex:2] isEqualToString:@"move"])
//            {
//                //**如果touch动作是滑动，则取消hanleLongTouch动作**//
//                _gesState = GESTURE_STATE_MOVE;
//                //NSLog(@"you are move");
//            }
//            else if ([(NSString*)[components objectAtIndex:2]isEqualToString:@"end"]) {
//                [_timer invalidate];
//                _timer = nil;
//                _gesState = GESTURE_STATE_END;
//                //NSLog(@"touch end");
//            }
//        }
//        return NO;
//    }
//    return YES;//[super webView:webView shouldStartLoadWithRequest:_request navigationType:navigationType];
//}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.view removeGestureRecognizer:_tapGesture];
    
    
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"title=%@",title);
    self.title = title;
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSLog(@"currentURL=%@",currentURL);
    
    
    [webView stringByEvaluatingJavaScriptFromString:kTouchJavaScriptString];
    //    return [super webViewDidFinishLoad:webView];
    
    //    return;
    
    //    NSString *title_class = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementByClassName('title')"];
    //    NSLog(@"title_class=%@",title_class);
    
    
    
    //NSString *st = [ webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('field_1').value"];
    //    NSString *st = [webView stringByEvaluatingJavaScriptFromString:@"document.myform.input1.value"];
    //    NSLog(@"st =%@",st);
    //    //添加数据
    //    [webView stringByEvaluatingJavaScriptFromString:@"var field = document.getElementById('field_2');""field.value='通过OC代码写入';"];
    //
    //    [webView stringByEvaluatingJavaScriptFromString:@"var field = document.getElementById('field_3');""field.value='test';"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error)
    {
        self.zWebView.hidden = YES;
        if (!_tapGesture)
        {
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reloadWebView:)];
            _tapGesture = tapGesture;
        }
        [self.view addGestureRecognizer:_tapGesture];
    }
}


#pragma mark - func

- (void)nslogUrl:(NSString *)url
{
    NSLog(@"**************url is %@",url);
}

- (void)more:(id)sender
{
    
}


// 功能：如果点击的是图片，并且按住的时间超过1s，执行handleLongTouch函数，处理图片的保存操作。
- (void)handleLongTouch
{
    NSLog(@"%@", _imgURL);
    if (_imgURL && _gesState == GESTURE_STATE_START)
    {
        UIActionSheet* sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存到手机", nil];
        sheet.cancelButtonIndex = sheet.numberOfButtons - 1;
        [sheet showInView:[UIApplication sharedApplication].keyWindow];
    }
}

// 功能：保存图片到手机
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.numberOfButtons - 1 == buttonIndex) {
        return;
    }
    NSString* title = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([title isEqualToString:@"保存到手机"]) {
        if (_imgURL) {
            NSLog(@"imgurl = %@", _imgURL);
        }
        NSString *urlToSave = [_zWebView stringByEvaluatingJavaScriptFromString:_imgURL];
        NSLog(@"image url = %@", urlToSave);
        
        NSData* data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlToSave]];
        UIImage* image = [UIImage imageWithData:data];
        
        //UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
        NSLog(@"UIImageWriteToSavedPhotosAlbum = %@", urlToSave);
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

// 功能：显示对话框
-(void)showAlert:(NSString *)msg
{
    NSLog(@"showAlert = %@", msg);
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:msg
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles: nil];
    [alert show];
}
// 功能：显示图片保存结果
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if (error)
    {
        NSLog(@"Error");
        [self showAlert:@"保存失败..."];
    }
    else
    {
        NSLog(@"OK");
        [self showAlert:@"保存成功！"];
    }
}

- (void)reloadWebView:(UITapGestureRecognizer *)gesture
{
    _zWebView.hidden = NO;
    [_zWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_webPath]]];
}



@end
