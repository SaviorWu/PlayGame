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

#define num @"0415055666"

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configIQKeyboard];
    
    
    NSString* tian = @"tian";
    NSString* data = [NSString stringWithFormat:@"%@xin",tian];

    NSString* tk = [NSString stringWithFormat:@"110719%@#%@playapp",num,data];
    EMOptions *ops = [EMOptions optionsWithAppkey:tk];
    ops.apnsCertName = nil;
    [[EMClient sharedClient] initializeSDKWithOptions:ops];
    
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
        
        [[EMClient sharedClient] loginWithUsername:[UserModelManager shareInstance].userModel.uid password:[NSString stringWithFormat:@"%@%@",data,[UserModelManager shareInstance].userModel.uid] completion:^(NSString *aUsername, EMError *aError) {
            
        }];
        
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
