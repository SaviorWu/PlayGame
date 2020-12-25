//
//  GodPictureCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/23.
//

#import "GodPictureCell.h"

@implementation GodPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgHeader.layer.masksToBounds = YES;
    self.imgHeader.layer.cornerRadius = 8;
    self.btnPay.layer.masksToBounds = YES;
    self.btnPay.layer.cornerRadius = 15;
    self.btnPay.layer.borderColor = [UIColor colorWithHex:0xEB97AD].CGColor;
    self.btnPay.layer.borderWidth = 2;
}
- (IBAction)clickBtn:(id)sender {
    if (self.block) {
        self.block(@(1));
    }
}
- (void)setModel:(UIBaseModel*)model
{
    [self.imgHeader LoadImage:model.imageName withHoderImage:[UIImage imageNamed:@"头像"] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
    self.lbNickName.text = model.title;
    self.lbInfo.text = [NSString stringWithFormat:@"一共被浏览过%@次",model.subTitle];
    self.lbPictureCount.text = [NSString stringWithFormat:@"共%@张照片",model.mark];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
