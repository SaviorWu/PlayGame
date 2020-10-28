//
//  BaseController.m
//  CNUKwallet
//
//  Created by 黄焕林 on 2018/9/6.
//  Copyright © 2018年 黄焕林. All rights reserved.
//

#import "BaseController.h"
#import "UIColor+Extension.h"
@interface BaseController ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign)BOOL isCanUseSideBack;  // 手势是否启动
@end

@implementation BaseController

#pragma mark  life Cycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navition"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    //配置navagationbar的属性
    [self.navigationController setNavigationBarHidden:_navagationBarHiden animated:YES];
    self.navigationController.navigationBar.tintColor =self.navagationBarTextColor?:[UIColor hexColor:@"#000000"];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:self.navagationBarTextColor?:[UIColor hexColor:@"#000000"],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *stringClass = NSStringFromClass(self.class);
    NSLog(@"当前类名 ：%@",stringClass);
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 44, 44);
    backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0);
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

#pragma mark methods

- (void)goBack{
    [self pop];
}

- (void)push:(UIViewController *)viewController {
    if (self.navigationController) {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)pop{
    if (self.navigationController&&self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)popToRoot{
    if (self.navigationController&&self.navigationController.viewControllers.count>1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}


#pragma mark Setter or Getter

- (void)setNavagationBarHiden:(BOOL)navagationBarHiden{
    _navagationBarHiden = navagationBarHiden;
    [self.navigationController setNavigationBarHidden:navagationBarHiden animated:YES];
}


@end
