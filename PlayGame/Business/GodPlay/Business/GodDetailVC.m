//
//  GodDetailVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/10.
//

#import "GodDetailVC.h"
#import "EMChatViewController.h"
#import "GiffModel.h"
#import "GiftPickVC.h"
@interface GodDetailVC ()
@property (nonatomic, strong) PersonalPageModel* userModel;
@property (nonatomic, strong) NSMutableArray<GiffModel*>* arrayGif;
@end

@implementation GodDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenNavigation];
}
- (void)loadUI{
    [self showHudInView:self.view];
    [JTNetwork requestGetWithParam:@{@"gr":self.godId,@"ys":[UserModelManager shareInstance].userModel.token} url:@"/app/users/personal" callback:^(JTBaseReqModel *model) {
        self.userModel = [PersonalPageModel mj_objectWithKeyValues:model.data[@"userdata"]];
        [self.dataArray removeAllObjects];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_imageName:[NSString safeString:self.userModel.header],
                                                             BM_title:[NSString safeString:self.userModel.nickname],
                                                             BM_type:@(UIGodDetailHeadType),
                                                             BM_subTitle:[NSString safeString:self.userModel.introduce],
                                                             BM_backColor:([self.userModel.sex intValue] == 1?UIColor.blueColor:UIColor.redColor),
                                                             BM_dataArray:@[[NSString stringWithFormat:@"及时回复率%@",self.userModel.jishilv],[NSString stringWithFormat:@"%@ %@",[NSString safeString:self.userModel.city],[NSString safeString:self.userModel.login_time]],[NSString safeString:self.userModel.age],[NSString safeString:self.userModel.status]]
        }]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_cellHeight:@(20),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8]}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"资料",
                                                             BM_titleSize:@(17),
                                                             BM_leading:@(20),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_type:@(UITipsType)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(10)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"昵称",
                                                             BM_subTitle:[NSString safeString:self.userModel.nickname],
                                                             BM_type:@(UIGodDetailInfoType)}]];
        
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(8)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"粉丝数",
                                                             BM_subTitle:[NSString safeString:self.userModel.fans],
                                                             BM_type:@(UIGodDetailInfoType)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(8)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"互动",
                                                             BM_subTitle:@"互动值0",
                                                             BM_type:@(UIGodDetailInfoType)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(8)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"ID",
                                                             BM_subTitle:[NSString safeString:self.userModel.uid],
                                                             BM_type:@(UIGodDetailInfoType)}]];
        
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(8)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"兴趣",
                                                             BM_subTitle:[NSString safeString:self.userModel.interest],
                                                             BM_type:@(UIGodDetailInfoType)}]];
        
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(8)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"职业",
                                                             BM_subTitle:[NSString safeString:self.userModel.work],
                                                             BM_type:@(UIGodDetailInfoType)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(20)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"在线求教",
                                                             BM_subTitle:@"赠送礼物",
                                                             BM_cellHeight:@(50),
                                                             BM_mark:@"2",
                                                             BM_Width:@((SCREEN_WIDTH-130)/2.f),
                                                             BM_type:@(UIForgetRegistType)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                             BM_cellHeight:@(20)}]];
        [self.tableView reloadData];
        [self hideAllHud];
    }];
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"GodDetailHeadCell"];
    [self.tableView registCell:@"GodDetailInfoCell"];
    
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
    if([model.type  isEqual: @(UIGodDetailHeadType)]){
        return [tableView reloadCell:@"GodDetailHeadCell" withModel:model withBlock:^(id  _Nullable value) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else if([model.type  isEqual: @(UIGodDetailInfoType)]){
        return [tableView reloadCell:@"GodDetailInfoCell" withModel:model withBlock:nil];
    }else if([model.type isEqual:@(UIForgetRegistType)]){
        return [tableView reloadCell:@"UIForgetRegistCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"%@", value);
            if ([value intValue] == 1) {
                EMChatViewController *vc = [[EMChatViewController alloc] initWithConversationId:self.userModel.uid type:EMConversationTypeChat createIfNotExist:YES];
                vc.vcTitle = self.userModel.nickname;
                vc.header = self.userModel.header;
                [self.navigationController pushViewController:vc animated:YES];
            }else if([value intValue] == 2){
                if (self.arrayGif.count == 0) {
                    [self showHudInView:self.view];
                    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token}
                                               url:@"/app/users/getgiftinfo" callback:^(JTBaseReqModel *model) {
                        NSLog(@"%@",model.data);
                        self.arrayGif = [[NSMutableArray alloc] init];
                        for (NSDictionary* dic in model.data) {
                            GiffModel* gM = [GiffModel mj_objectWithKeyValues:dic];
                            [self.arrayGif addObject:gM];
                        }
                        NSLog(@"%@",self.arrayGif);
                        
                        [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"gr":[UserModelManager shareInstance].userModel.uid} url:@"/app/users/personal" callback:^(JTBaseReqModel *model) {
                            if (model.code == 1){
                                [UserModelManager shareInstance].userModel.money = model.data[@"userdata"][@"money"];
                                [UserModelManager shareInstance].userModel.nickname = model.data[@"userdata"][@"nickname"];
                                [UserModelManager shareInstance].userModel.header = model.data[@"userdata"][@"header"];
                            }
                            GiftPickVC* opVC = [[GiftPickVC alloc] init];
                            opVC.arrayGift = self.arrayGif;
                            opVC.godId = self.godId;
                            [opVC popWithAnimated:self];
                            [self presentViewController:opVC animated:YES completion:nil];
                            [self hideAllHud];
                        }];
                    }];
                }else{
                    [self showHudInView:self.view];
                    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"gr":[UserModelManager shareInstance].userModel.uid} url:@"/app/users/personal" callback:^(JTBaseReqModel *model) {
                        if (model.code == 1){
                            [UserModelManager shareInstance].userModel.money = model.data[@"userdata"][@"money"];
                            [UserModelManager shareInstance].userModel.nickname = model.data[@"userdata"][@"nickname"];
                            [UserModelManager shareInstance].userModel.header = model.data[@"userdata"][@"header"];
                        }
                        GiftPickVC* opVC = [[GiftPickVC alloc] init];
                        opVC.arrayGift = self.arrayGif;
                        opVC.godId = self.godId;
                        [opVC popWithAnimated:self];
                        [self presentViewController:opVC animated:YES completion:nil];
                        [self hideAllHud];
                    }];
                    
                }
                
            }
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
@end
