//
//  UserModel.m
//  PlayGame
//
//  Created by admin on 2020/11/5.
//

#import "UserModel.h"

@implementation UserModel
- (void)setToken:(NSString *)token{
    _token = token;
    static dispatch_once_t disOnce;
    dispatch_once(&disOnce,^ {
        NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setObject:token forKey:@"token"];
        [userdefault synchronize];
    });
}
- (void)setUid:(NSString *)uid{
    _uid = uid;
    static dispatch_once_t disUid;
    dispatch_once(&disUid,^ {
        NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
        [userdefault setObject:uid forKey:@"uid"];
        [userdefault synchronize];
    });
}
@end
