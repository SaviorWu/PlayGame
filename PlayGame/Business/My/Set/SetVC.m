//
//  SetVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/8.
//

#import "SetVC.h"
#import "HelpVC.h"
#import "ChangePswdVC.h"
@interface SetVC ()

@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"设置";
    [self addNavigationView];
}
- (void)loadUI{
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(10)}]];
//    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"修改密码",
//                                                         BM_cellHeight:@(50),
//                                                         BM_SubAlignment:@(1),
//                                                         BM_leading:@(-20),
//                                                         BM_mark:@"1",
//                                                         BM_type:@(UIImageLabelSelectType)}]];
//    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
//                                                         BM_leading:@(20),
//                                                         BM_trading:@(20)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"修改支付密码",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(1),
                                                         BM_leading:@(-20),
                                                         BM_mark:@"1",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"帮助中心",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(1),
                                                         BM_leading:@(-20),
                                                         BM_mark:@"1",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(64)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"退出登录",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_backColor:[UIColor colorWithHex:0x00AAFE],
                                                         BM_titleColor:UIColor.whiteColor,
                                                         BM_cellHeight:@(50),
                                                         BM_type:@(UIConfirnBtnType)}]];
    [self.tableView reloadData];
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
    if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            [UserModelManager userLogout];
        }];
    }else if([model.type  isEqual: @(UIImageLabelSelectType)]){
        return [tableView reloadCell:@"UIImageLabelSelectCell" withModel:model withBlock:nil];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        ChangePswdVC* vc = [[ChangePswdVC alloc] init];
        vc.type = 2;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3) {
        HelpVC* vc = [[HelpVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        
    }
}
@end
