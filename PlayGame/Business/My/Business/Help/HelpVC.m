//
//  HelpVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/8.
//

#import "HelpVC.h"
#import "ProtocolVC.h"
@interface HelpVC ()

@end

@implementation HelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"帮助中心";
    [self addNavigationView];
}
- (void)loadUI{
    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token} url:@"/app/users/help_list" callback:^(JTBaseReqModel *model) {
        for (NSDictionary* dic in model.data) {
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:dic[@"title"],
                                                                 BM_cellHeight:@(50),
                                                                 BM_SubAlignment:@(1),
                                                                 BM_leading:@(-20),
                                                                 BM_mark:@"1",
                                                                 BM_dataArray:@[dic[@"content"]],
                                                                 BM_type:@(UIImageLabelSelectType)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                                 BM_leading:@(20),
                                                                 BM_trading:@(20)}]];
        }
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
    if([model.type  isEqual: @(UIImageLabelSelectType)]){
        return [tableView reloadCell:@"UIImageLabelSelectCell" withModel:model withBlock:nil];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBaseModel* model = self.dataArray[indexPath.row];
    ProtocolVC* vc = [[ProtocolVC alloc] init];
    vc.naviTitle = model.subTitle;
    vc.content = model.dataArray[0];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
