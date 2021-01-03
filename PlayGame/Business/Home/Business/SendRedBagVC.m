//
//  SendRedBagVC.m
//  PlayGame
//
//  Created by admin on 2020/12/25.
//

#import "SendRedBagVC.h"

@interface SendRedBagVC ()
@property (nonatomic, strong) NSString* money;
@property (nonatomic, strong) NSString* mark;
@end

@implementation SendRedBagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"发红包";
    self.money = @"0";
    [self addNavigationView];
//    [self addRefreshLoading];
    self.tableView.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"RedBagCell"];
    [self.tableView registCell:@"RedBagCinMoneyCell"];
    
}
- (void)loadUI{
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(10)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIRedBagType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(10)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIRedBagCinMoneyType),
                                                         BM_title:@"总金额",
                                                         BM_KeyBoardType:@(1),
                                                         BM_subTitle:@"元",
                                                         BM_titleSize:@(15),
                                                         BM_mark:@"请输入红包金额"}]];
    
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(10)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIRedBagCinMoneyType),
                                                         BM_title:@"备注",
                                                         BM_subTitle:@"",
                                                         BM_mark:@"请输入备注"}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(30)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UITipsType),
                                                         BM_title:[NSString stringWithFormat:@"¥%.2f",self.money.floatValue],
                                                         BM_TitleAlignment:@(1),
                                                         BM_titleColor:UIColor.blackColor,
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_titleSize:@(30),
                                                         BM_cellHeight:@(50)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(30)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"塞进红包",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_backColor:[UIColor redColor],
                                                         BM_titleColor:UIColor.whiteColor,
                                                         BM_cellHeight:@(50),
                                                         BM_type:@(UIConfirnBtnType)}]];
    //    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIGodPicType),
    //                                                         BM_title:model.nickname,
    //                                                         BM_modelId:model.uid,
    //                                                         BM_subTitle:model.read_count,
    //                                                         BM_mark:model.imgcount}]];
    
    [self.tableView reloadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIBaseModel* model = self.dataArray[indexPath.row];
    if ([model.type  isEqual: @(UIGodPicType)]) {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }else if([model.type isEqual:@(UIRedBagType)]){
        return [tableView reloadCell:@"RedBagCell" withModel:model withBlock:nil];
    }else if([model.type isEqual:@(UIRedBagCinMoneyType)]){
        return [tableView reloadCell:@"RedBagCinMoneyCell" withModel:model withBlock:^(id  _Nullable value) {
            if ([value[@"key"] intValue] == 1) {
                NSLog(@"输入金额 = %@",value[@"value"]);
                self.money = value[@"value"];
                
            }else if ([value[@"key"] intValue] == 2 ){
                NSLog(@"输入备注 = %@",value[@"value"]);
                self.mark = value[@"value"];
            }else{
                for (UIBaseModel* uiBaseModel in self.dataArray) {
                    if ([uiBaseModel.type  isEqual: @(UITipsType)]) {
                        uiBaseModel.title = [NSString stringWithFormat:@"¥%.2f",self.money.floatValue];
                    }
                }
                [self.tableView reloadData];
            }
        }];
    }else if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"塞进红包");
            [self.tableView reloadData];
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"发送提醒" message:[NSString stringWithFormat:@"是否将%@元塞进红包",self.money] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction*cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction*okAction=[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self showHudInView:self.view];
                [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token}
                                           url:@"/ping/hongbao/users_info"
                                      callback:^(JTBaseReqModel *model) {
                    if (model.zt == 1) {
                        [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,
                                                         @"hb":self.money,
                                                         @"desc":self.mark}
                                                   url:@"/ping/hongbao/send_redpacket"
                                              callback:^(JTBaseReqModel *model) {
                            [self showHint:model.xx];
                            [self hideAllHud];
                        }];
                    }else{
                        [self hideAllHud];
                    }
                }];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:okAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
