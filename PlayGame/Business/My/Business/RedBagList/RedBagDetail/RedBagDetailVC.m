//
//  RedBagDetailVC.m
//  PlayGame
//
//  Created by admin on 2020/12/28.
//

#import "RedBagDetailVC.h"
#import "RedBagModel.h"
@interface RedBagDetailVC ()

@end

@implementation RedBagDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"红包详情";
    [self addNavigationView];
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"RedBagUserCell"];
    [self.tableView registCell:@"RedBagHeaderCell"];
}
- (void)loadUI{
    [JTNetwork requestGetWithParam:@{@"token":[UserModelManager shareInstance].userModel.token,
                                     @"rpacket_s_id":self.redBagId}
                               url:@"/app/redpacket/redpacket_info" callback:^(JTBaseReqModel *model) {
        if (model.code == 1){
//            UIRedBagDetailHeadType,
//            UIRedBagDetailUserType
            RedBagModel* dataModel = [RedBagModel mj_objectWithKeyValues:model.data];
            dataModel.send_list = [[NSMutableArray alloc] init];
            for (NSDictionary* dic in model.data[@"send_list"]) {
                [dataModel.send_list addObject:[RedBagUserModel mj_objectWithKeyValues:dic]];
            }
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIRedBagDetailHeadType),
                                                                 BM_imageName:dataModel.rpacket_s_uheader}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_cellHeight:@(20)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:dataModel.rpacket_s_uname,
                                                                 BM_titleSize:@(17),
                                                                 BM_leading:@(20),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_TitleAlignment:@(1),
                                                                 BM_cellHeight:@(17),
                                                                 BM_type:@(UITipsType)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_cellHeight:@(15)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:dataModel.rpactet_s_desc,
                                                                 BM_TitleAlignment:@(1),
                                                                 BM_titleSize:@(17),
                                                                 BM_leading:@(20),
                                                                 BM_cellHeight:@(17),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_type:@(UITipsType)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_cellHeight:@(30)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:[NSString stringWithFormat:@"¥%@",dataModel.rpacket_s_price],
                                                                 BM_titleSize:@(20),
                                                                 BM_leading:@(20),
                                                                 BM_cellHeight:@(17),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_TitleAlignment:@(1),
                                                                 BM_type:@(UITipsType)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                                 BM_cellHeight:@(30)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor whiteColor],
                                                                 BM_cellHeight:@(10)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:[NSString stringWithFormat:@"申请人数%@个,发送%@个",dataModel.applicants_count,dataModel.send_count],
                                                                 BM_titleSize:@(17),
                                                                 BM_cellHeight:@(17),
                                                                 BM_titleColor:UIColor.lightGrayColor,
                                                                 BM_leading:@(15),
                                                                 BM_backColor:[UIColor whiteColor],
                                                                 BM_type:@(UITipsType)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_backColor:[UIColor whiteColor],
                                                                 BM_cellHeight:@(10)}]];
            
            for (RedBagUserModel* uModel in dataModel.send_list) {
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UILineType),
                                                                     BM_leading:@(0),
                                                                     BM_trading:@(0)}]];
                [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIRedBagDetailUserType),
                                                                     BM_imageName:uModel.uheader,
                                                                     BM_title:uModel.uname,
                                                                     BM_subTitle:uModel.rpacket_receive_date,
                                                                     BM_mark:uModel.rpacket_price
                }]];
            }
            [self.tableView reloadData];
            
            
        }
    }];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIBaseModel* uiModel = self.dataArray[indexPath.row];
    if ([uiModel.type  isEqual: @(UIRedBagDetailUserType)]) {
        return [tableView reloadCell:@"RedBagHeaderCell" withModel:self.dataArray[indexPath.row] withBlock:nil];
    }else if ([uiModel.type  isEqual: @(UIRedBagDetailHeadType)]) {
        return [tableView reloadCell:@"RedBagUserCell" withModel:self.dataArray[indexPath.row] withBlock:nil];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
