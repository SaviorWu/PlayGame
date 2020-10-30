//
//  LoginVC.m
//  PlayGame
//
//  Created by admin on 2020/10/30.
//

#import "LoginVC.h"
#import "UITipsCell.h"
#import "UISpaceCell.h"
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
    [self.dataArray addObject:[UIBaseModel initWithDic:@{@"type":UISpaceType,
                                                         @"cellHeight":150.0}]];
    [self.dataArray addObject:[UIBaseModel initWithDic:@{@"name":@"登录",
                                                         @"type":UITipsType}]];
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
    if (model.type == UISpaceType) {
        return [tableView reloadCell:@"UISpaceCell" withModel:model withBlock:nil];
    }else if(model.type == UITipsType){
        return [tableView reloadCell:@"UITipsCell" withModel:model withBlock:^(id value) {
            NSLog(@"点击按钮");
        }];
    }
    return nil;
}

@end
