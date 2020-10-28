//
//  JTShareData.m
//  UKEX
//
//  Created by jitong on 2018/7/19.
//  Copyright © 2018年 funky. All rights reserved.
//

#import "JTShareData.h"
#import <LocalAuthentication/LocalAuthentication.h>


@implementation JTShareData

+(JTShareData *)shareData
{
    static JTShareData *shareData = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        shareData = [[JTShareData alloc]init];
    });
    return  shareData;
}

- (void)setLoginSucess{
    [kUserDefaults setBool:YES forKey:@"isLogin"];
}


- (BOOL)isLogin {
    if ([kUserDefaults boolForKey:@"isLogin"]) {
        return YES;
    }
    return NO;
}


- (NSString *)getCurrentLanguage {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defs objectForKey:@"AppleLanguages"];
    NSString *preferredLang = [languages objectAtIndex:0];
    if ([preferredLang hasPrefix:@"en"]) {
        return @"en-gb";
    }
    return @"zh-cn";
}


@end
