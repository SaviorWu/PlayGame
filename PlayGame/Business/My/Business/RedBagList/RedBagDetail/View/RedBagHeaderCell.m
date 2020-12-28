//
//  RedBagHeaderCell.m
//  PlayGame
//
//  Created by admin on 2020/12/28.
//

#import "RedBagHeaderCell.h"

@implementation RedBagHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 25;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
    [self.imgHead LoadImage:model.imageName withHoderImage:[UIImage imageNamed:@"头像"] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
    self.lbTitle.text = model.title;
    self.lbSubtitle.text = model.subTitle;
    self.lbMoney.text = [NSString stringWithFormat:@"¥%.2f",[model.mark floatValue]];
}
@end
