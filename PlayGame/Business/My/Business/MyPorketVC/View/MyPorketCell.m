//
//  MyPorketCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/23.
//

#import "MyPorketCell.h"

@implementation MyPorketCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.backgroundColor = [UIColor colorWithHex:MAIN_RED];
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 8;
    
    self.btnRecharge.layer.masksToBounds = YES;
    self.btnRecharge.layer.cornerRadius = 8;
}
- (IBAction)clickRecharge:(id)sender {
    if (self.block) {
        self.block(@(1));
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
    self.lbCoin.text = [UserModelManager shareInstance].userModel.allmoney.length == 0?@"0.00":[UserModelManager shareInstance].userModel.allmoney;
}
@end
