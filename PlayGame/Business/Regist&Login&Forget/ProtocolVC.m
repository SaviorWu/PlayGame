//
//  ProtocolVC.m
//  PlayGame
//
//  Created by admin on 2020/11/6.
//

#import "ProtocolVC.h"

@interface ProtocolVC ()

@end

@implementation ProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"用户协议";
    [self addNavigationView];
}
- (void)loadUI{
    [self showHudInView:self.view];
    [JTNetwork requestGetWithParam:@{} url:@"/ping/mei/xy" callback:^(JTBaseReqModel *model) {
        if (model.zt  == 1) {
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_cellHeight:@(20)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:model.sj,
                                                                 BM_titleSize:@(14),
                                                                 BM_leading:@(20),
                                                                 BM_mark:@"1",// 显示网页内容
                                                                 BM_type:@(UITipsType)}]];
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
    if([model.type  isEqual: @(UITipsType)]){
        return [tableView reloadCell:@"UITipsCell" withModel:model withBlock:nil];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
