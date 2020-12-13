//
//  GodDetailHeadCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GodDetailHeadCell : UITableViewCell
@property (nonatomic, strong) success block;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UILabel *lbAge;
@property (weak, nonatomic) IBOutlet UILabel *lbAuth;
@property (weak, nonatomic) IBOutlet UILabel *lbSign;
@property (weak, nonatomic) IBOutlet UILabel *lbResponseRate;
@property (weak, nonatomic) IBOutlet UILabel *lbLocalStatus;

@end

NS_ASSUME_NONNULL_END
