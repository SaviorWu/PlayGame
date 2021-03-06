//
//  RedBagListVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/26.
//

#import "RedBagListVC.h"
#import "RedBagModel.h"
#import "RedBagDetailVC.h"
@interface RedBagListVC ()

@end

@implementation RedBagListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"红包列表";
    if (self.type == 0) {
        [self addNavigationView];
    }else{
        [self hiddenNavigation];
    }
    [self addRefreshLoading];
    
}
- (UIView *)listView {
    return self.view;
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"RedBagListCell"];
}
- (void)loadData{
    [self.tableView.mj_header beginRefreshing];
    [self showHudInView:self.view];
    NSMutableDictionary* param = [[NSMutableDictionary alloc] init];
    NSString* reqURL = @"";
    
    if (self.type == 0) {
        [param setObject:[UserModelManager shareInstance].userModel.token forKey:@"token"];
        [param setObject:@(self.pageIndex) forKey:@"page"];
        reqURL = @"/app/redpacket/redpacket_list";
    }else if (self.type == 1){
        [param setObject:[UserModelManager shareInstance].userModel.token forKey:@"token"];
        [param setObject:@(self.pageIndex) forKey:@"page"];
        reqURL = @"/app/redpacket/my_send_redpacket";
    }else if (self.type == 2){
        [param setObject:[UserModelManager shareInstance].userModel.token forKey:@"token"];
        [param setObject:@(1) forKey:@"lei"];
        [param setObject:@(self.pageIndex) forKey:@"page"];
        reqURL = @"/app/redpacket/my_hongbao";
    }
    else if (self.type == 3){
        [param setObject:[UserModelManager shareInstance].userModel.token forKey:@"token"];
        [param setObject:@(2) forKey:@"lei"];
        [param setObject:@(self.pageIndex) forKey:@"page"];
        reqURL = @"/app/redpacket/my_hongbao";
    }
    [JTNetwork requestGetWithParam:param url:reqURL callback:^(JTBaseReqModel *model) {
        if (model.code == 1){
            if (self.pageIndex == 1) {
                [self.dataArray removeAllObjects];
            }
            NSString* mark = @"";
            for (NSDictionary* dic in model.data) {
                RedBagModel* model = [RedBagModel mj_objectWithKeyValues:dic];
                if (self.type == 0) {
                    mark = @"1";
                }else if(self.type == 1){
                    if ([model.rpacket_s_state intValue] == 2) {
                        mark = @"3";
                    }else{
                        mark = @"2";
                    }
                }else if(self.type == 2 || self.type == 3){
                    if ([model.rpacket_s_state intValue] == 2) {
                        mark = @"3";
                    }else{
                        mark = @"4";
                    }
                }else{
                    
                }
                
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                     BM_cellHeight:@(20),
                                                                     BM_backColor:[UIColor colorWithHex:0xf8f8f8]}]];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIRedBagListType),
                                                                     BM_title:model.rpacket_s_title,
                                                                     BM_subTitle:model.rpactet_s_desc,
                                                                     BM_modelId:model.rpacket_s_id,
                                                                     BM_dataArray:@[model.applicants_count,model.rpacket_s_price,model.rpacket_s_state],
                                                                     BM_mark:mark}]];
            }
            [self.tableView reloadData];
            self.pageIndex++;
        }
        [self.tableView.mj_header endRefreshing];
        [self hideAllHud];
    }];
}
- (void)loadUI{
    [self loadData];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIBaseModel* uiModel = self.dataArray[indexPath.row];
    if ([uiModel.type  isEqual: @(UIRedBagListType)]) {
        return [tableView reloadCell:@"RedBagListCell" withModel:self.dataArray[indexPath.row] withBlock:^(id  _Nullable value) {
            NSLog(@"申请领取红包");
            if ([uiModel.mark intValue] == 1) {
                [self showHudInView:self.view];
                [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,@"rpacket_s_id":uiModel.modelId} url:@"/app/redpacket/apply_collection" callback:^(JTBaseReqModel *model) {
                    [self hideAllHud];
                    [self showHint:model.msg];
                    [self.tableView.mj_header beginRefreshing];
                }];
            }else if([uiModel.mark intValue] == 2){
                [self showHudInView:self.view];
                
                [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,
                                                 @"rpacket_s_id":uiModel.modelId} url:@"/app/redpacket/apply_list"
                                      callback:^(JTBaseReqModel *model) {
                    if (model.code == 1) {
                        NSString* uids = @"";
                        NSString* max = @"";
                        for (NSDictionary* dic in model.data) {
                            if (uids.length == 0) {
                                uids = [RedBagModel mj_objectWithKeyValues:dic].uid;
                                max = uids;
                            }else{
                                uids = [NSString stringWithFormat:@"%@,%@",uids,[RedBagModel mj_objectWithKeyValues:dic].uid];
                            }
                        }
                        if (uids.length == 0) {
                            [self showHint:@"暂时没人申请领取哦"];
                            [self hideAllHud];
                            return;
                        }else{
                            [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,
                                                             @"rpacket_s_id":uiModel.modelId,
                                                             @"max":max,
                                                             @"uids":uids
                            } url:@"/app/redpacket/send" callback:^(JTBaseReqModel *model) {
                                [self hideAllHud];
                                if (model.code == 1){
                                    [self showHint:model.msg];
                                }else{
                                    
                                }
                                
                            }];
                        }
                    }
                    else{
                        [self hideAllHud];
                    }
                }];
                
            }else if([uiModel.mark intValue] == 3){
                
            }
            
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBaseModel* uiModel = self.dataArray[indexPath.row];
    RedBagDetailVC* vc = [[RedBagDetailVC alloc] init];
    vc.redBagId = uiModel.modelId;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
