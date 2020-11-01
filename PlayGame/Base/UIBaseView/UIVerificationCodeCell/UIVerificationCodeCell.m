//
//  UIVerificationCodeCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/10/31.
//

#import "UIVerificationCodeCell.h"
#import "UIButton+countDown.h"
@implementation UIVerificationCodeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model
{
    if (model.subTitle) {
        self.textFiled.placeholder = model.subTitle;
    }else if (model.title){
        self.textFiled.text = model.title;
    }
    if (model.keyboardType){
        self.textFiled.keyboardType = [model.keyboardType intValue];
    }
    if (model.leading) {
        self.leading.constant = [model.leading floatValue];
    }
    if (model.trading) {
        self.trailing.constant = [model.trading floatValue];
    }
}
- (IBAction)clickBtn:(id)sender {
    NSLog(@"click btn");
    [self.btnVerification startWithTime:60 title:@"" countDownTitle:@"" mainColor:UIColor.whiteColor countColor:UIColor.blueColor];
}

@end
