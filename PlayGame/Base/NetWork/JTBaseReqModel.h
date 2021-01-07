//
//  JTBaseReqModel.h
//  UKEX
//
//  Created by jitong on 2018/7/19.
//  Copyright © 2018年 funky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTBaseReqModel : NSObject

// 提示消息
@property (nonatomic, strong) NSString  *msg;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) NSError   *error;
@property (nonatomic, strong) id        data;

@end
