//
//  GodDetailInfoCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/12.
//

#import "GodDetailInfoCell.h"

@implementation GodDetailInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.vwBack.layer.masksToBounds = YES;
    self.vwBack.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
    self.lbNickName.text = model.title;
    self.lbSubtitle.text = model.subTitle;
}
@end
