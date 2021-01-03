//
//  UIForgetRegistCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/11/1.
//

#import "UIForgetRegistCell.h"

@implementation UIForgetRegistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
    if (model.title) {
        [self.btnLeft setTitle:model.title forState:UIControlStateNormal];
    }
    if (model.subTitle) {
        [self.btnRight setTitle:model.subTitle forState:UIControlStateNormal];
    }
    if ([model.mark isEqualToString:@"2"]) {
        self.constraintLeftLeading.constant = 15;
        self.constraintRightTrailing.constant = 15;
        self.btnWidth.constant = model.width.floatValue;
        self.cellHeight.constant = model.cellHeight.floatValue;
        self.btnLeft.backgroundColor = UIColor.purpleColor;
        self.btnRight.backgroundColor = UIColor.systemPinkColor;
        [self.btnLeft setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.btnRight setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.backgroundColor = UIColor.clearColor;
        self.btnLeft.layer.masksToBounds = YES;
        self.btnLeft.layer.cornerRadius = model.cellHeight.floatValue/2.f;
        self.btnRight.layer.masksToBounds = YES;
        self.btnRight.layer.cornerRadius = model.cellHeight.floatValue/2.f;
    }else if ([model.mark isEqualToString:@"3"]) {
        self.constraintLeftLeading.constant = 15;
        self.constraintRightTrailing.constant = 15;
        self.btnWidth.constant = model.width.floatValue;
        self.cellHeight.constant = model.cellHeight.floatValue;
        self.btnLeft.backgroundColor = [UIColor colorWithHex:MAIN_BLUE];
        self.btnRight.backgroundColor = [UIColor colorWithHex:MAIN_BLUE];
        self.backgroundColor = UIColor.whiteColor;
        [self.btnLeft setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.btnRight setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        self.btnLeft.layer.masksToBounds = YES;
        self.btnLeft.layer.cornerRadius = 8;
        self.btnRight.layer.masksToBounds = YES;
        self.btnRight.layer.cornerRadius = 8;
    }else if ([model.mark isEqualToString:@"4"]) {
        self.backgroundColor = UIColor.whiteColor;
        self.constraintLeftLeading.constant = 15;
        self.constraintRightTrailing.constant = SCREEN_WIDTH - 25 - model.width.floatValue*2;
        self.btnWidth.constant = model.width.floatValue;
        self.cellHeight.constant = model.cellHeight.floatValue;
        self.btnLeft.backgroundColor = [UIColor colorWithHex:MAIN_BLUE];
        self.btnRight.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = UIColor.whiteColor;
        [self.btnLeft setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [self.btnRight setTitleColor:[UIColor colorWithHex:MAIN_BLUE] forState:UIControlStateNormal];
        self.btnLeft.layer.masksToBounds = YES;
        self.btnLeft.layer.cornerRadius = model.cellHeight.floatValue/2;
        self.btnRight.layer.masksToBounds = YES;
        self.btnRight.layer.cornerRadius = model.cellHeight.floatValue/2;
        self.btnRight.layer.borderColor =  [UIColor colorWithHex:MAIN_BLUE].CGColor;
        self.btnRight.layer.borderWidth = 1;
        
        if ([model.modelId intValue] == 2){
            [self setBtnSelect:self.btnRight];
            [self setBtnUnselect:self.btnLeft];
        }else{
            [self setBtnSelect:self.btnLeft];
            [self setBtnUnselect:self.btnRight];
        }
    }
}
- (void)setBtnSelect:(UIButton*)btn{
    btn.backgroundColor = [UIColor colorWithHex:MAIN_BLUE];
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
}
- (void)setBtnUnselect:(UIButton*)btn{
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitleColor:[UIColor colorWithHex:MAIN_BLUE] forState:UIControlStateNormal];
    btn.layer.borderColor =  [UIColor colorWithHex:MAIN_BLUE].CGColor;
    btn.layer.borderWidth = 1;
}
- (IBAction)clickLeft:(id)sender {
    if (self.block) {
        self.block(@(BTN_LEFT));
    }
}
- (IBAction)clickRight:(id)sender {
    if (self.block) {
        self.block(@(BTN_RIGHT));
    }
}
@end
