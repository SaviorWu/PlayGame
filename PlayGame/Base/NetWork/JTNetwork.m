//
//  JTNetwork.m
//  UKEX
//
//  Created by jitong on 2018/7/19.
//  Copyright © 2018年 funky. All rights reserved.
//

#import "JTNetwork.h"

@implementation JTNetwork

+ (JTNetwork *)manager {
    static JTNetwork *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[JTNetwork alloc]init];
    });
    return  sharedManager;
}

-(instancetype)init {
    self=[super init];
    if (self) {
        
    }
    return self;
}

- (void)addHeader:(NSDictionary *)body {
    _manager=[AFHTTPSessionManager manager];
    
    _manager.operationQueue.maxConcurrentOperationCount = 1;
    _manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    _manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    _manager.requestSerializer = [AFJSONRequestSerializer serializer];
    _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    _manager.requestSerializer.timeoutInterval = 30.f;
    [_manager.reachabilityManager startMonitoring];
    
}


//字典转为Json字符串
-(NSString *)dictionaryToJson:(NSDictionary *)dic
{
    if (!dic)
        return @"";
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}


+ (void)requestPostWithParam:(NSDictionary *)param url:(NSString *)url callback:(networkComplateBlock)callback {
    [[JTNetwork manager] addHeader:param];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER_URL,url];
    NSLog(@"url ---  %@",urlString);
    NSLog(@"param = %@",param);
    [[JTNetwork manager].manager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        JTBaseReqModel *model = [JTBaseReqModel mj_objectWithKeyValues:responseObject];
            if (callback) {
                callback(model);
            }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"客户端报错 %@",error);
        JTBaseReqModel *model = [[JTBaseReqModel alloc] init];
        model.sj = error;
        if (callback) {
            callback(model);
        }
    }];
}

+ (void)requestGetWithParam:(NSDictionary *)param url:(NSString *)url callback:(networkComplateBlock)callback {
    [[JTNetwork manager] addHeader:param];
    NSString *urlString = [NSString stringWithFormat:@"%@%@",SERVER_URL,url];
    NSLog(@"url=%@",urlString);
    NSLog(@"param=%@",param);
    [[JTNetwork manager].manager GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        JTBaseReqModel *model = [JTBaseReqModel mj_objectWithKeyValues:responseObject];
        if (callback) {
            callback(model);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        JTBaseReqModel *model = [[JTBaseReqModel alloc] init];
        model.sj = error;
        if (callback) {
            callback (model);
        }
    }];
}


@end
