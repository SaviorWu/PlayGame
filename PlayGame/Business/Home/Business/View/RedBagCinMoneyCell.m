//
//  RedBagCinMoneyCell.m
//  PlayGame
//
//  Created by admin on 2020/12/25.
//

#import "RedBagCinMoneyCell.h"

@implementation RedBagCinMoneyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.layer.masksToBounds = YES;
    self.backView.layer.cornerRadius = 8;
    self.tfTextFiled.delegate = self;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.keyboardType == UIKeyboardTypeDecimalPad && [textField.text rangeOfString:@"."].location != NSNotFound && [string isEqualToString:@"."]) {
        return NO;
    }else if ([textField.text rangeOfString:@"."].location!=NSNotFound){
        NSRange dotRange = [textField.text rangeOfString:@"."];
        if(range.location - dotRange.location>2) {
            return NO;
        }
    }
    NSInteger strLength = textField.text.length - range.length + string.length;
    return (strLength <= 20);
}
- (void)textFieldDidChangeSelection:(UITextField *)textField{
    if (self.block) {
        self.block(@{@"key":textField.keyboardType == UIKeyboardTypeDecimalPad?@"1":@"2",@"value":textField.text});
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (self.block) {
        self.block(@{@"key":@"3",@"value":textField.text});
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
//    self.lbMoney.text = [NSString stringWithFormat:@"¥%.2f",[UserModelManager shareInstance].userModel.money.floatValue];
    if (model.title) {
        self.lbTitle.text = model.title;
    }
    if (model.subTitle) {
        self.lbUnit.text = model.subTitle;
    }
    if (model.mark) {
        self.tfTextFiled.placeholder = model.mark;
    }
    if (model.titleSize) {
        self.tfTextFiled.font = [UIFont systemFontOfSize:model.titleSize.intValue];
    }
    if ([model.keyboardType  isEqual: @(1)]) {
        self.tfTextFiled.keyboardType = UIKeyboardTypeDecimalPad;
    }else{
        self.tfTextFiled.keyboardType = UIKeyboardTypeDefault;
    }
}
@end
