//
//  LoginVC.m
//  PlayGame
//
//  Created by admin on 2020/10/30.
//

#import "LoginVC.h"
#import "ForgetVC.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenNavigation];
}

- (void)loadUI{
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(80)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"登录",
                                                         BM_titleSize:@(20),
                                                         BM_leading:@(20),
                                                         BM_type:@(UITipsType)}]];
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
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请输入密码",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_mark:@"1",
                                                         BM_KeyBoardType:@(UIKeyboardTypeASCIICapable),
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
                                                         BM_cellHeight:@(64)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"登录",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_backColor:[UIColor colorWithHex:0x00AAFE],
                                                         BM_titleColor:UIColor.whiteColor,
                                                         BM_cellHeight:@(50),
                                                         BM_type:@(UIConfirnBtnType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(8)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"点击注册",
                                                         BM_subTitle:@"忘记密码",
                                                         BM_cellHeight:@(50),
                                                         BM_type:@(UIForgetRegistType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(50)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"登录注册即同意",
                                                         BM_titleSize:@(12),
                                                         BM_subTitle:@"《用户协议和隐私政策》",
                                                         BM_subTitleSize:@(12),
                                                         BM_cellHeight:@(50),
                                                         BM_leading:@(0.24*SCREEN_WIDTH),
                                                         BM_trading:@(0.15*SCREEN_WIDTH),
                                                         BM_Width:@(SCREEN_WIDTH - 0.23*SCREEN_WIDTH - 0.375*SCREEN_WIDTH),
                                                         BM_type:@(UILabelButtonType)}]];
    
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
            if (indexPath.row == 3) {
                [self.reqParam setObject:value forKey:@"mobile"];
            }else if(indexPath.row == 6){
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
                if (model.zt != 1) {
                    [self showHint:model.xx];
                }else{
                    
                }
            }];
        }];
    }else if([model.type isEqual:@(UIForgetRegistType)]){
        return [tableView reloadCell:@"UIForgetRegistCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"%@", value);
            if ([value intValue] == 1) {
                
            }else if([value intValue] == 2){
                ForgetVC* vc = [[ForgetVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }else if([model.type isEqual:@(UILabelButtonType)]){
        return [tableView reloadCell:@"UILabelButtonCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"点击按钮");
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

@end
