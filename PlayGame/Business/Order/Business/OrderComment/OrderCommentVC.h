//
//  OrderCommentVC.h
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "BaseController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderCommentVC : BaseController
@property (nonatomic, strong) UserGameModel* userGameModel;
@property (nonatomic, strong) NSString* orderID;
@end

NS_ASSUME_NONNULL_END
