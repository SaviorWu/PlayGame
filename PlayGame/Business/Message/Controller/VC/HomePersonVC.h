//
//  HomePersonVC.h
//  PlayGame
//
//  Created by admin on 2021/1/5.
//

#import "PopViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomePersonVC : PopViewController
@property (nonatomic, strong) success clickChat;
@property (nonatomic, strong) success clickGift;
@property (nonatomic, strong) success clickHeader;
@property (nonatomic, strong) UIBaseModel* uiModel;
- (void)setModel:(UIBaseModel*)model;
@end

NS_ASSUME_NONNULL_END
