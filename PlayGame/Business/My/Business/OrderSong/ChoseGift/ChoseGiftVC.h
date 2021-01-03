//
//  ChoseGiftVC.h
//  PlayGame
//
//  Created by FriendWu on 2021/1/3.
//

#import "BaseTableViewController.h"
#import "GiffModel.h"
typedef void(^clickReturnNSString)(NSString* _Nonnull str);
NS_ASSUME_NONNULL_BEGIN

@interface ChoseGiftVC : BaseTableViewController
@property (nonatomic, strong) NSMutableArray<GiffModel*>* arrayGift;
@property (nonatomic, strong) NSString* giftID;
@property (nonatomic, strong) clickReturnNSString clickBtn;
@end

NS_ASSUME_NONNULL_END
