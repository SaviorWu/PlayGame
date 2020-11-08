//
//  UserModelManager.h
//  PlayGame
//
//  Created by admin on 2020/11/5.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface UserModelManager : NSObject
@property (nonatomic, strong) UserModel* userModel;
+ (UserModelManager*)shareInstance;
+ (void)userLogout;
@end

NS_ASSUME_NONNULL_END
