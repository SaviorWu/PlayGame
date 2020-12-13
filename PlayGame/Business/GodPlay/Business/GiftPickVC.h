//
//  GiftPickVC.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/12.
//

#import "PopViewController.h"
#import "GiffModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GiftPickVC : PopViewController
@property (nonatomic, strong) NSMutableArray<GiffModel*>* arrayGift;
@property (nonatomic, strong) NSString* godId;
@end

NS_ASSUME_NONNULL_END
