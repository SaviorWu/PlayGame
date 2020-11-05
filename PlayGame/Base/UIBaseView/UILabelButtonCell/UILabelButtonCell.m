//
//  UILabelButtonCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/1.
//

#import "UILabelButtonCell.h"

@implementation UILabelButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.lbTitle.backgroundColor = [UIColor yellowColor];
//    self.button.backgroundColor = [UIColor greenColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)clickBtn:(id)sender {
    if (self.block) {
        self.block(@(1));
    }
}
- (void)setModel:(UIBaseModel*)model{
    if (model.title) {
        self.lbTitle.text = model.title;
    }
    if (model.subTitle) {
        [self.button setTitle:model.subTitle forState:UIControlStateNormal];
    }
    if (model.leading) {
        self.lbLeading.constant = model.leading.floatValue;
    }
    if (model.trading) {
        self.btnTrailing.constant = model.trading.floatValue;
    }
    if (model.width) {
        self.btnWidth.constant = model.width.floatValue;
    }
    if (model.cellHeight) {
        self.btnHeight.constant = model.cellHeight.floatValue;
    }
    if (model.titleSize) {
        self.lbTitle.font = [UIFont systemFontOfSize:model.titleSize.floatValue];
    }
    if (model.subTitleSize) {
        self.button.titleLabel.font = [UIFont systemFontOfSize:model.subTitleSize.floatValue];
    }
}
@end
