//
//  JTBaseTabBarController.m
//  CNUKwallet
//
//  Created by 黄焕林 on 2020/3/20.
//  Copyright © 2020 黄焕林. All rights reserved.
//

#import "JTBaseTabBarController.h"
#import "UITabBar+badge.h"
#import "HomeViewController.h"
#import "MyViewController.h"
#import "MessageViewController.h"
#import "OrderListVC.h"
@interface JTBaseTabBarController ()

@end

@implementation JTBaseTabBarController

+ (JTBaseTabBarController *)sharedInstance {
    static JTBaseTabBarController *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setControllers];
    [self setTabBarItems];
    self.delegate = self;
    
}

//- (void)viewWillLayoutSubviews {
//    [super viewWillLayoutSubviews];
//    [self setTabBarItems];
//}

- (void)setControllers {
    
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    MyViewController *myVC = [[MyViewController alloc] init];
    MessageViewController* vc = [[MessageViewController alloc] init];
    OrderListVC* orderVC = [[OrderListVC alloc] init];
    self.viewControllers = @[ homeVC, vc,orderVC,myVC];
}


- (void)setTabBarItems {
    //普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor hexColor:@"#2D2D2D"];
    normalAttrs[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size:10];
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = BASECOLOR;
    selectedAttrs[NSFontAttributeName] = [UIFont fontWithName:@"PingFang-SC-Medium" size:10];
    
    // 设置文字属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    [tabBarItem setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // 去掉黑线
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setBackgroundColor:[UIColor lightGrayColor]];
//    [tabBar setBackgroundImage:[UIImage new]];
//    [tabBar setShadowImage:[UIImage new]];
    
    if (@available(iOS 13.0, *)){
        UITabBarAppearance* tabBarAppearance = [[UITabBarAppearance alloc] init];
        [tabBarAppearance.stackedLayoutAppearance.normal setTitleTextAttributes:normalAttrs];
        [tabBarAppearance.stackedLayoutAppearance.selected setTitleTextAttributes:selectedAttrs];
        tabBarAppearance.shadowColor = [UIColor clearColor];
        [tabBar setStandardAppearance:tabBarAppearance];
    }
    [self.viewControllers
     enumerateObjectsUsingBlock:^(__kindof UIViewController *_Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        if ([obj isKindOfClass:[HomeViewController class]]) {
            obj.tabBarItem.title = @"首页";
            obj.tabBarItem.image =
            [[UIImage imageNamed:@"homeDiss"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.tabBarItem.selectedImage =
            [[UIImage imageNamed:@"homeSelected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        } else if ([obj isKindOfClass:[MyViewController class]]) {
            obj.tabBarItem.title = @"我的";
            obj.tabBarItem.image =
            [[UIImage imageNamed:@"me_inactive"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.tabBarItem.selectedImage =
            [[UIImage imageNamed:@"meCliek"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else if ([obj isKindOfClass:[MessageViewController class]]) {
            obj.tabBarItem.title = @"消息";
            obj.tabBarItem.image =
            [[UIImage imageNamed:@"消息"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.tabBarItem.selectedImage =
            [[UIImage imageNamed:@"消息选择"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else if ([obj isKindOfClass:[OrderListVC class]]) {
            obj.tabBarItem.title = @"订单";
            obj.tabBarItem.image =
            [[UIImage imageNamed:@"订单-灰"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            obj.tabBarItem.selectedImage =
            [[UIImage imageNamed:@"订单-绿"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        }else {
            NSLog(@"Unknown TabBarController");
        }
        [obj.tabBarController.tabBar bringBadgeToFrontOnItemIndex:(int)idx];
    }];
}

- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController {
    [JTBaseTabBarController sharedInstance].selectedTabBarIndex = tabBarController.selectedIndex;
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    return YES;
}






@end
