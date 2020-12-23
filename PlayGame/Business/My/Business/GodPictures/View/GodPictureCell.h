//
//  GodPictureCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GodPictureCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UILabel *lbInfo;
@property (weak, nonatomic) IBOutlet UILabel *lbPictureCount;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (nonatomic, strong) success block;
- (void)setModel:(UIBaseModel*)model;
@end

NS_ASSUME_NONNULL_END
