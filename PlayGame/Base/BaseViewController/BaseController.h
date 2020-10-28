//
//  BaseController.h
//  CNUKwallet
//
//  Created by 黄焕林 on 2018/9/6.
//  Copyright © 2018年 黄焕林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseController : UIViewController

//navagationbar是否隐藏 默认为不隐藏navagationbar
@property (nonatomic,assign)BOOL navagationBarHiden;
//导航栏字体颜色
@property (nonatomic, strong)UIColor *navagationBarTextColor;
/**
 *  返回
 */
- (void)goBack;
- (void)push:(UIViewController *)viewController;
- (void)pop;
- (void)popToRoot;


@end
