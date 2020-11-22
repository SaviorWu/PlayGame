//
//  OrderHeaderCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import "OrderHeaderCell.h"

@implementation OrderHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.lbAge.layer.masksToBounds = YES;
    self.lbAge.layer.cornerRadius = 10;
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 2;
    self.imgHead.layer.borderColor = [[UIColor colorWithHex:0xe0e0e0] CGColor];
    self.imgHead.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
    if (model) {
        [self.imgHead LoadImage:model.imageName withHoderImage:[UIImage imageNamed:@""] successBlock:^(UIImage * _Nonnull retImage) {
            
        }];

        if ([model.mark intValue] == 1) {
            [self.imgSex setImage:[UIImage imageNamed:@"女"]];
            self.lbAge.backgroundColor = [UIColor colorWithHex:MAIN_RED];
        }else{
            [self.imgSex setImage:[UIImage imageNamed:@"男"]];
            self.lbAge.backgroundColor = [UIColor colorWithHex:MAIN_BLUE];
            
        }
        self.lbNickName.text = model.title;
        self.lbAge.text = [NSString stringWithFormat:@"    %@",model.subTitle];
    }
}
- (IBAction)clickSendMsg:(id)sender {
    if (self.block) {
        self.block(@(1));
    }
}
@end
