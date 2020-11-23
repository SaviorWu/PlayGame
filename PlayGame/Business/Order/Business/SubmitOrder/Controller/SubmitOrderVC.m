//
//  SubmitOrderVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "SubmitOrderVC.h"
#import "SLKPayView.h"
#import "ChangePswdVC.h"
#import "pickerFBView.h"
@interface SubmitOrderVC ()<pickViewselectDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnSubmitOrder;
@property (weak, nonatomic) IBOutlet UIImageView *imgheader;
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UIButton *btnBuyServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbTotal;
@property (weak, nonatomic) IBOutlet UILabel *lbCost;
@property (weak, nonatomic) IBOutlet UITextField *tfRemark;
@property (weak, nonatomic) IBOutlet UILabel *lbTotalBottom;
@property (nonatomic, assign) NSInteger choseCount;
@property (nonatomic, strong) NSMutableArray* fbList;
@property (strong, nonatomic) UIAlertAction *okAction;
@property (strong, nonatomic) UIAlertAction *cancelAction;
@property (nonatomic, strong) pickerFBView* pickerView;
@end

@implementation SubmitOrderVC
-(void)pickViewdelegateWith:(NSString *_Nullable)oneStr
{
    NSLog(@"%@",oneStr);
    [self.btnBuyServiceName setTitle:oneStr forState:UIControlStateNormal];
}
- (IBAction)clickJS:(id)sender {
    if (self.choseCount <= 0) {
        return;
    }
    self.choseCount--;
    self.lbNumber.text = [NSString stringWithFormat:@"%ld",(long)self.choseCount];
    self.lbTotal.text = [NSString stringWithFormat:@"%ld",(long)self.choseCount];
    self.lbCost.text = [NSString stringWithFormat:@"%.2f币",[self.gameInfo.price doubleValue]*self.choseCount];
    self.lbTotalBottom.text = [NSString stringWithFormat:@"%.2f币",[self.gameInfo.price doubleValue]*self.choseCount];
}
- (IBAction)clickAdd:(id)sender {
    self.choseCount++;
    self.lbNumber.text = [NSString stringWithFormat:@"%ld",(long)self.choseCount];
    self.lbTotal.text = [NSString stringWithFormat:@"%ld",(long)self.choseCount];
    self.lbCost.text = [NSString stringWithFormat:@"%.2f币",[self.gameInfo.price doubleValue]*self.choseCount];
    self.lbTotalBottom.text = [NSString stringWithFormat:@"%.2f币",[self.gameInfo.price doubleValue]*self.choseCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviTitle = @"确认订单";
    [self addNavigationView];
    self.choseCount = 1;
    self.lbNumber.text = [NSString stringWithFormat:@"%ld",(long)self.choseCount];
    self.btnSubmitOrder.layer.masksToBounds = YES;
    self.btnSubmitOrder.layer.cornerRadius = 20;
    self.btnSubmitOrder.backgroundColor = [UIColor colorWithHex:MAIN_BLUE];
    
    [self.imgheader LoadImage:self.ubModel.header withHoderImage:[UIImage imageNamed:@""] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
    self.lbName.text = self.ubModel.nickname;
    self.lbMoney.text = [NSString stringWithFormat:@"%.2f%@",[self.gameInfo.price doubleValue],self.gameInfo.unit];
    OrderGameModel* model = self.gameList[0];
    [self.btnBuyServiceName setTitle:model.title forState:UIControlStateNormal];
    
    self.lbTotal.text = [NSString stringWithFormat:@"%ld",(long)self.choseCount];
    self.lbCost.text = [NSString stringWithFormat:@"%.2f币",[self.gameInfo.price doubleValue]*self.choseCount];
    self.lbTotalBottom.text = [NSString stringWithFormat:@"%.2f币",[self.gameInfo.price doubleValue]*self.choseCount];
    
    self.imgheader.layer.masksToBounds = YES;
    self.imgheader.layer.cornerRadius = 5;
    self.imgheader.layer.borderColor = [[UIColor colorWithHex:0xf8f8f8] CGColor];
    self.imgheader.layer.borderWidth = 1;
}

- (IBAction)clickChose:(id)sender {
    NSMutableArray* pickList = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.gameList.count; i++) {
        OrderGameModel* model = self.gameList[i];
        [pickList addObject:model.title];
    }
    self.pickerView = [[pickerFBView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.pickerView.delegate = self;
    self.pickerView.onePick = pickList;
    self.pickerView.oneStr = self.btnBuyServiceName.titleLabel.text;
    [self.view addSubview:self.pickerView];
}

- (IBAction)clickSubmit:(id)sender {
    if (self.choseCount <= 0) {
        [self showHint:@"请增加游戏数量" delay:1.3];
    }else if (self.godID.length == 0){
        [self showHint:@"信息异常" delay:1.3];
    }else{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        
        NSDate *date = [NSDate date];
        NSInteger interval = [date timeIntervalSinceNow] + 600;
        NSDate *localeDate = [date dateByAddingTimeInterval: interval];
        NSString *DateTime = [formatter stringFromDate:localeDate];

        if ([UserModelManager shareInstance].userModel.pay_password.length == 0) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您好，你还没有设置支付密码，是否要去设置" preferredStyle:UIAlertControllerStyleAlert];
            _okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                NSLog(@"去设置交易密码");
                ChangePswdVC* vc = [[ChangePswdVC alloc] init];
                vc.type = 3;
                [self.navigationController pushViewController:vc animated:YES];
            }];
            _cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alert addAction:_okAction];
            [alert addAction:_cancelAction];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"花费余额(%@)",self.lbTotalBottom.text] preferredStyle:UIAlertControllerStyleAlert];
            _okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
                SLKPayView *payView = [[SLKPayView alloc]initWithPayInfo:nil target:self.navigationController inputPwdCompleiton:^(NSString * _Nonnull pwdStr) {
                    [self showHudInView:self.view];
                    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,
                                                     @"yx":self.btnBuyServiceName.titleLabel.text,
                                                     @"js":@(self.choseCount),
                                                     @"ds":self.godID,
                                                     @"bz":self.tfRemark.text,
                                                     @"sj":DateTime}
                                               url:@"/ping/mei/tj" callback:^(JTBaseReqModel *model) {
                        if (model.zt == 1) {
                            [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,
                                                             @"mm":[NSString base64EncodeString:pwdStr],
                                                             @"dd":model.sj}
                                                       url:@"/ping/mei/zf" callback:^(JTBaseReqModel *model) {
                                [self hideAllHud];
                                [self showHint:model.xx];
                                if (model.zt == 1) {
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                                
                            }];
                        }else{
                            [self showHint:model.xx];
                            [self hideAllHud];
                        }
                        
                    }];
                }];
                [payView show];
            }];
            _cancelAction =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            
            [alert addAction:_okAction];
            [alert addAction:_cancelAction];
            
            // 弹出对话框
            [self presentViewController:alert animated:true completion:nil];
        }
        
