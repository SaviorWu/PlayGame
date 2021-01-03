//
//  OrderSongTextCell.m
//  PlayGame
//
//  Created by FriendWu on 2021/1/3.
//

#import "OrderSongTextCell.h"

@implementation OrderSongTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.textView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)textViewDidChange:(UITextView *)textView{
    if (textView.text.length == 0) {
        self.lbTips.hidden = NO;
    }else{
        self.lbTips.hidden = YES;
    }
    if (self.block) {
        self.block(textView.text);
    }
}
- (void)setModel:(UIBaseModel*)model{
    if (model.leading) {
        self.tvLeading.constant = model.leading.floatValue;
    }
    if (model.trading) {
        self.tvTraling.constant = model.trading.floatValue;
    }
}
@end
