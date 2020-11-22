//
//  OrderListCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "OrderListCell.h"

@implementation OrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.vBack.layer.masksToBounds = YES;
    self.vBack.layer.cornerRadius = 8;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model
{
    self.lbStatus.text = model.subTitle;
    self.lbGameTime.text = model.time;
    self.lbNumber.text = [NSString stringWithFormat:@"%@%@",model.dataArray[0],model.dataArray[1]];
    self.lbGameName.text = model.title;
}
@end
