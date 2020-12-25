//
//  SearchBannerView.h
//  AZhu
//
//  Created by leiwenkai on 2018/10/26.
//  Copyright © 2018年 askzhu.com. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#define kBannerHeight (Main_Screen_Width*3/7)
NS_ASSUME_NONNULL_BEGIN

@interface EBBannerView : UIView
@property (nonatomic,strong) SDCycleScrollView *adver;
///关闭
-(void)adverStop;
///开启
-(void)adverStart;
@property (nonatomic, copy) void (^selectHomeAdverBlock)(NSInteger index);
-(void)showData:(id)data;
- (void)setUp:(CGRect)rect;
- (void)setUp;
@end

NS_ASSUME_NONNULL_END
