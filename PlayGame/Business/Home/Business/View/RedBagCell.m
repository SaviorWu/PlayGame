//
//  RedBagCell.m
//  PlayGame
//
//  Created by admin on 2020/12/25.
//

#import "RedBagCell.h"

@implementation RedBagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(UIBaseModel*)model{
    self.lbMoney.text = [NSString stringWithFormat:@"¥%.2f",[UserModelManager shareInstance].userModel.allmoney.floatValue];
}
@end
