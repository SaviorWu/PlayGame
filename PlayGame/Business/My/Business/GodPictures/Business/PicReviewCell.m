//
//  PicReviewCell.m
//  PlayGame
//
//  Created by admin on 2020/12/25.
//

#import "PicReviewCell.h"

@implementation PicReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.picView setUp];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(UIBaseModel*)model
{
    NSMutableArray* picArray = [[NSMutableArray alloc] init];
    // 网络图片
    for (NSString* url in model.dataArray) {
//        [picArray addObject:[NSString stringWithFormat:@"%@%@",SERVER_URL,url]];
        [picArray addObject:@"头像"];
    }
    self.height.constant = model.cellHeight.floatValue;
    [self.picView showData:picArray];
    
}
@end
