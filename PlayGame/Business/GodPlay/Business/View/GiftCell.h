//
//  GiftCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GiftCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *giftImg;
@property (weak, nonatomic) IBOutlet UILabel *giftName;
@property (weak, nonatomic) IBOutlet UILabel *giftMoney;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

NS_ASSUME_NONNULL_END
