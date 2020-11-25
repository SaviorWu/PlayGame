//
//  RechargeVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/24.
//

#import "RechargeVC.h"
#import <StoreKit/StoreKit.h>

@interface RechargeVC ()<SKPaymentTransactionObserver,SKProductsRequestDelegate>
@property (nonatomic, assign)NSInteger selectIdx;
@property (nonatomic, strong)NSString* selectAppleGoodsID;
@property (nonatomic, strong)NSString* money;
@property (nonatomic, strong)NSString* productId;
@property(nonatomic, strong) NSString* receipt;
@end

@implementation RechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"玩币充值";
    self.selectIdx = -1;
    self.selectAppleGoodsID = @"";
    [self addNavigationView];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)loadUI{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                         BM_title:@"玩币",
                                                         BM_cellHeight:@(50),
                                                         BM_subTitle:[NSString stringWithFormat:@"%@个",[UserModelManager shareInstance].userModel.money],
                                                         BM_mark:@"余额："}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(10)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"金币",
                                                         BM_subTitle:@"¥10    ",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(2),
                                                         BM_mark:self.selectIdx == 1?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"金币",
                                                         BM_subTitle:@"¥30    ",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(2),
                                                         BM_mark:self.selectIdx == 2?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"金币",
                                                         BM_subTitle:@"¥60    ",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(2),
                                                         BM_mark:self.selectIdx == 3?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"金币",
                                                         BM_subTitle:@"¥200    ",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(2),
                                                         BM_mark:self.selectIdx == 4?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"金币",
                                                         BM_subTitle:@"¥500    ",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(2),
                                                         BM_mark:self.selectIdx == 5?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                         BM_leading:@(20),
                                                         BM_trading:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"金币",
                                                         BM_subTitle:@"¥1000    ",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(2),
                                                         BM_mark:self.selectIdx == 6?@"1":@"0",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(64)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"确认充值",
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
    if([model.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"内购");
            if (self.selectAppleGoodsID.length == 0) {
                [self showHint:@"请选择充值的金额"];
                return;
            }
            [self requestServerOrderInfo];
        }];
    }else if ([model.type  isEqual: @(UIImageLabelSelectType)]) {
        return [tableView reloadCell:@"UIImageLabelSelectCell" withModel:model withBlock:nil];
    }else if([model.type  isEqual: @(UILabelContentType)]){
        return [tableView reloadCell:@"UILabelContentCell" withModel:self.dataArray[indexPath.row] withBlock:nil];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 2) {
        self.selectIdx = 1;
        self.money = @"10";
        self.selectAppleGoodsID = @"cszs8ansfpsfelofgzek7ga3bb3e0icj";
    }else if (indexPath.row == 4) {
        self.selectIdx = 2;
        self.money = @"30";
        self.selectAppleGoodsID = @"cfhhnw0199gt8quam43i2qpli6whobvu";
    }else if (indexPath.row == 6) {
        self.selectIdx = 3;
        self.money = @"60";
        self.selectAppleGoodsID = @"x77c4ate05yzbt6f96yd8zrnxhyxl6y8";
    }else if (indexPath.row == 8) {
        self.selectIdx = 4;
        self.money = @"200";
        self.selectAppleGoodsID = @"cnw26qwdnd1qunkukzgemq3s97f2iuve";
    }else if (indexPath.row == 10) {
        self.selectIdx = 5;
        self.money = @"500";
        self.selectAppleGoodsID = @"3h693zvxyn7j0054cqz9fnqgnsjmx8ti";
    }else if (indexPath.row == 12) {
        self.selectIdx = 6;
        self.money = @"1000";
        self.selectAppleGoodsID = @"8obc7c9srmlct8atc46j0sb8m5n8jia5";
    }
    [self loadUI];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}
