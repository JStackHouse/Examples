////
////  AFHttpUtil.m
////  ZJTableView
////
////  Created by zhangjie on 14/12/5.
////  Copyright (c) 2014年 zhangjie. All rights reserved.
////
//
//#import "AFHttpUtil.h"
//
//@implementation AFHttpUtil
//
//
///**
// * 一般POST接口
// *
// * @param actionName    方法名
// * @param para          参数
// * @param successBlock  成功回调
// * @param failureBlock  失败回调
// */
//+ (void)postRequestWithActionName:(NSString *)actionName
//                             para:(NSDictionary *)para
//                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
//                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
//{
////方案一：系统post
////    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
////    NSDictionary *parameters = nil;//@{@"foo": @"bar"};
////    [manager POST:BASE_URL parameters:parameters success:successBlock failure:failureBlock];
//    
//    
////方案二：自定义post
//    NSMutableString *paramString = [[NSMutableString alloc]initWithFormat:@"actionName=%@",actionName];
//    for (NSString *key in para.allKeys)
//    {
//        NSString *value = para[key];
//        NSString *encodedValue = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
//                                                                                    (CFStringRef)value, nil,
//                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
//        [paramString appendFormat:@"&%@=%@",key,encodedValue];
//    }
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:TIME_OUT];
//    request.HTTPMethod = @"POST";
//    //创建请求体
//    NSString *charset = (NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
//    NSString *contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@",charset];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    NSMutableData *postBody = [NSMutableData data];
//    [postBody appendData:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setHTTPBody:postBody];
//    //NSLog(@"POST request = %@",request);
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:successBlock failure:failureBlock];
//    //启动操作
//    [operation start];
//}
//
///**
// * 一般GET接口
// *
// * @param actionName    方法名
// * @param para          参数
// * @param successBlock  成功回调
// * @param failureBlock  失败回调
// */
//+ (void)getRequestWithActionName:(NSString *)actionName
//                            para:(NSDictionary *)para
//                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
//                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
//{
////方案一：系统post
////    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject: @"text/html"];
////    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
////    manager.requestSerializer = [AFJSONRequestSerializer serializer];
////    manager.responseSerializer = [AFJSONResponseSerializer serializer];
////    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
////    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
////    [manager GET:BASE_URL parameters:para success:successBlock failure:failureBlock];
//    
////方案二：自定义get
//    NSMutableString *requestUrl = [NSMutableString stringWithString:BASE_URL];
//    if (actionName && NSOrderedSame != [actionName compare:@""])
//    {
//        [requestUrl appendFormat:@"?actionName=%@",actionName];
//    }
//    if (para)
//    {
//        for (NSString *key in para.allKeys)
//        {
//            [requestUrl appendFormat:@"&%@=%@",key,para[key]];
//        }
//    }
//    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:requestUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:TIME_OUT];
//    request.HTTPMethod = @"GET";
//    //NSLog(@"GET request = %@",request);
//    
//    //创建网络请求操作
//    AFHTTPRequestOperation *httpOperation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    //设置操作的成功失败block
//    [httpOperation setCompletionBlockWithSuccess:successBlock failure:failureBlock];
//    //启动操作
//    [httpOperation start];
//}
//
//
///**
// * 单个文件上传POST
// *
// * @param actionName    方法名
// * @param para          参数
// * @param fileData      文件数据
// * @param successBlock  成功回调
// * @param failureBlock  失败回调
// */
//+ (void)postFileRequestWithActionName:(NSString *)actionName
//                                 para:(NSDictionary *)para
//                             fileData:(NSDictionary *)fileDataDic
//                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
//                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
//{
//    //方案一
////    NSString *POST_BOUNDS = @"0xKhTmLbOuNdArY";
////    NSMutableString *bodyContent = [NSMutableString string];
////    for(NSString *key in para.allKeys)
////    {
////        id value = [para objectForKey:key];
////        [bodyContent appendFormat:@"--%@\r\n",POST_BOUNDS];
////        [bodyContent appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
////        [bodyContent appendFormat:@"%@\r\n",value];
////    }
////    //
////    //添加分界线，换行
////    [bodyContent appendFormat:@"--%@\r\n",POST_BOUNDS];
////    //声明pic字段，文件名为boris.png
////    [bodyContent appendFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"test.png\"\r\n"];
////    //声明上传文件的格式
////    [bodyContent appendFormat:@"Content-Type: image/png\r\n\r\n"];
////    //声明myRequestData，用来放入http body
////    NSMutableData *myRequestData=[NSMutableData data];
////    //将body字符串转化为UTF8格式的二进制
////    [myRequestData appendData:[bodyContent dataUsingEncoding:NSUTF8StringEncoding]];
////    //将image的data加入
////    [myRequestData appendData:fileData];
////    //加入结束符
////    //
////    [bodyContent appendFormat:@"--%@--\r\n",POST_BOUNDS];
////    NSData *bodyData=[bodyContent dataUsingEncoding:NSUTF8StringEncoding];
////    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BASE_URL] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
////    [request addValue:[NSString stringWithFormat:@"multipart/form-data;boundary=%@",POST_BOUNDS] forHTTPHeaderField:@"Content-Type"];
////    [request addValue: [NSString stringWithFormat:@"%zd",bodyData.length] forHTTPHeaderField:@"Content-Length"];
////    [request setHTTPMethod:@"POST"];
////    [request setHTTPBody:bodyData];
////    NSLog(@"请求的长度%@",[NSString stringWithFormat:@"%zd",bodyData.length]);
////    NSError *error=nil;
////    NSURLResponse *response=nil;
////    NSLog(@"输出Bdoy中的内容>>\n%@",[[NSString alloc]initWithData:bodyData encoding:NSUTF8StringEncoding]);
////    
////    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
////    [operation setCompletionBlockWithSuccess:successBlock failure:failureBlock];
////    //启动操作
////    [operation start];
////
////    return;
//    
//    
//    //方案二
//    //create the URL POST Request to tumblr
//    NSString *type = fileDataDic[AFFileType];
//    NSData *data = fileDataDic[AFFileData];
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:TIME_OUT];
//    [request setHTTPMethod:@"POST"];
//    
//    //Add the header info
////    NSString *stringBoundary = @"0xKhTmLbOuNdArY";
////    NSString *stringBoundary = @"--------------------56423498738365";
////    NSString *stringBoundary = [NSString stringWithString:@"0xKhTmLbOuNdArY"];
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",AFboundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    //create the body
//    NSMutableData *postBody = [NSMutableData data];
//    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",AFboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    //add key values from the NSDictionary object
//    NSEnumerator *keys = [para keyEnumerator];
//    int i;
//    for (i = 0; i < [para count]; i++) {
//        NSString *tempKey = [keys nextObject];
//        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",tempKey] dataUsingEncoding:NSUTF8StringEncoding]];
//        [postBody appendData:[[NSString stringWithFormat:@"%@",[para objectForKey:tempKey]] dataUsingEncoding:NSUTF8StringEncoding]];
//        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",AFboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    //add data field and file data
//    //[postBody appendData:[@"Content-Disposition: form-data; name=\"data\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file0\";filename=\"%@\"\r\n",type] dataUsingEncoding:NSUTF8StringEncoding]];
//    [postBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [postBody appendData:[NSData dataWithData:data]];
//    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",AFboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    //NSLog(@"输出Bdoy中的内容>>\n%@",[[NSString alloc]initWithData:postBody encoding:NSUTF8StringEncoding]);
//    //add the body to the post
//    [request setHTTPBody:postBody];
//    //NSLog(@"file POST request = %@",request);
//
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:successBlock failure:failureBlock];
//    //启动操作
//    [operation start];
//    
//    
//    
//    //方案三
////    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
////    // AFHTTPResponseSerializer就是正常的HTTP请求响应结果:NSData
////    // 当请求的返回数据不是JSON,XML,PList,UIImage之外,使用AFHTTPResponseSerializer
////    // 例如返回一个html,text...
////    //
////    // 实际上就是AFN没有对响应数据做任何处理的情况
////    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
////    
////    // formData是遵守了AFMultipartFormData的对象
////    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:para];
////    [dic setObject:actionName forKey:@"actionName"];
////    [manager POST:BASE_URL parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
////        
////        // 将本地的文件上传至服务器
////        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:@"chat_placeholder@2x.png" withExtension:nil];
////        
////        [formData appendPartWithFileURL:fileURL name:@"uploadFile" error:NULL];
////    }
////          success:successBlock
////          failure:failureBlock];
//    
//    
//    //方案四
////    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]multipartFormRequestWithMethod:<#(NSString *)#> URLString:<#(NSString *)#> parameters:<#(NSDictionary *)#> constructingBodyWithBlock:<#^(id<AFMultipartFormData> formData)block#> error:<#(NSError *__autoreleasing *)#>
//    
//    
////    NSError *error;
////    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:para];
////    [dic setObject:actionName forKey:@"actionName"];
////    NSString *url = [NSString stringWithFormat:@"%@?actionName=%@",BASE_URL,actionName];
////    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:para constructingBodyWithBlock:^(id formData) {
////        
////        [formData appendPartWithFileData:fileData name:@"chat_placeholder" fileName:@"chat_placeholder.jpg" mimeType:@"image/png"];
////        //[formData appendPartWithFileData:imageDataArra[1] name:@"file2" fileName:@"file2.jpg" mimeType:@"image/jpeg"];
////    }
////                                    error:&error
////];
////    if (error)
////    {
////        NSLog(@"error is %@",error.description);
////    }
////    
////    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//////    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite) {
//////        
//////    }];
////    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
////        NSLog(@"sucess: %@",responseObject);
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        NSLog(@"fail :%@",error);
////    }]; 
////    
////    [operation start];
//    
//}
//
//
//
///**
// * 多个图片上传POST
// *
// * @param actionName    方法名
// * @param para          参数
// * @param fileData      文件数据
// * @param successBlock  成功回调
// * @param failureBlock  失败回调
// */
//+ (void)postMultiFileRequestWithActionName:(NSString *)actionName
//                                      para:(NSDictionary *)para
//                                  fileDatas:(NSArray *)fileDatas
//                                   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
//                                   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
//{
//    //create the URL POST Request to tumblr
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:BASE_URL]cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:TIME_OUT];
//    [request setHTTPMethod:@"POST"];
//    
//    //Add the header info
//    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",AFboundary];
//    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
//    //create the body
//    NSMutableData *postBody = [NSMutableData data];
////    [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",AFboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
//    //add key values from the NSDictionary object
//    NSEnumerator *keys = [para keyEnumerator];
//    int i;
//    for (i = 0; i < [para count]; i++) {
//        NSString *tempKey = [keys nextObject];
//        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",AFboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//
//        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",tempKey] dataUsingEncoding:NSUTF8StringEncoding]];
//        [postBody appendData:[[NSString stringWithFormat:@"%@\r\n",[para objectForKey:tempKey]] dataUsingEncoding:NSUTF8StringEncoding]];
////        [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",AFboundary] dataUsingEncoding:NSUTF8StringEncoding]];
////        [postBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//    }
//    
//    //add data field and file data
//    for (id obj in fileDatas)
//    {
//        if ([obj isKindOfClass:[NSDictionary class]])
//        {
//            NSDictionary *fileDic = [NSDictionary dictionaryWithDictionary:obj];
//            NSString *fileKey = fileDic[AFFileKey];
//            NSString *fileType = fileDic[AFFileType];
//            NSData *fileData = fileDic[AFFileData];
//            
//            [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n",AFboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"test.%@\"\r\n",fileKey,fileType] dataUsingEncoding:NSUTF8StringEncoding]];
//            [postBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//            [postBody appendData:[NSData dataWithData:fileData]];
//            [postBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
//        }
//    }
//    
//    [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n",AFboundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    
////    [postBody appendData:[@"Content-Disposition: form-data; name=\"file\";filename=\"test.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
////    [postBody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
////    [postBody appendData:[NSData dataWithData:fileData]];
////    [postBody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//    //add the body to the post
//    [request setHTTPBody:postBody];
//    //NSLog(@"file POST request = %@",request);
//    //NSLog(@"输出Bdoy中的内容>>\n%@",[[NSString alloc]initWithData:postBody encoding:NSUTF8StringEncoding]);
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:successBlock failure:failureBlock];
//    //启动操作
//    [operation start];
//}
//
//
//
//
//
//
//
//
//
//@end
//
//
//