//        OrderPayViewController* opVC = [[OrderPayViewController alloc] init];
//        opVC.block = ^{
//            SLKPayView *payView = [[SLKPayView alloc]initWithPayInfo:nil target:self.navigationController inputPwdCompleiton:^(NSString * _Nonnull pwdStr) {
//                // 支付接口
//                [self showHudInView:self.view];
//                [NetworkRequest GET:@"/app/order/orderSub"
//                         parameters:@{@"token":[UserInfo shareInstance].userModel.token,
//                                      @"gname":self.btnBuyServiceName.titleLabel.text,
//                                      @"number":@(self.choseCount),
//                                      @"gid":self.godID,
//                                      @"remark":self.tfRemark.text,
//                                      @"play_time":DateTime
//                         } success:^(NetWorkResponseModel * _Nullable responseModel) {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshOrderList" object:self];
//                    });
//                    [NetworkRequest GET:@"/app/order/orderPay"
//                             parameters:@{@"token":[UserInfo shareInstance].userModel.token,
//                                          @"pay_password":[PublicTool base64EncodeString:pwdStr],
//                                          @"orderid":[NSString stringWithFormat:@"%@",responseModel.data]}
//                                success:^(NetWorkResponseModel * _Nullable responseModel) {
//                        [self hideAllHudFromSuperView:self.view];
//                        [self showHint:responseModel.msg];
//                    } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
//                        [self showHint:responseModel.msg];
//                        [self hideAllHudFromSuperView:self.view];
//                        if ([responseModel.code integerValue] == -2) {
//                            [self showHint:@"账号在其他设备登录"];
//                            [UserInfo userLogout];
//                        }
//                    }];
//                } failure:^(NSError * _Nullable error, NetWorkResponseModel * _Nullable responseModel) {
//                    [self hideAllHudFromSuperView:self.view];
//                    if ([responseModel.code integerValue] == -2) {
//                        [self showHint:@"账号在其他设备登录"];
//                        [UserInfo userLogout];
//                    }
//                }];
//            }];
//            [payView show];
//        };
//        opVC.image = self.imgheader.image;
//        opVC.money = [NSString stringWithFormat:@"账户余额(%@币)",self.lbTotalBottom.text];
//        [opVC popWithAnimated:self];
//        [self presentViewController:opVC animated:YES completion:nil];
        
    }
}

@end
