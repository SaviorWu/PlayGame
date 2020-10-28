//
//  JTBaseController.h
//  CNUKwallet
//
//  Created by 黄焕林 on 2018/9/6.
//  Copyright © 2018年 黄焕林. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTBaseController : UIViewController


@property (nonatomic,assign)BOOL                 navagationBarHiden;//navagationbar是否隐藏 默认为不隐藏navagationbar
//导航栏字体颜色
@property (nonatomic, strong)UIColor            *navagationBarTextColor;



/**
 *  常用的主动方法
 */

//返回
- (void)goBackPage;

//打电话
- (void)callPhone:(NSString *)phone;
//push
- (void)pushPage:(UIViewController *)viewController Animated:(BOOL)animated;
//pop
- (void)popAnimated:(BOOL)animated;
//popToRoot
- (void)popToRootAnimated:(BOOL)animated;

//关闭ios右滑返回
-(void)cancelSideBack;
/*
 开启ios右滑返回
 */
- (void)startSideBack;

@end
