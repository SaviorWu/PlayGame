//
//  GodPlayerListVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/13.
//

#import "GodPlayerListVC.h"

#import "GodListModel.h"
#import "GodListCell.h"
#import "GodDetailVC.h"
@interface GodPlayerListVC ()

@property (nonatomic, assign) NSInteger pageIdx;
@end

@implementation GodPlayerListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenNavigation];
    [self addRefreshLoading];
    [self.tableView.mj_header beginRefreshing];
    
}
- (UIView *)listView {
    return self.view;
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"GodListCell"];
}

- (void)loadData
{
    [self.dataArray removeAllObjects];
    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"sid":self.selectIdx} url:@"/ping/list/gameGods" callback:^(JTBaseReqModel *model) {
        NSLog(@"model = %@",model);

        for (NSDictionary* dic in model.sj) {
            GodListModel* model = [GodListModel mj_objectWithKeyValues:dic];
            [self.dataArray addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GodListCell* cell = [tableView dequeueReusableCellWithIdentifier:@"GodListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setModel:self.dataArray[indexPath.row]];
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GodListModel* model = self.dataArray[indexPath.row];
    NSLog(@"%@",model.uid);
    GodDetailVC* vc = [[GodDetailVC alloc] init];
    vc.godId = model.uid;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
