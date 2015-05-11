////
////  AFHttpUtil.h
////  ZJTableView
////
////  Created by zhangjie on 14/12/5.
////  Copyright (c) 2014年 zhangjie. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//@interface AFHttpUtil : NSObject
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
//                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;
//
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
//                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;
//
//
///**
// * 单个图片上传POST
// *
// * @param actionName    方法名
// * @param para          参数
// * @param fileData      文件数据
// * @param successBlock  成功回调
// * @param failureBlock  失败回调
// */
//+ (void)postFileRequestWithActionName:(NSString *)actionName
//                             para:(NSDictionary *)para
//                             fileData:(NSDictionary *)fileDataDic
//                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
//                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;
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
//                                 para:(NSDictionary *)para
//                             fileDatas:(NSArray *)fileDatas
//                              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock
//                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;
//
//
//@end
