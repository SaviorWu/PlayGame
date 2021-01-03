//
//  ChoseGiftVC.m
//  PlayGame
//
//  Created by FriendWu on 2021/1/3.
//

#import "ChoseGiftVC.h"

@interface ChoseGiftVC ()
//@property (nonatomic, strong) NSString* giftID;
@end

@implementation ChoseGiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"选择礼物";
    self.giftID = @"";
    [self addNavigationView];
}

- (void)loadUI{
    [self.dataArray removeAllObjects];
    for (GiffModel* model in self.arrayGift) {
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:[model.img_path substringFromIndex:17],
                                                             BM_subTitle:[NSString stringWithFormat:@"%@    ¥%@    ",model.title,model.price],
                                                             BM_cellHeight:@(50),
                                                             BM_SubAlignment:@(2),
                                                             BM_modelId:model.id,
                                                             BM_mark:[self.giftID isEqualToString:model.id] == YES?@"1":@"0",
                                                             BM_type:@(UIImageLabelSelectType)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                             BM_leading:@(20),
                                                             BM_trading:@(20)}]];
    }
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(20)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"确认",
                                                         BM_leading:@(20),
                                                         BM_trading:@(20),
                                                         BM_backColor:[UIColor colorWithHex:0x00AAFE],
                                                         BM_titleColor:UIColor.whiteColor,
                                                         BM_cellHeight:@(50),
                                                         BM_type:@(UIConfirnBtnType)}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(64)}]];
    
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
            NSLog(@"确定");
            if (self.clickBtn) {
                self.clickBtn(self.giftID);
            }
            [self.navigationController popViewControllerAnimated:YES];
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
    UIBaseModel* model = self.dataArray[indexPath.row];
    self.giftID = model.modelId;
    [self loadUI];
}

@end
