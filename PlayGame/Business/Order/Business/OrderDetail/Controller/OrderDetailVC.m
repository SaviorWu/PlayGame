//
//  OrderDetailVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "OrderDetailVC.h"
#import "OrderModel.h"
#import "OrderCommentVC.h"
#import "EMChatViewController.h"
@interface OrderDetailVC ()
@property (nonatomic, strong) UserGameModel* userGameModel;
@property (nonatomic, strong) OrderModel* orderModel;

@end

@implementation OrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"订单详情";
    [self addNavigationView];
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"OrderHeaderCell"];
}
- (void)loadUI{
    [self showHudInView:self.view];
    
    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"dd":self.orderID} url:@"/ping/mei/dxq" callback:^(JTBaseReqModel *model) {
        [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"dd":self.orderID} url:@"/ping/mei/wcs" callback:^(JTBaseReqModel *m){
            NSString* commt = @"3";
            if (m.zt == 1) {
                commt = m.sj[@"commt"];
            }
            
            if (model.zt == 1){
                UserGameModel* ugModel = [UserGameModel mj_objectWithKeyValues:model.sj[@"user"]];
                OrderModel* oModel = [OrderModel mj_objectWithKeyValues:model.sj[@"order"]];
                oModel.commt = commt;
                self.userGameModel = ugModel;
                self.orderModel = oModel;
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIOrderDetailHeaderType),
                                                                     BM_imageName:ugModel.header,
                                                                     BM_mark:ugModel.sex,
                                                                     BM_title:ugModel.nickname,
                                                                     BM_subTitle:ugModel.age,
                                                                     BM_mark:oModel.commt}]];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                     BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                     BM_cellHeight:@(10)}]];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                                     BM_title:@"品类",
                                                                     BM_subTitle:oModel.gname}]];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                                     BM_leading:@(15),
                                                                     BM_trading:@(15)}]];
                
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                                     BM_title:@"时间",
                                                                     BM_subTitle:oModel.time}]];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                                     BM_leading:@(15),
                                                                     BM_trading:@(15)}]];
                
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                                     BM_title:@"数量",
                                                                     BM_subTitle:oModel.play_round}]];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                                     BM_leading:@(15),
                                                                     BM_trading:@(15)}]];
                
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                                     BM_title:@"订单编号",
                                                                     BM_subTitle:oModel.order_num}]];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                                     BM_leading:@(15),
                                                                     BM_trading:@(15)}]];
                
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                                     BM_title:@"合集金额",
                                                                     BM_subTitle:oModel.pay_money,
                                                                     BM_mark:@"合计："}]];
                
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UITipsType),
                                                                     BM_title:oModel.statustxt,
                                                                     BM_leading:@(15),
                                                                     BM_trading:@(15),
                                                                     BM_titleSize:@(14),
                                                                     BM_titleColor:[UIColor lightGrayColor],
                                                                     BM_TitleAlignment:@(NSTextAlignmentCenter),
                                                                     BM_backColor:[UIColor clearColor]}]];
                
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                     BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                     BM_cellHeight:@(20)}]];
                
                if ([oModel.status intValue] == 1) {
                    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"申请退款",
                                                                         BM_modelId:oModel.status,
                                                                         BM_leading:@(20),
                                                                         BM_trading:@(20),
                                                                         BM_backColor:UIColor.whiteColor,
                                                                         BM_titleColor:UIColor.blackColor,
                                                                         BM_cellHeight:@(50),
                                                                         BM_type:@(UIConfirnBtnType)}]];
                }else if([oModel.status intValue] == 4){
                    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"服务完成",
                                                                         BM_modelId:oModel.status,
                                                                         BM_leading:@(20),
                                                                         BM_trading:@(20),
                                                                         BM_backColor:UIColor.whiteColor,
                                                                         BM_titleColor:[UIColor colorWithHex:MAIN_BLUE],
                                                                         BM_cellHeight:@(50),
                                                                         BM_mark:@"1",
                                                                         BM_type:@(UIConfirnBtnType)}]];
                    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                         BM_cellHeight:@(15)}]];
                    
                    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"申请退款",
                                                                         BM_modelId:oModel.status,
                                                                         BM_leading:@(20),
                                                                         BM_trading:@(20),
                                                                         BM_backColor:UIColor.whiteColor,
                                                                         BM_titleColor:UIColor.blackColor,
                                                                         BM_cellHeight:@(50),
                                                                         BM_mark:@"2",
                                                                         BM_type:@(UIConfirnBtnType)}]];
                }else if([oModel.status intValue] == 5){
                    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"完成订单",
                                                                         BM_modelId:oModel.status,
                                                                         BM_leading:@(20),
                                                                         BM_trading:@(20),
                                                                         BM_backColor:[UIColor colorWithHex:MAIN_BLUE],
                                                                         BM_titleColor:UIColor.whiteColor,
                                                                         BM_cellHeight:@(50),
                                                                         BM_type:@(UIConfirnBtnType)}]];
                }else{
                    
                }
                [self.tableView reloadData];
            }
            
            [self hideAllHud];
        }];
        
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIBaseModel* model = self.dataArray[indexPath.row];
    
    if ([model.type  isEqual: @(UIOrderDetailHeaderType)]) {
        return [tableView reloadCell:@"OrderHeaderCell" withModel:self.dataArray[indexPath.row] withBlock:^(id  _Nullable value) {
            NSLog(@"发送消息");
            EMChatViewController *vc = [[EMChatViewController alloc] initWithConversationId:self.userGameModel.gid type:EMConversationTypeChat createIfNotExist:YES];
            vc.vcTitle = self.userGameModel.nickname;
            vc.header = self.userGameModel.header;
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else if([model.type  isEqual: @(UILabelContentType)]){
        return [tableView reloadCell:@"UILabelContentCell" withModel:self.dataArray[indexPath.row] withBlock:nil];
    }else if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            [self.tableView reloadData];
            if ([model.modelId intValue] == 1) {//申请退款
                [self showHudInView:self.view];
                [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"dd":self.orderID} url:@"/ping/mei/sqt" callback:^(JTBaseReqModel *model) {
                    [self showHint:model.xx];
                    if (model.zt == 1) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                    [self hideAllHud];
                }];
            }else if([model.modelId intValue] == 4){// markid=1 服务完成 markid=2申请退款
                if ([model.mark intValue] == 1) {
                    [self showHudInView:self.view];
                    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"dd":self.orderID} url:@"/ping/mei/wc" callback:^(JTBaseReqModel *model) {
                        [self showHint:model.xx];
                        if (model.zt == 1) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        [self hideAllHud];
                    }];
                }else if ([model.mark intValue] == 2){
                    [self showHudInView:self.view];
                    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"dd":self.orderID} url:@"/ping/mei/sqt" callback:^(JTBaseReqModel *model) {
                        [self showHint:model.xx];
                        if (model.zt == 1) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                        [self hideAllHud];
                    }];
                }
            }else if([model.modelId intValue] == 5){// 完成订单 跳评论页面
                OrderCommentVC* vc = [[OrderCommentVC alloc] init];
                vc.userGameModel = self.userGameModel;
                vc.orderID = self.orderID;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                
            }
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
