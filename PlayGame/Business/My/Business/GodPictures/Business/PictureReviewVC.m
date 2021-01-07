//
//  PictureReviewVC.m
//  PlayGame
//
//  Created by admin on 2020/12/25.
//

#import "PictureReviewVC.h"
#import "EMChatViewController.h"
#import "GodDetailVC.h"
@interface PictureReviewVC ()

@end

@implementation PictureReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"大神相片";
    [self addNavigationView];
    [self addRefreshLoading];
}
- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"PicReviewCell"];
}

- (void)loadData{
    [self.tableView.mj_header beginRefreshing];
    [self showHudInView:self.view];
    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"gid":self.godID} url:@"/app/Album/showlist" callback:^(JTBaseReqModel *model) {
        if (model.code == 1){
            if (self.pageIndex == 1) {
                [self.dataArray removeAllObjects];
            }
            NSMutableArray* picArray = [[NSMutableArray alloc] init];
            for (NSDictionary* dic in model.data) {
                [picArray addObject:dic[@"img_path"]];
            }
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIGodPicReview),
                                                                 BM_cellHeight:@(SCREEN_HEIGHT - 270),
                                                                 BM_dataArray:picArray}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_cellHeight:@(75)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UITipsType),
                                                                 BM_title:@"所有照片都经过人工审核，均为大神本人相片",
                                                                 BM_TitleAlignment:@(1),
                                                                 BM_titleColor:UIColor.lightGrayColor,
                                                                 BM_titleSize:@(13),
                                                                 BM_cellHeight:@(50)}]];
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_cellHeight:@(10)}]];
            
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_title:@"发起会话",
                                                                 BM_subTitle:@"个人主页",
                                                                 BM_cellHeight:@(50),
                                                                 BM_mark:@"3",
                                                                 BM_Width:@((SCREEN_WIDTH-50)/2.f),
                                                                 BM_type:@(UIForgetRegistType)}]];
            
            [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                                 BM_cellHeight:@(30)}]];
            
            [self.tableView reloadData];
            self.pageIndex++;
        }
        [self.tableView.mj_header endRefreshing];
        [self hideAllHud];
    }];
}
- (void)loadUI{
    [self loadData];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UIBaseModel* model = self.dataArray[indexPath.row];
    if ([model.type  isEqual: @(UIGodPicReview)]) {
        return [tableView reloadCell:@"PicReviewCell" withModel:self.dataArray[indexPath.row] withBlock:^(id  _Nullable value) {

        }];
    }else if([model.type isEqual:@(UIForgetRegistType)]){
        return [tableView reloadCell:@"UIForgetRegistCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"%@", value);
            if ([value intValue] == 1) {
                EMChatViewController *vc = [[EMChatViewController alloc] initWithConversationId:self.godID type:EMConversationTypeChat createIfNotExist:YES];
                vc.vcTitle = self.nickName;
                vc.header = self.header;
                [self.navigationController pushViewController:vc animated:YES];
            }else if([value intValue] == 2){
                GodDetailVC* vc = [[GodDetailVC alloc] init];
                vc.godId = self.godID;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

@end
