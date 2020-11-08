//
//  MyHeadNameIDCell.m
//  PlayGame
//
//  Created by admin on 2020/11/7.
//

#import "MyHeadNameIDCell.h"

@implementation MyHeadNameIDCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model{
    if (model.title) {
        self.lbName.text = model.title;
    }
    if (model.subTitle) {
        self.lbID.text = [NSString stringWithFormat:@"ID:%@",model.subTitle];
    }
    if (model.mark) {
        [self.imgHead LoadImage:model.mark withHoderImage:[UIImage imageNamed:@"默认头像"] successBlock:^(UIImage * _Nonnull retImage) {
            NSLog(@"头像加载完成");
        }];
    }
    if (model.backColor) {
        self.contentView.backgroundColor = model.backColor;
    }
}
@end
