//
//  MyViewController.m
//  PlayGame
//
//  Created by admin on 2020/11/6.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self hiddenNavigation];
    [self.tableView registCell:@"MyHeadNameIDCell"];
}
- (void)loadUI{
    [JTNetwork requestGetWithParam:@{@"ys":[UserModelManager shareInstance].userModel.token,@"gr":[UserModelManager shareInstance].userModel.uid} url:@"/ping/mei/grzx" callback:^(JTBaseReqModel *model) {
        
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                             BM_backColor:[UIColor colorWithHex:0x00A0EE],
                                                             BM_cellHeight:@(100)}]];
        [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UIMyHeadNameIDType),
                                                             BM_backColor:[UIColor colorWithHex:0x00A0EE],
                                                             BM_cellHeight:@(100)}]];
        
        [self.tableView reloadData];
    }];
    
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
    if([model.type  isEqual: @(UIImageLabelSelectType)]){
        return [tableView reloadCell:@"UIImageLabelSelectCell" withModel:model withBlock:nil];
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 1) {
//        self.selectGame = 1;
//    }else if (indexPath.row == 3) {
//        self.selectGame = 2;
//    }else if (indexPath.row == 5) {
//        self.selectGame = 3;
//    }else if (indexPath.row == 7) {
//        self.selectGame = 4;
//    }else if (indexPath.row == 9) {
//        self.selectGame = 5;
//    }else if (indexPath.row == 12) {
//        self.selectSex = 1;
//    }else if (indexPath.row == 14){
//        self.selectSex = 2;
//    }
    [self loadUI];
}
@end
