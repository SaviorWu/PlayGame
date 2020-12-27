//
//  RedBagListCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/26.
//

#import "RedBagListCell.h"

@implementation RedBagListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 16;
    
    self.lbDesc.layer.masksToBounds = YES;
    self.lbDesc.layer.cornerRadius = 16;
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
        self.lbMark.text = model.subTitle;
    }
    if (model.dataArray) {
        self.lbRegistNum.text = [NSString stringWithFormat:@"%@人申请",model.dataArray[0]];
        self.lbMoney.text = model.dataArray[1];
    }
    self.backView.backgroundColor = [UIColor redColor];
    if ([model.mark isEqualToString:@"1"]) {
        self.lbDesc.text = @"申请领取";
        self.lbDesc.textColor = UIColor.blackColor;
        self.lbDesc.backgroundColor = [UIColor colorWithHex:0xF9B554];
    }else if ([model.mark isEqualToString:@"2"]){
        self.lbDesc.text = @"确认发送";
        self.lbDesc.textColor = UIColor.blackColor;
        self.lbDesc.backgroundColor = [UIColor colorWithHex:0xF9B554];
    }else if ([model.mark isEqualToString:@"3"]){
        self.lbDesc.text = @"已完成";
        self.lbDesc.textColor = UIColor.whiteColor;
        self.lbDesc.backgroundColor = [UIColor clearColor];
        self.backView.backgroundColor = [UIColor lightGrayColor];
    }else if ([model.mark isEqualToString:@"4"]){
        self.lbDesc.text = @"等待确认";
        self.lbDesc.textColor = UIColor.blackColor;
        self.lbDesc.backgroundColor = [UIColor colorWithHex:0xF9B554];
    }
}
@end
