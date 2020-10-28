//
//  JTNetwork.h
//  UKEX
//
//  Created by jitong on 2018/7/19.
//  Copyright © 2018年 funky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JTBaseReqModel.h"
#import "AFNetworking.h"

typedef void(^networkComplateBlock)(JTBaseReqModel *model);
typedef void(^networkAotuoBlock)(NSArray *urls);
typedef void(^chechNetworkBlock)(BOOL isCheck,NSString  *time);

@interface JTNetwork : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (JTNetwork *)manager;


/**
 网络请求 Post
 
 @param param 请求参数
 @param url 请求地址
 @param callback 回调信息
 */
+ (void)requestPostWithParam:(NSDictionary *)param url:(NSString *)url callback:(networkComplateBlock)callback;

/**
 网络请求 Get
 
 @param param 请求参数
 @param url 请求地址
 @param callback 回调信息
 */
+ (void)requestGetWithParam:(NSDictionary *)param url:(NSString *)url callback:(networkComplateBlock)callback;


@end
