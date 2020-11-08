//
//  UserModelManager.m
//  PlayGame
//
//  Created by admin on 2020/11/5.
//

#import "UserModelManager.h"
#import "LoginVC.h"
@implementation UserModelManager
+ (UserModelManager*)shareInstance{
    static UserModelManager* sharedInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[[self class] alloc] init];
        sharedInstance.userModel = [[UserModel alloc] init];
    });
    return sharedInstance;
}
+ (void)userLogout{
    NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault removeObjectForKey:@"token"];
    [userdefault removeObjectForKey:@"ID"];
    [UserModelManager shareInstance].userModel.uid = @"";
    [UserModelManager shareInstance].userModel.token = @"";
    LoginVC* logVC = [[LoginVC alloc] init];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:logVC];
    [MYAPP window].rootViewController = nav;
}
@end
