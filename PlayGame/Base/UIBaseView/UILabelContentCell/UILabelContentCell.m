//
//  UILabelContentCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "UILabelContentCell.h"

@implementation UILabelContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
    self.lbTitle.text = model.title;
    if (model.mark) {
        self.lbContent.text = model.mark;
    }else{
        self.lbContent.text = @"";
    }
    if (model.subTitleColor) {
        self.lbContent.textColor = model.subTitleColor;
        self.lbValue.textColor = model.subTitleColor;
    }
    if (model.titleColor) {
        self.lbTitle.textColor = model.titleColor;
    }
    self.lbValue.text = model.subTitle;
}
@end
