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
    LoginVC* logVC = [[LoginVC alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:logVC];
    [MYAPP window].rootViewController = nav;
    
//    JTBaseTabBarController *tabbar = [[JTBaseTabBarController alloc] init];
//    JTBaseNavigationController *rootNavi =
//    [[JTBaseNavigationController alloc] initWithRootViewController:tabbar];
//    [MYAPP window].rootViewController = rootNavi;
    return YES;
}


@end
