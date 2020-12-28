//
//  RedBagUserCell.m
//  PlayGame
//
//  Created by admin on 2020/12/28.
//

#import "RedBagUserCell.h"

@implementation RedBagUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backView.backgroundColor = [UIColor redColor];
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 8;
    self.imgHead.layer.borderColor = UIColor.lightGrayColor.CGColor;
    self.imgHead.layer.borderWidth = 1;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(SCREEN_WIDTH, 90)];
    [path addLineToPoint:CGPointMake(SCREEN_WIDTH, 0)];
    [path addLineToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(0, 90)];
    [path addQuadCurveToPoint:CGPointMake(SCREEN_WIDTH/2, 120) controlPoint:CGPointMake(SCREEN_WIDTH/2, 120)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, 26, 26);
    layer.path = path.CGPath;
    self.backView.layer.mask = layer;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(UIBaseModel*)model{
    [self.imgHead LoadImage:model.imageName withHoderImage:[UIImage imageNamed:@"头像"] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
}
@end
