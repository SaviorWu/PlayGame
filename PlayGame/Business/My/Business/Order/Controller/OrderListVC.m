//
//  OrderListVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "OrderListVC.h"
#import "OrderModel.h"
#import "OrderDetailVC.h"
@interface OrderListVC ()

@end

@implementation OrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"邀请列表";
    [self addNavigationView];
//    [self hiddenBackBtn:YES];
    [self addRefreshLoading];
    self.tableView.mj_footer.hidden = YES;
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"OrderListCell"];
}
- (void)loadData{
    [self.tableView.mj_header beginRefreshing];
    [self showHudInView:self.view];
    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token} url:@"/ping/mei/dlb" callback:^(JTBaseReqModel *model) {
        if (model.zt == 1){
            [self.dataArray removeAllObjects];
            for (NSDictionary* dic in model.sj) {
                OrderModel* vc = [OrderModel mj_objectWithKeyValues:dic];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIOrderListType),
                                                                     BM_modelId:vc.id,
                                                                     BM_title:vc.gname,
                                                                     BM_subTitle:vc.statustxt,
                                                                     BM_time:vc.time,
                                                                     BM_dataArray:@[vc.play_round,vc.unit],
                                                                     BM_backColor:[UIColor colorWithHex:0x00A0EE],
                                                                     BM_cellHeight:@(100)}]];
            }
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
        [self hideAllHud];
    }];
}
- (void)loadUI{
    [self loadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [tableView reloadCell:@"OrderListCell" withModel:self.dataArray[indexPath.row] withBlock:nil];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBaseModel* model = self.dataArray[indexPath.row];
    OrderDetailVC* vc = [[OrderDetailVC alloc] init];
    vc.orderID = model.modelId;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
