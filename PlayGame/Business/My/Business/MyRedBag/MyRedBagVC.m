//
//  MyRedBagVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/26.
//

#import "MyRedBagVC.h"
#import "JXCategoryView.h"
#import "RedBagListVC.h"
@interface MyRedBagVC ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView* categoryView;
@property (nonatomic, strong) JXCategoryListContainerView* listContainerView;
@end

@implementation MyRedBagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.naviTitle = @"我的红包";
    [self addNavigationView];
    self.view.backgroundColor = [UIColor colorWithHex:0xf8f8f8];
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, self.vwNavigation.bottom, SCREEN_WIDTH, 50)];
    self.categoryView.delegate = self;
    self.categoryView.titles = @[@"我发的红包", @"申请的红包", @"抢到的红包"];
    self.categoryView.titleColorGradientEnabled = YES;
    [self.view addSubview:self.categoryView];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = [UIColor redColor];
    lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];
    
    self.listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    self.listContainerView.frame = CGRectMake(0, self.categoryView.bottom , SCREEN_WIDTH, SCREEN_HEIGHT - self.categoryView.bottom - 44);
    [self.view addSubview:self.listContainerView];
    // 关联到 categoryView
    self.categoryView.listContainer = self.listContainerView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}
// 根据下标 index 返回对应遵守并实现 `JXCategoryListContentViewDelegate` 协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    RedBagListVC * vc = [[RedBagListVC alloc] init];
    vc.type = index + 1;
    return vc;
}
@end
