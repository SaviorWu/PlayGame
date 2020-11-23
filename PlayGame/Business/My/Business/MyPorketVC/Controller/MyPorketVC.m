//
//  MyPorketVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/23.
//

#import "MyPorketVC.h"

@interface MyPorketVC ()

@end

@implementation MyPorketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"我的钱包";
    [self addNavigationView];
    
}
- (void)loadUI{
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_cellHeight:@(20)}]];
    
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIMyPorketType)}]];

    [self.tableView reloadData];
}

- (void)registCell{
    [super registCell];
    [self.tableView registCell:@"MyPorketCell"];
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
    if ([model.type  isEqual: @(UIMyPorketType)]) {
        return [tableView reloadCell:@"MyPorketCell" withModel:model withBlock:^(id  _Nullable value) {
            NSLog(@"前往充值");
        }];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
}
@end
