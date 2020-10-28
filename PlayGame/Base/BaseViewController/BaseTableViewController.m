//
//  BaseTableViewController.m
//  PlayGame
//
//  Created by admin on 2020/10/28.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageIndex = 1;
    self.pageSize = 10;
    self.bShowFresh = false;
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(padding);
        }];
    }];
    
    self.dataArray = [[NSMutableArray alloc] init];
    [self addRefreshLoading];
}
- (void)addRefreshLoading{
    
    @weakify(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        self.pageIndex = 1;
        [self loadData];
    }];
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        @strongify(self);
        self.pageIndex++;
        [self loadData];
    }];
}
- (void)reloadTableView
{
    if (self.bShowFresh == false) {
        self.tableView.mj_header = nil;
        self.tableView.mj_footer = nil;
    }else{
        if (self.dataArray.count != self.pageSize*self.pageIndex) {
            self.tableView.mj_footer = nil;
        }
    }
    [self.tableView reloadData];
}
- (void)loadData
{
    
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
    return [[UITableViewCell alloc] init];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
@end
