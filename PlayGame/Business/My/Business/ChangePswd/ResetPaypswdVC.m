//
//  ResetPaypswdVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "ResetPaypswdVC.h"

@interface ResetPaypswdVC ()

@end

@implementation ResetPaypswdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"修改登录密码";
    [self addNavigationView];
}
- (void)loadUI{
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(64)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请设置支付密码",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_KeyBoardType:@(UIKeyboardTypePhonePad),
                                                         BM_type:@(UIFiledType),
                                                         BM_mark:@"1"}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(10)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请再次确认密码",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_KeyBoardType:@(UIKeyboardTypePhonePad),
                                                         BM_type:@(UIFiledType),
                                                         BM_mark:@"1"}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(64)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"重置密码",
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
    if([model.type  isEqual: @(UIFiledType)]){
        return [tableView reloadCell:@"UITextFiledCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"UITextFiledCell = %@ row = %ld", value,(long)indexPath.row);
            NSString* pswd = value;
            if (pswd.length == 0) {
                [self showHint:@"请输入密码"];
            }else{
                if (indexPath.row == 1) {
                    [self.reqParam setObject:[NSString base64EncodeString:value] forKey:@"pay_password"];
                }else if(indexPath.row == 4){
                    [self.reqParam setObject:[NSString base64EncodeString:value] forKey:@"pay_passwordAg"];
                }
            }
            
        }];
    }else if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"点击登录");
            [self.tableView reloadData];
            if(![self.reqParam[@"pay_password"] isEqualToString:self.reqParam[@"pay_passwordAg"]]){
                [self showHint:@"两次输入密码不同"];
            }else{
                [self.reqParam setObject:[UserModelManager shareInstance].userModel.token forKey:@"ys"];
                [JTNetwork requestGetWithParam:self.reqParam url:@"/ping/mei/xg2" callback:^(JTBaseReqModel *model) {
                    NSLog(@"model = %@",model);
                    [self showHint:model.xx];
                    if (model.zt == 1) {
                        [self.navigationController popToRootViewControllerAnimated:YES];
                    }
                }];
            }
            
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
