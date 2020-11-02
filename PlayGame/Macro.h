//
//  Macro.h
//  CNUKwallet
//
//  Created by 黄焕林 on 2018/9/6.
//  Copyright © 2018年 黄焕林. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define SERVER_URL @"http://app.qun68.com/" // 正式环境


// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//主线程
#define rcd_dispatch_main_async_safe(block)                                                                            \
    if ([NSThread isMainThread]) {                                                                                     \
        block();                                                                                                       \
    } else {                                                                                                           \
        dispatch_async(dispatch_get_main_queue(), block);                                                              \
}


//输出打印
#define UKEXPayLog(s, ...) NSLog((@"[UKEXPayLog]%s [Line %d] " s), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//弱引用
#define JTWeakify(object) __weak __typeof__(object) weak##_##object = object;

//屏幕宽高
#define  SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define MYAPP (AppDelegate *)([UIApplication sharedApplication].delegate)

//UserDefaults
#define kUserDefaults [NSUserDefaults standardUserDefaults]
// 本地化字符串
#define kLocalizedString(r) NSLocalizedStringFromTable(r,@"Loca", nil)


// 系统性参数
#define IS_IPHONEX (SCREEN_WIDTH >= 375.0f && SCREEN_HEIGHT >= 812.0f)
#define RCDExtraBottomHeight (IS_IPHONEX ? 34 : 0)
#define RCDExtraTopHeight (IS_IPHONEX ? 24 : 0)
#define IsIPad [[UIDevice currentDevice].model containsString:@"iPad"]

//颜色
#define UIColorWithRGB(r,g,b)   [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
//主题颜色
#define BASECOLOR  [UIColor hexColor:@"#04A875"]


//
#define ApplicationMarket    @"China"
//#define ApplicationMarket    @"overseas"
// 1 测试 2 正式
#define Environment         @"1"
//#define Environment           @"2"


#endif /* Macro_h */
