//
//  SubmitOrderVC.h
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "BaseController.h"
#import "GameInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface SubmitOrderVC : BaseController
@property (nonatomic, strong) GameInfoModel* gameInfo;
@property (nonatomic, strong) UserBaseModel* ubModel;
@property (nonatomic, strong) NSMutableArray* gameList;
@property (nonatomic, strong) NSString* gameID;
@property (nonatomic, strong) NSString* godID;
@end

NS_ASSUME_NONNULL_END
