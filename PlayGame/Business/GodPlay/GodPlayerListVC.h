//
//  GodPlayerListVC.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/13.
//

#import "BaseTableViewController.h"
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN

@interface GodPlayerListVC : BaseTableViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, strong) NSString* selectIdx;
@end

NS_ASSUME_NONNULL_END
