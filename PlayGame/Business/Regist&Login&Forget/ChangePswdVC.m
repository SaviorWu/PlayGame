//
//  ChangePswdVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/8.
//

#import "ChangePswdVC.h"
@interface ChangePswdVC ()

@end

@implementation ChangePswdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.type == 1){
        self.naviTitle = @"修改登录密码";
    }else if(self.type == 2){
        self.naviTitle = @"修改支付密码";
    }else if(self.type == 3){
        self.naviTitle = @"设置支付密码";
    }
    [self addNavigationView];
}
- (void)loadUI{
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(1)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(20)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:self.type == 1?@"请输入手机号":@"请输入注册手机号",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_KeyBoardType:@(UIKeyboardTypePhonePad),
                                                         BM_type:@(UIFiledType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(10)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请输入验证码",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_KeyBoardType:@(UIKeyboardTypeNumberPad),
                                                         BM_type:@(UIVerificationType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(10)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:self.type == 1?@"请输入新密码":@"请输入登录密码",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_mark:@"1",
                                                         BM_KeyBoardType:@(UIKeyboardTypeASCIICapable),
                                                         BM_type:@(UIFiledType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(64)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:self.type == 1?@"重置密码":@"下一步",
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
            if (indexPath.row == 2) {
                [self.reqParam setObject:value forKey:@"mobile"];
            }else if(indexPath.row == 8){
                [self.reqParam setObject:[NSString base64EncodeString:value] forKey:@"password"];
            }
        }];
    }else if([model.type  isEqual: @(UIVerificationType)]){
        return [tableView reloadCell:@"UIVerificationCodeCell" withModel:model withBlock:^(id  _Nullable value) {
            if ([value[@"code"] intValue] == 1) {
                [self.tableView reloadData];
                [JTNetwork requestGetWithParam:@{@"mobile":self.reqParam[@"mobile"],@"type":@"resetverify",@"token":[UserModelManager shareInstance].userModel.token} url:@"/ping/mei/yzm" callback:^(JTBaseReqModel *model) {
                    NSLog(@"%@", model);
                }];
            }else{
                [self.reqParam setObject:value[@"data"] forKey:@"verify"];
            }
        }];
    }else if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
//            NSLog(@"点击登录");
//            [self.tableView reloadData];
//            if (self.type == 2) {
//                [self.reqParam setObject:[UserModelManager shareInstance].userModel.token forKey:@"token"];
//            }
//            [JTNetwork requestGetWithParam:self.reqParam url:self.type == 1?@"/ping/mei/zhmm":@"/ping/mei/xg1" callback:^(JTBaseReqModel *model) {
//                NSLog(@"model = %@",model);
//                [self showHint:model.msg];
//                if (model.code == 1) {
//                    if (self.type == 1) {
//                        [UserModelManager userLogout];
//                    }else{
//                        ResetPaypswdVC* vc = [[ResetPaypswdVC alloc] init];
//                        [self.navigationController pushViewController:vc animated:YES];
//                    }
//                }
//            }];
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
