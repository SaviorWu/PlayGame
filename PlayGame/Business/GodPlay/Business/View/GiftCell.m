//
//  GiftCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/12.
//

#import "GiftCell.h"

@implementation GiftCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.giftMoney.layer.masksToBounds = YES;
    self.giftMoney.layer.cornerRadius = 10;
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 15;
}

@end
