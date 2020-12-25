//
//  SearchBannerView.m
//  AZhu
//
//  Created by leiwenkai on 2018/10/26.
//  Copyright © 2018年 askzhu.com. All rights reserved.
//

#import "EBBannerView.h"
@interface EBBannerView ()
{
    UIPageControl *_page;
}
@property (nonatomic,strong)NSArray *dataArr;

@end

@implementation EBBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}
- (void)setUp:(CGRect)rect
{
//    self.adver= [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, rect.size.height) imageNamesGroup:nil];
//    self.adver.autoScrollTimeInterval = 5.0;
//    self.adver.currentPageDotColor= UIColor.whiteColor;
//    self.adver.pageDotColor= UIColor.whiteColor;
//    self.adver.showPageControl = YES;
//    self.adver.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//    self.adver.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
////    pageControl setPageIndicatorTintColor
//
//    self.adver.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    WS(weakSelf)
//    self.adver.clickItemOperationBlock =^(NSInteger currentIndex){
//        if (weakSelf.selectHomeAdverBlock!=nil) {
//            weakSelf.selectHomeAdverBlock(currentIndex);
//        } else {
//            BannerModel *model = weakSelf.dataArr[currentIndex];
//            if (model.url.length) {
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                if (model.url) {
//                    [dic setObject:model.actionUrl forKey:@"urlString"];
//                    [AZRouter openURL:kBannerActivityVCURL withUserInfo:dic completion:nil failure:nil];
//                }
//            }
//        }
//    };
//    [self addSubview:self.adver];
}
- (void)setUp {
    self.adver= [SDCycleScrollView cycleScrollViewWithFrame:self.bounds imageNamesGroup:nil];
    self.adver.autoScrollTimeInterval = 5.0;
    self.adver.backgroundColor = UIColor.whiteColor;
    self.adver.currentPageDotColor= [UIColor whiteColor];
    self.adver.pageDotColor= UIColor.redColor;
    self.adver.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.adver.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
    
    self.adver.width = SCREEN_WIDTH;
    self.adver.height = SCREEN_HEIGHT - 270;
//    WS(weakSelf)
//    self.adver.clickItemOperationBlock =^(NSInteger currentIndex){
//        if (self.selectHomeAdverBlock!=nil) {
//            self.selectHomeAdverBlock(currentIndex);
//        } else {
//            BannerModel *model = weakSelf.dataArr[currentIndex];
//            if (model.url.length) {
//                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//                if (model.url) {
//                    [dic setObject:model.actionUrl forKey:@"urlString"];
//                    [AZRouter openURL:kBannerActivityVCURL withUserInfo:dic completion:nil failure:nil];
//                }
//            }
//        }
//    };
    
    
    [self addSubview:self.adver];
}

-(void)showData:(NSArray *)data{
    self.dataArr=data;
    
    if (data.count>0) {
//        NSMutableArray *arr=[NSMutableArray new];
//        for (BannerModel *model in data) {
//            [arr addObject:[model.image stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
//        }
        self.adver.imageURLStringsGroup = data;
    }
}

-(void)adverStop{
    [self.adver invalidateTimer];
    [self.adver adjustWhenControllerViewWillAppera];
}

-(void)adverStart{
    [self.adver setupTimer];
}

@end
