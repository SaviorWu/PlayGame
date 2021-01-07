//
//  RegistVC.m
//  PlayGame
//
//  Created by admin on 2020/11/6.
//

#import "RegistVC.h"
#import "ProtocolVC.h"
@interface RegistVC ()

@end

@implementation RegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"账号注册";
    [self addNavigationView];
}
- (void)loadUI{
    
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
                                                         BM_cellHeight:@(1)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(1)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(1)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(1)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(1)}]];
//    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请再次确认密码",
//                                                         BM_leading:@(20),
//                                                         BM_trading:@(20),
//                                                         BM_mark:@"1",
//                                                         BM_KeyBoardType:@(UIKeyboardTypeASCIICapable),
//                                                         BM_type:@(UIFiledType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(1)}]];
//    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"(请使用字母+数字的组合密码)",
//                                                         BM_titleSize:@(12),
//                                                         BM_leading:@(20),
//                                                         BM_type:@(UITipsType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(64)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"注册",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_backColor:[UIColor colorWithHex:0x00AAFE],
                                                         BM_titleColor:UIColor.whiteColor,
                                                         BM_cellHeight:@(50),
                                                         BM_type:@(UIConfirnBtnType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(8)}]];
    
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(50)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"登录注册即同意",
                                                         BM_titleSize:@(12),
                                                         BM_subTitle:@"《用户协议和隐私政策》",
                                                         BM_subTitleSize:@(12),
                                                         BM_cellHeight:@(50),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_Width:@(200),
                                                         BM_TitleAlignment:@(2),
                                                         BM_SubAlignment:@(0),
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
            if (indexPath.row == 1) {
                [self.reqParam setObject:value forKey:@"mobile"];
            }else if(indexPath.row == 7){
//                [self.reqParam setObject:[NSString base64EncodeString:value] forKey:@"password"];
            }else if(indexPath.row == 10){
//                [self.reqParam setObject:[NSString base64EncodeString:value] forKey:@"passwordAg"];
            }
        }];
    }else if([model.type  isEqual: @(UIVerificationType)]){
        return [tableView reloadCell:@"UIVerificationCodeCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"UIVerificationCodeCell = %@ row = %ld", value,(long)indexPath.row);
            if ([value[@"code"] intValue] == 1) {
                [self.tableView reloadData];
                [JTNetwork requestGetWithParam:@{@"mobile":self.reqParam[@"mobile"],@"type":@"register"} url:@"/app/userverify/sendVirefy" callback:^(JTBaseReqModel *model) {
                    if (model.code != 1) {
                        [self showHint:model.msg];
                    }
                }];
            }else{
                [self.reqParam setObject:value[@"data"] forKey:@"verify"];
            }
        }];
    }else if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            [self.tableView reloadData];
            [JTNetwork requestGetWithParam:self.reqParam url:@"/app/users/login833" callback:^(JTBaseReqModel *model) {
                NSLog(@"model = %@",model);
                [self showHint:model.msg];
                if (model.code == 1) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }];
    }else if([model.type isEqual:@(UILabelButtonType)]){
        return [tableView reloadCell:@"UILabelButtonCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"点击按钮");
            ProtocolVC* vc = [[ProtocolVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
