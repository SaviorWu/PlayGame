//
//  JTBaseController.m
//  CNUKwallet
//
//  Created by 黄焕林 on 2018/9/6.
//  Copyright © 2018年 黄焕林. All rights reserved.
//

#import "JTBaseController.h"
#import "UIColor+Extension.h"
@interface JTBaseController ()<UIGestureRecognizerDelegate>
@property (nonatomic, assign)BOOL isCanUseSideBack;  // 手势是否启动
@end

@implementation JTBaseController

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
    [backButton addTarget:self action:@selector(goBackPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.edgesForExtendedLayout = UIRectEdgeTop;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

#pragma mark methods

- (void)goBackPage{
    [self popAnimated:YES];
}

- (void)pushPage:(UIViewController *)viewController Animated:(BOOL)animated {
    if (self.navigationController) {
        [self.navigationController pushViewController:viewController animated:animated];
    }
}

- (void)popAnimated:(BOOL)animated{
    if (self.navigationController&&self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:animated];
    }
    
}

- (void)popToRootAnimated:(BOOL)animated{
    if (self.navigationController&&self.navigationController.viewControllers.count>1) {
        [self.navigationController popToRootViewControllerAnimated:animated];
    }
}

- (void)callPhone:(NSString *)phone{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}

//关闭ios右滑返回
-(void)cancelSideBack{
    self.isCanUseSideBack = NO;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}

/*
 开启ios右滑返回
 */
- (void)startSideBack {
    self.isCanUseSideBack=YES;
    
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark Setter or Getter

- (void)setNavagationBarHiden:(BOOL)navagationBarHiden{
    _navagationBarHiden = navagationBarHiden;
    [self.navigationController setNavigationBarHidden:navagationBarHiden animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
