//
//  MyViewController.m
//  PlayGame
//
//  Created by admin on 2020/11/6.
//

#import "MyViewController.h"
#import "SetVC.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenNavigation];
    [self.tableView registCell:@"MyHeadNameIDCell"];
}
- (void)loadUI{
    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"gr":[UserModelManager shareInstance].userModel.uid} url:@"/ping/mei/grzx" callback:^(JTBaseReqModel *model) {
        
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
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(20)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"设置",
                                                             BM_subTitle:@"设置",
                                                             BM_cellHeight:@(50),
//                                                             BM_leading:@(-20),
                                                             BM_SubAlignment:@(1),
                                                             BM_mark:@"1",
                                                             BM_type:@(UIImageLabelSelectType)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                             BM_leading:@(20),
                                                             BM_trading:@(20)}]];
        
        
        [self.tableView reloadData];
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
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        SetVC* vc = [[SetVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
