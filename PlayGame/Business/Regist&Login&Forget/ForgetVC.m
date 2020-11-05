//
//  ForgetVC.m
//  PlayGame
//
//  Created by admin on 2020/11/5.
//

#import "ForgetVC.h"

@interface ForgetVC ()

@end

@implementation ForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"忘记密码";
    [self addNavigationView];
}
- (void)loadUI{
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(64)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(20)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请输入手机号",
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
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请输入新密码",
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
            if (indexPath.row == 1) {
                [self.reqParam setObject:value forKey:@"mobile"];
            }else if(indexPath.row == 5){
                [self.reqParam setObject:[NSString base64EncodeString:value] forKey:@"password"];
            }
        }];
    }else if([model.type  isEqual: @(UIVerificationType)]){
        return [tableView reloadCell:@"UIVerificationCodeCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"UIVerificationCodeCell = %@ row = %ld", value,(long)indexPath.row);
            if ([value[@"code"] intValue] == 1) {
                [JTNetwork requestGetWithParam:@{@"mobile":self.reqParam[@"mobile"],@"type":@"login"} url:@"/ping/mei/yzm" callback:^(JTBaseReqModel *model) {
                    NSLog(@"%@", model);
                }];
            }else{
                [self.reqParam setObject:value[@"data"] forKey:@"verify"];
            }
        }];
    }else if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"点击登录");
            [self.tableView reloadData];
            if ([[self.reqParam allKeys] count] != 3) {
                [self showHint:@"请填写完所有信息"];
                return;
            }
            [JTNetwork requestGetWithParam:self.reqParam url:@"/ping/mei/dl" callback:^(JTBaseReqModel *model) {
                NSLog(@"model = %@",model);
            }];
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
