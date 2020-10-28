//
//  JTShareData.h
//  UKEX
//
//  Created by jitong on 2018/7/19.
//  Copyright © 2018年 funky. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JTShareData : NSObject

@property (nonatomic, strong) UIWindow *window;

+ (JTShareData *)shareData;
- (void)setLoginSucess;
- (BOOL)isLogin;

@end
