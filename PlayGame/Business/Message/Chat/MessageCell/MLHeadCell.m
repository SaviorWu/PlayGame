//
//  MLHeadCell.m
//  PlayGame
//
//  Created by admin on 2021/1/5.
//

#import "MLHeadCell.h"

@implementation MLHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 35.f/2.f;
    self.btnDown.layer.masksToBounds = YES;
    self.btnDown.layer.cornerRadius = 5;
    self.imgHead.layer.borderWidth = 1;
}
- (void)setModel:(MLModel* )model{
    [self.imgHead LoadImage:model.header withHoderImage:[UIImage imageNamed:@"头像"] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
    if (model.path.length != 0) {
        [self.btnDown setTitle:@"" forState:UIControlStateNormal];
        [self.btnDown setImage:[UIImage imageNamed:@"声波"] forState:UIControlStateNormal];
        self.btnDown.backgroundColor = UIColor.systemBlueColor;
        self.imgHead.layer.borderColor = UIColor.redColor.CGColor;
//        self.btnDown.currentBackgroundImage = [UIImage imageNamed:];
    }else{
        self.imgHead.layer.borderColor = UIColor.lightGrayColor.CGColor;
        [self.btnDown setImage:nil forState:UIControlStateNormal];
        [self.btnDown setTitle:model.allmoney forState:UIControlStateNormal];
        self.btnDown.backgroundColor = UIColor.systemGrayColor;
    }
    self.btnDown.titleLabel.font = [UIFont systemFontOfSize:10];
}
- (IBAction)clickBtn:(id)sender {
    if (self.block) {
        self.block();
    }
}

@end
