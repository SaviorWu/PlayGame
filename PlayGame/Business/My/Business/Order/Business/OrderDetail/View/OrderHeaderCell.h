//
//  OrderHeaderCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lbAge;
@property (weak, nonatomic) IBOutlet UILabel *lbScore;
@property (weak, nonatomic) IBOutlet UIImageView *imgSex;
@property (weak, nonatomic) IBOutlet UIImageView *imgFour;
@property (weak, nonatomic) IBOutlet UIImageView *imgFive;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constrantFourStartWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintFifthStartWidth;
@property (nonatomic, strong) success block;

@end

NS_ASSUME_NONNULL_END
