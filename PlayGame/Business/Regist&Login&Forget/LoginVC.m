//
//  LoginVC.m
//  PlayGame
//
//  Created by admin on 2020/10/30.
//

#import "LoginVC.h"
@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenNavigation];
    [self loadUI];
    
}

- (void)loadUI{
    [self.tableView registCell:@"UISpaceCell"];
    [self.tableView registCell:@"UITipsCell"];
    [self.tableView registCell:@"UITextFiledCell"];
    [self.tableView registCell:@"UIVerificationCodeCell"];
    [self.tableView registCell:@"UIConfirnBtnCell"];
    [self.tableView registCell:@"UIForgetRegistCell"];
    [self.tableView registCell:@"UILabelButtonCell"];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(110)}]];
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
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(10)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请输入密码",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_KeyBoardType:@(UIKeyboardTypeASCIICapable),
                                                         BM_type:@(UIFiledType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(10)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_subTitle:@"请输入验证码",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_KeyBoardType:@(UIKeyboardTypeNumberPad),
                                                         BM_type:@(UIVerificationType)}]];
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
                                                         BM_leading:@(0.21*SCREEN_WIDTH),
                                                         BM_trading:@(0.1*SCREEN_WIDTH),
                                                         BM_Width:@(SCREEN_WIDTH - 0.21*SCREEN_WIDTH - 0.375*SCREEN_WIDTH),
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
    if ([model.type  isEqual: @(UISpaceType)]) {
        return [tableView reloadCell:@"UISpaceCell" withModel:model withBlock:nil];
    }else if([model.type  isEqual: @(UITipsType)]){
        return [tableView reloadCell:@"UITipsCell" withModel:model withBlock:nil];
    }else if([model.type  isEqual: @(UIFiledType)]){
        return [tableView reloadCell:@"UITextFiledCell" withModel:model withBlock:nil];
    }else if([model.type  isEqual: @(UIVerificationType)]){
        return [tableView reloadCell:@"UIVerificationCodeCell" withModel:model withBlock:nil];
    }else if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"点击登录");
        }];
    }else if([model.type isEqual:@(UIForgetRegistType)]){
        return [tableView reloadCell:@"UIForgetRegistCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"%@", value);
        }];
    }else if([model.type isEqual:@(UILabelButtonType)]){
        return [tableView reloadCell:@"UILabelButtonCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"点击按钮");
        }];
        
    }
    return nil;
}

@end
