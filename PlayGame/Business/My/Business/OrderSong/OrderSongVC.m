//
//  OrderSongVC.m
//  PlayGame
//
//  Created by FriendWu on 2021/1/3.
//

#import "OrderSongVC.h"
#import "GiffModel.h"
#import "GiftPickVC.h"
#import "ChoseGiftVC.h"
@interface OrderSongVC ()
@property (nonatomic, assign) NSInteger choseType;
@property (nonatomic, strong) NSMutableArray<GiffModel*>* arrayGif;
@property (nonatomic, strong) NSString* choseGiftID;
@property (nonatomic, strong) NSString* content;
@end

@implementation OrderSongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"点歌";
    self.choseType = 1;
    [self addNavigationView];
    self.arrayGif = [[NSMutableArray alloc] init];
    [self showHudInView:self.view];
    [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token}
                               url:@"/app/users/getgiftinfo"
                          callback:^(JTBaseReqModel *model) {
        
        for (NSDictionary* dic in model.data) {
            GiffModel* gM = [GiffModel mj_objectWithKeyValues:dic];
            [self.arrayGif addObject:gM];
        }
        
        [self hideAllHud];
    }];
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"UIImageLabelSelectCell"];
    [self.tableView registCell:@"UILabelContentCell"];
    [self.tableView registCell:@"OrderSongTextCell"];
    
    
}
- (void)loadUI{
    [self.dataArray removeAllObjects];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"点歌",
                                                         BM_subTitle:@"选择点歌类型",
                                                         BM_cellHeight:@(50),
                                                         BM_SubAlignment:@(3),
                                                         BM_leading:@(15),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_mark:@"2",
                                                         BM_type:@(UIImageLabelSelectType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(10),
                                                         BM_backColor:[UIColor whiteColor]}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"系统随机歌词",
                                                         BM_subTitle:@"自定义歌词",
                                                         BM_cellHeight:@(40),
                                                         BM_mark:@"4",
                                                         BM_modelId:@(self.choseType),
                                                         BM_Width:@(130),
                                                         BM_type:@(UIForgetRegistType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(10),
                                                         BM_backColor:[UIColor whiteColor]}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(10),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8]}]];
    
    if (self.choseType == 2){
        NSString* giftName = @"";
        NSString* money = @"";
        if (self.choseGiftID.length == 0) {
            self.choseGiftID = self.arrayGif[0].id;
        }
        for (GiffModel* gm in self.arrayGif) {
            if ([gm.id isEqualToString:self.choseGiftID]) {
                giftName = gm.title;
                money = gm.price;
            }
        }
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                             BM_title:giftName,
                                                             BM_modelId:self.choseGiftID,
                                                             BM_titleColor:[UIColor blackColor],
                                                             BM_cellHeight:@(50),
                                                             BM_subTitleColor:[UIColor redColor],
                                                             BM_subTitle:@" 币",
                                                             BM_mark:money}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_cellHeight:@(10),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8]}]];
        
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                             BM_title:@"支付金额",
                                                             BM_titleColor:[UIColor blackColor],
                                                             BM_cellHeight:@(50),
                                                             BM_subTitleColor:[UIColor redColor],
                                                             BM_subTitle:@"币",
                                                             BM_mark:money}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_cellHeight:@(10),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8]}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIOrderSongTextType),
                                                             BM_leading:@(15),
                                                             BM_trading:@(15)
        }]];
        
    }else{
        self.choseGiftID = @"";
        self.content = @"";
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILabelContentType),
                                                             BM_title:@"支付金额",
                                                             BM_titleColor:[UIColor blackColor],
                                                             BM_cellHeight:@(50),
                                                             BM_subTitleColor:[UIColor redColor],
                                                             BM_subTitle:@"币",
                                                             BM_mark:@"6.66"}]];
    }
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(20),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8]}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"确认发布",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_backColor:[UIColor colorWithHex:MAIN_BLUE],
                                                         BM_titleColor:UIColor.whiteColor,
                                                         BM_cellHeight:@(50),
                                                         BM_type:@(UIConfirnBtnType)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(60),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8]}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"规则玩法：系统随机歌词时默认支持支付金额系统随机生成歌词，自定义歌词时选择要支付的礼物类型并且输入歌词，然后发布。每次持续15分钟，时间即将结束时赠送礼物会延后结束时间。",
                                                         BM_titleSize:@(12),
                                                         BM_leading:@(15),
                                                         BM_trading:@(15),
                                                         BM_titleColor:[UIColor lightGrayColor],
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_type:@(UITipsType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"发布自定义歌曲后，再次进入“点歌”的“自定义歌词”界面，即可显示已演唱本歌的大神，点歌人可以选择某个大神送出自定义点歌时的礼物并结束该次点歌。",
                                                         BM_titleSize:@(12),
                                                         BM_leading:@(8),
                                                         BM_trading:@(8),
                                                         BM_titleColor:[UIColor colorWithHex:MAIN_BLUE],
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_type:@(UITipsType)}]];
    [self.tableView reloadData];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIBaseModel* uiModel = self.dataArray[indexPath.row];
    if ([uiModel.type  isEqual: @(UIImageLabelSelectType)]) {
        return [tableView reloadCell:@"UIImageLabelSelectCell" withModel:uiModel withBlock:nil];
    }else if([uiModel.type  isEqual: @(UILabelContentType)]){
        return [tableView reloadCell:@"UILabelContentCell" withModel:self.dataArray[indexPath.row] withBlock:nil];
    }else if([uiModel.type isEqual:@(UIForgetRegistType)]){
        return [tableView reloadCell:@"UIForgetRegistCell" withModel:uiModel withBlock:^(id  _Nullable value) {
            NSLog(@"%@", value);
            if ([value intValue] == 1) {
                self.choseType = 1;
                [self loadUI];
            }else if([value intValue] == 2){
                self.choseType = 2;
                [self loadUI];
            }
        }];
    }else if([uiModel.type isEqual:@(UIConfirnBtnType)]){
        return [tableView reloadCell:@"UIConfirnBtnCell" withModel:uiModel withBlock:^(id  _Nullable value) {
            if (self.choseType == 2) {
                if (self.choseGiftID.length == 0) {
                    [self showHint:@"请选择要送的礼物"];
                    return;
                }else if(self.content.length == 0){
                    [self showHint:@"请输入一句要大神演唱的歌词"];
                    return;
                }
            }
            [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,
                                             @"content":self.content.length == 0?@"":self.content,
                                             @"gift_id":self.choseGiftID.length == 0?@"":self.choseGiftID
            } url:@"/ping/qunliao/gequfabu" callback:^(JTBaseReqModel *model) {
                [self showHint:model.xx];
                if (model.zt == 1) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }];
    }else if([uiModel.type isEqual:@(UIOrderSongTextType)]){
        return [tableView reloadCell:@"OrderSongTextCell" withModel:uiModel withBlock:^(id  _Nullable value) {
            self.content = value;
        }];
    }
    else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIBaseModel* uiModel = self.dataArray[indexPath.row];
    if ([uiModel.type isEqual:@(UILabelContentType)] && uiModel.modelId.length != 0) {
        ChoseGiftVC * vc = [[ChoseGiftVC alloc] init];
        vc.arrayGift = self.arrayGif;
        vc.giftID = uiModel.modelId;
        vc.clickBtn = ^(NSString * _Nonnull str) {
            self.choseGiftID = str;
            [self loadUI];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
