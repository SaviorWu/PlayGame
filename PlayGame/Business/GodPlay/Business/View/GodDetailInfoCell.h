//
//  GodDetailInfoCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GodDetailInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwBack;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UILabel *lbSubtitle;

@end

NS_ASSUME_NONNULL_END
