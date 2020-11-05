//
//  UserModelManager.m
//  PlayGame
//
//  Created by admin on 2020/11/5.
//

#import "UserModelManager.h"

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
}
@end
