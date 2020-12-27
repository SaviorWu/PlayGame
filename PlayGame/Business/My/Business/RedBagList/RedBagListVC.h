//
//  RedBagListVC.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/26.
//

#import "BaseTableViewController.h"
#import "JXCategoryView.h"
NS_ASSUME_NONNULL_BEGIN

@interface RedBagListVC : BaseTableViewController<JXCategoryListContentViewDelegate>
@property (nonatomic, assign) NSInteger type;
@end

NS_ASSUME_NONNULL_END
