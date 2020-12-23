//
//  MyViewController.m
//  PlayGame
//
//  Created by admin on 2020/11/6.
//

#import "MyViewController.h"
#import "SetVC.h"
#import "MyPorketVC.h"
#import "OrderListVC.h"
#import "TestVC.h"
#import "GodPictureListVC.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenNavigation];
    [self.tableView registCell:@"MyHeadNameIDCell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets padding = UIEdgeInsetsMake(-20, 0, 0, 0);
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(padding);
        }];
    }];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadUI];
}

- (void)loadUI{
    [self showHudInView:self.view];
    NSLog(@"token = %@ uid = %@",[UserModelManager shareInstance].userModel.token,[UserModelManager shareInstance].userModel.uid);
    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"gr":[UserModelManager shareInstance].userModel.uid} url:@"/ping/mei/grzx" callback:^(JTBaseReqModel *model) {
        if (model.zt == 1){
            [self.dataArray removeAllObjects];
            [UserModelManager shareInstance].userModel.money = model.sj[@"userdata"][@"money"];
            [UserModelManager shareInstance].userModel.nickname = model.sj[@"userdata"][@"nickname"];
            [UserModelManager shareInstance].userModel.header = model.sj[@"userdata"][@"header"];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor colorWithHex:0x00A0EE],
                                                                 BM_cellHeight:@(100)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIMyHeadNameIDType),
                                                                 BM_title:[UserModelManager shareInstance].userModel.nickname,
                                                                 BM_subTitle:[UserModelManager shareInstance].userModel.uid,
                                                                 BM_mark:[UserModelManager shareInstance].userModel.header,
                                                                 BM_backColor:[UIColor colorWithHex:0x00A0EE],
                                                                 BM_cellHeight:@(100)}]];
            
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor whiteColor],
                                                                 BM_cellHeight:@(15)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"我的钱包",
                                                                 BM_mark:@"myproket",
                                                                 BM_leading:@(20),
                                                                 BM_trading:@(SCREEN_WIDTH - 120),
                                                                 BM_backColor:[UIColor colorWithHex:MAIN_RED],
                                                                 BM_titleColor:UIColor.whiteColor,
                                                                 BM_cellHeight:@(40),
                                                                 BM_type:@(UIConfirnBtnType)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor whiteColor],
                                                                 BM_cellHeight:@(15)}]];
            
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_cellHeight:@(20)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"设置",
                                                                 BM_subTitle:@"设置",
                                                                 BM_cellHeight:@(50),
    //                                                             BM_leading:@(-20),
                                                                 BM_SubAlignment:@(1),
                                                                 BM_mark:@"1",
                                                                 BM_type:@(UIImageLabelSelectType)}]];
            
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_cellHeight:@(1)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"订单-灰",
                                                                 BM_subTitle:@"我的邀请",
                                                                 BM_cellHeight:@(50),
    //                                                             BM_leading:@(-20),
                                                                 BM_SubAlignment:@(1),
                                                                 BM_mark:@"1",
                                                                 BM_type:@(UIImageLabelSelectType)}]];
            
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_cellHeight:@(1)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"照片",
                                                                 BM_subTitle:@"大神风采",
                                                                 BM_cellHeight:@(50),
    //                                                             BM_leading:@(-20),
                                                                 BM_SubAlignment:@(1),
                                                                 BM_mark:@"1",
                                                                 BM_type:@(UIImageLabelSelectType)}]];
            
            
            
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                                 BM_leading:@(20),
                                                                 BM_trading:@(20)}]];
            
            [self.tableView reloadData];
        }
        
        [self hideAllHud];
    }];
    
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
    UIBaseModel* model = self.dataArray[indexPath.row];
    if([model.type  isEqual: @(UIMyHeadNameIDType)]){
        return [tableView reloadCell:@"MyHeadNameIDCell" withModel:model withBlock:nil];
    }else if([model.type  isEqual: @(UIImageLabelSelectType)]){
        return [tableView reloadCell:@"UIImageLabelSelectCell" withModel:model withBlock:nil];
    }else if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            MyPorketVC* vc = [[MyPorketVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBaseModel* model = self.dataArray[indexPath.row];
    if([model.type  isEqual: @(UIImageLabelSelectType)]) {
        if (indexPath.row == 6){
            TestVC* vc = [[TestVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 8){
            OrderListVC* vc = [[OrderListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.row == 10){
            GodPictureListVC* vc = [[GodPictureListVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
}
@end
