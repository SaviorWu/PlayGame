//
//  AppDelegate.m
//  PlayGame
//
//  Created by admin on 2020/10/28.
//

#import "AppDelegate.h"
#import "JTBaseTabBarController.h"
#import "JTBaseNavigationController.h"
#import "LoginVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configIQKeyboard];
    
    NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
    NSString* token = [userdefault objectForKey:@"token"];
    if (token == nil) {
        LoginVC* logVC = [[LoginVC alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:logVC];
        [MYAPP window].rootViewController = nav;
    }else{
        NSString* uid = [userdefault objectForKey:@"uid"];
        [UserModelManager shareInstance].userModel.token = token;
        [UserModelManager shareInstance].userModel.uid = uid;
        JTBaseTabBarController *tabbar = [[JTBaseTabBarController alloc] init];
        JTBaseNavigationController *rootNavi = [[JTBaseNavigationController alloc] initWithRootViewController:tabbar];
        [MYAPP window].rootViewController = rootNavi;
    }
    return YES;
}
- (void)configIQKeyboard
{
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.enable = YES;
    keyboardManager.shouldResignOnTouchOutside = YES;
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    keyboardManager.enableAutoToolbar = NO;
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17];
    keyboardManager.keyboardDistanceFromTextField = 150.0f;
    [keyboardManager.toolbarPreviousNextAllowedClasses addObject:[UIScrollView class]];
}

@end
