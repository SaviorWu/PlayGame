//
//  GodDetailHeadCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/10.
//

#import "GodDetailHeadCell.h"

@implementation GodDetailHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lbAge.layer.cornerRadius = 4;
    self.lbAge.layer.masksToBounds = YES;
    self.lbAuth.layer.cornerRadius = 4;
    self.lbAuth.layer.masksToBounds = YES;
}
- (IBAction)clickBack:(id)sender {
    if (self.block) {
        self.block(@(1));
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
    [self.imgHead LoadImage:model.imageName withHoderImage:[UIImage imageNamed:@""] successBlock:^(UIImage * _Nonnull retImage) {
//        [self sendSubviewToBack:self.imgHead];
    }];
    self.lbNickName.text = model.title;
    self.lbSign.text = model.subTitle;
    self.lbResponseRate.text = model.dataArray[0];
    self.lbLocalStatus.text = model.dataArray[1];
    self.lbAge.text = model.dataArray[2];
    self.lbAge.backgroundColor = model.backColor;
    if ([model.dataArray[3] intValue] == 1) {
        self.lbAuth.text = @"已认证";
        if (@available(iOS 13.0, *)) {
            self.lbAuth.backgroundColor = UIColor.systemIndigoColor;
        } else {
            // Fallback on earlier versions
        }
    }else{
        self.lbAuth.text = @"未认证";
        self.lbAuth.backgroundColor = UIColor.lightGrayColor;
    }
    
}
@end
