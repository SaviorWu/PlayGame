
#import "TestVC.h"

@interface TestVC ()

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTitle = @"吴友鹏测试";
    [self addNavigationView];
}
- (void)loadUI{
    [self.dataArray addObject:[UIBaseModel initWithDic:@{BM_type:@(UISpaceType),
                                                         BM_backColor:[UIColor colorWithHex:0xf8f8f8],
                                                         BM_cellHeight:@(10)}]];
    [self.tableView reloadData];
}
@end