- (void)requestServerOrderInfo {
    self.view.userInteractionEnabled = NO;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self showHudInView:self.view];
    });
    
    [JTNetwork requestPostWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,
                                      @"sb":@"ios",
                                      @"sp":self.selectAppleGoodsID,
                                      @"rmb":self.money
    } url:@"/ping/mei/czd" callback:^(JTBaseReqModel *model) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideAllHud];
        });
        self.productId = model.sj;
        [self orderToApplePay];
    }];
}
- (void)PaySuccess{
    [self showHint:@"支付成功" delay:1.3];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)orderToApplePay{
    //是否允许内购
    if ([SKPaymentQueue canMakePayments]) {
        NSLog(@"用户允许内购");
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showHudInView:self.view];
        });
        NSArray *product = [[NSArray alloc] initWithObjects:self.selectAppleGoodsID,nil];
        NSSet *nsset = [NSSet setWithArray:product];
        
        //初始化请求
        SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
        request.delegate = self;
        
        //开始请求
        [request start];
        
    }else{
        [self showHint:@"您的手机暂时不支持苹果内购哦!" delay:1.3];
    }
}
#pragma mark - SKProductsRequestDelegate
//接收到产品的返回信息，然后用返回的商品信息进行发起购买请求
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response NS_AVAILABLE_IOS(3_0)
{
    NSArray *product = response.products;
    
    //如果服务器没有产品
    if([product count] == 0){
        [self showHint:@"没有该商品"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideAllHudFromSuperView:self.view];
        });
        
        return;
    }
    
    SKProduct *requestProduct = nil;
    for (SKProduct *pro in product) {
        
        NSLog(@"%@", [pro description]);
        NSLog(@"%@", [pro localizedTitle]);
        NSLog(@"%@", [pro localizedDescription]);
        NSLog(@"%@", [pro price]);
        NSLog(@"%@", [pro productIdentifier]);
        
        //如果后台消费条目的ID与我这里需要请求的一样（用于确保订单的正确性）
        if([pro.productIdentifier isEqualToString:self.selectAppleGoodsID]){
            requestProduct = pro;
        }
    }
    
    //发送购买请求
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:requestProduct];
    payment.applicationUsername = [NSString stringWithFormat:@"%@%@_1",[UserModelManager shareInstance].userModel.uid,self.productId];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}
#pragma mark - SKRequestDelegate
//请求失败
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self hideAllHudFromSuperView:self.view];
    });
    NSLog(@"error:%@", error);
}

//请求结束
- (void)requestDidFinish:(SKRequest *)request
{
    NSLog(@"请求结束");
}

#pragma mark - SKPaymentTransactionObserver
//监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for(SKPaymentTransaction *tran in transactions){
        switch (tran.transactionState) {
            case SKPaymentTransactionStatePurchased:
            {
                NSLog(@"交易完成");
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hideAllHudFromSuperView:self.view];
                    [self showHudInView:self.view];
                });
                
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                [self completeTransaction:tran];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品添加进列表");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"已经购买过商品");
                break;
            case SKPaymentTransactionStateFailed:
            {
                NSLog(@"交易失败");
                self.view.userInteractionEnabled = YES;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self hideAllHudFromSuperView:self.view];
                });
                
                [self showHint:@"购买失败" delay:1.3];
                [[SKPaymentQueue defaultQueue] finishTransaction:tran];
                
            }
                break;
            default:
                break;
        }
    }
}

- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receiptData = [NSData dataWithContentsOfURL:receiptURL];
    
    NSURL *url = [NSURL URLWithString:@"https://sandbox.itunes.apple.com/verifyReceipt"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
    urlRequest.HTTPMethod = @"POST";
    NSString *encodeStr = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
//    NSString *receipt1=[encodeStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//    NSString *receipt2=[receipt1 stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    _receipt = encodeStr;
    NSString *payload = [NSString stringWithFormat:@"{\"receipt-data\":\"%@\"}", _receipt];
    NSData *payloadData = [payload dataUsingEncoding:NSUTF8StringEncoding];
    urlRequest.HTTPBody = payloadData;
    
    NSData *result = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:nil];
    if (result == nil) {
        NSLog(@"验证失败");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideAllHudFromSuperView:self.view];
        });
        
        return;
    }
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"请求成功后的数据:%@",dic);
    //这里可以通过判断 state == 0 验证凭据成功，然后进入自己服务器二次验证，,也可以直接进行服务器逻辑的判断。
    //本地服务器验证成功之后别忘了 [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
    NSString *productId = transaction.payment.productIdentifier;
    NSString *applicationUsername = transaction.payment.applicationUsername;
    
    NSLog(@"applicationUsername = %@",applicationUsername);
    NSLog(@"productId = %@",productId);
    NSLog(@"transcationid = %@",transaction.transactionIdentifier);
    if (dic != nil) {
        [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,
                                         @"receipt":self.receipt
        } url:@"/ping/mei/cz" callback:^(JTBaseReqModel *model) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self hideAllHud];
            });
            [self PaySuccess];
            [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
        }];
    }
    else{
        [self hideAllHudFromSuperView:self.view];
        [self.navigationController popViewControllerAnimated:YES];
        [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    }
    
}
@end
