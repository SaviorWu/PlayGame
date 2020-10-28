//
//  BaseTableViewController.h
//  PlayGame
//
//  Created by admin on 2020/10/28.
//

#import "BaseController.h"
#import "UITableViewCell+loadCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableViewController : BaseController<UITableViewDelegate, UITableViewDataSource>

- (void)loadData;
- (void)reloadTableView;

@property (nonatomic, copy) UITableView* tableView;
@property (nonatomic, strong) NSMutableArray* dataArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, assign) BOOL bShowFresh;
@end

NS_ASSUME_NONNULL_END
