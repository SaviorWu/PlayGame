//
//  JTUserModel.h
//  UKEX
//
//  Created by jitong on 2018/7/23.
//  Copyright © 2018年 funky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JTUserModel : NSObject

//用户id
@property (nonatomic, strong) NSString  *uid;
//用户token
@property (nonatomic, strong) NSString  *token;
//电话
@property (nonatomic, strong) NSString  *phone;

@end
