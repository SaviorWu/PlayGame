//
//  GodPictureListVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/23.
//

#import "GodPictureListVC.h"
#import "GodPicModel.h"
#import "PictureReviewVC.h"
@interface GodPictureListVC ()
@end

@implementation GodPictureListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"大神风采";
    [self addNavigationView];
    [self addRefreshLoading];
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"GodPictureCell"];
}
- (void)loadData{
    [self.tableView.mj_header beginRefreshing];
    [self showHudInView:self.view];
    [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,@"page":@(self.pageIndex)} url:@"/app/Album/appointlist" callback:^(JTBaseReqModel *model) {
        if (model.code == 1){
            if (self.pageIndex == 1) {
                [self.dataArray removeAllObjects];
            }
            
            for (NSDictionary* dic in model.data) {
                GodPicModel* model = [GodPicModel mj_objectWithKeyValues:dic];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIGodPicType),
                                                                     BM_title:model.nickname,
                                                                     BM_modelId:model.uid,
                                                                     BM_subTitle:model.read_count,
                                                                     BM_mark:model.imgcount}]];
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
    if ([uiModel.type  isEqual: @(UIGodPicType)]) {
        return [tableView reloadCell:@"GodPictureCell" withModel:self.dataArray[indexPath.row] withBlock:^(id  _Nullable value) {
            NSLog(@"付费");
            [self showHudInView:self.view];
            [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,@"gid":uiModel.modelId} url:@"/app/Album/fufeitips" callback:^(JTBaseReqModel *model) {
                [self hideAllHud];
                if (model.code == 1){
                    // 付过费跳转查看照片页面
                    UIBaseModel* model = self.dataArray[indexPath.row];
                    PictureReviewVC* vc = [[PictureReviewVC alloc] init];
                    vc.godID = model.modelId;
                    vc.header = model.imageName;
                    vc.nickName = model.title;
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    // 未付款
                    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"付费提醒" message:@"是否消耗52玩币查看大神照片" preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction*cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                    UIAlertAction*okAction=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self showHudInView:self.view];
                        [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,@"gid":uiModel.modelId} url:@"/app/Album/orderAlbum" callback:^(JTBaseReqModel *model) {
                            [self hideAllHud];
                            if (model.code == 1){
                                NSLog(@"%@",model.data);
                                [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,@"oid":model.data,@"price":@"52"} url:@"/app/ios/appleorderPay" callback:^(JTBaseReqModel *model) {
                                    [self hideAllHud];
                                    if (model.code == 1){
                                        NSLog(@"支付成功，跳转查看照片页面");
                                        UIBaseModel* model = self.dataArray[indexPath.row];
                                        PictureReviewVC* vc = [[PictureReviewVC alloc] init];
                                        vc.godID = model.modelId;
                                        vc.header = model.imageName;
                                        vc.nickName = model.title;
                                        [self.navigationController pushViewController:vc animated:YES];
                                    }
                                }];
                            }
                        }];
                    }];
                    [alertController addAction:cancelAction];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                
            }];
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
