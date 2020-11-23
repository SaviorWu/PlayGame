//
//  ChangePswdVC.h
//  PlayGame
//
//  Created by FriendWu on 2020/11/8.
//

#import "BaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChangePswdVC : BaseTableViewController
@property (nonatomic, assign) NSInteger type; // 1-修改登录密码，2-修改支付密码，3-设置支付密码
@end

NS_ASSUME_NONNULL_END
