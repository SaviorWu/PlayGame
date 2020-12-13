//
//  GodListCell.m
//  PlayGame
//
//  Created by FriendWu on 2020/12/8.
//

#import "GodListCell.h"

@implementation GodListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgHead.layer.masksToBounds = YES;
    self.imgHead.layer.cornerRadius = 8;
    self.lbMark1.layer.borderColor = [[UIColor colorWithHex:0x8b8b8b] CGColor];
    
    self.lbMark2.layer.borderColor = [[UIColor colorWithHex:0x8b8b8b] CGColor];
    self.lbMark3.layer.borderColor = [[UIColor colorWithHex:0x8b8b8b] CGColor];
    self.lbMark4.layer.borderColor = [[UIColor colorWithHex:0x8b8b8b] CGColor];
    
    self.lbMark1.layer.borderWidth = 1;
    self.lbMark2.layer.borderWidth = 1;
    self.lbMark3.layer.borderWidth = 1;
    self.lbMark4.layer.borderWidth = 1;
    
    self.lbMark1.layer.masksToBounds = YES;
    self.lbMark1.layer.cornerRadius = 2;
    
    self.lbMark2.layer.masksToBounds = YES;
    self.lbMark2.layer.cornerRadius = 2;
    
    self.lbMark3.layer.masksToBounds = YES;
    self.lbMark3.layer.cornerRadius = 2;
    
    self.lbMark4.layer.masksToBounds = YES;
    self.lbMark4.layer.cornerRadius = 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(GodListModel*)model
{
    self.lbMark1.hidden = YES;
    self.lbMark2.hidden = YES;
    self.lbMark3.hidden = YES;
    self.lbMark4.hidden = YES;
    
    [self.imgHead LoadImage:model.header withHoderImage:[UIImage imageNamed:@""] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
    self.lbNickName.text = model.nickname;
    self.lbSign.text = model.introduce;
    if (model.juli.length == 0) {
        self.lbLocal.text = model.city;
    }else{
        self.lbLocal.text = [NSString stringWithFormat:@"%@/%@",model.city,model.juli];
    }
    
    if (model.tags.count == 1) {
        self.lbMark1.hidden = NO;
        self.lbMark1.text = model.tags[0];
    }else if(model.tags.count == 2){
        self.lbMark1.hidden = NO;
        self.lbMark2.hidden = NO;
        self.lbMark1.text = model.tags[0];
        self.lbMark2.text = model.tags[1];
    }else if(model.tags.count == 3){
        self.lbMark1.hidden = NO;
        self.lbMark2.hidden = NO;
        self.lbMark3.hidden = NO;
        self.lbMark1.text = model.tags[0];
        self.lbMark2.text = model.tags[1];
        self.lbMark3.text = model.tags[2];
    }else if(model.tags.count > 3){
        self.lbMark1.hidden = NO;
        self.lbMark2.hidden = NO;
        self.lbMark3.hidden = NO;
        self.lbMark4.hidden = NO;
        self.lbMark1.text = model.tags[0];
        self.lbMark2.text = model.tags[1];
        self.lbMark3.text = model.tags[2];
        self.lbMark4.text = model.tags[3];
    }
}
@end
