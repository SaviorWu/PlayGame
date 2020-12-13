//
//  GodPlayerVC.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/8.
//

#import "GodPlayerVC.h"

#import "JXCategoryView.h"
#import "GodPlayerListVC.h"
@interface GodPlayerVC ()<JXCategoryViewDelegate,JXCategoryListContainerViewDelegate>
@property (nonatomic, strong) JXCategoryTitleView* categoryView;
@property (nonatomic, strong) JXCategoryListContainerView* listContainerView;
@end

@implementation GodPlayerVC
//sid=1 是英雄联盟。sid=2是和平精英。sid=3王者荣耀。sid=4绝地求生，sid=5小游戏聊天
//sid=6其他分类，

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviTitle = @"大神列表";
    [self addNavigationView];
    [self hiddenBackBtn:YES];
    self.categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, self.vwNavigation.bottom, SCREEN_WIDTH, 50)];
    self.categoryView.delegate = self;
    self.categoryView.titles = @[@"英雄联盟", @"和平精英", @"王者荣耀",@"绝地求生",@"小游戏聊天",@"其他分类"];
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
// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.categoryView.titles.count;
}
// 根据下标 index 返回对应遵守并实现 `JXCategoryListContentViewDelegate` 协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    GodPlayerListVC * vc = [[GodPlayerListVC alloc] init];
    vc.selectIdx = [NSString stringWithFormat:@"%ld",(index+1)];
    return vc;
}

@end
