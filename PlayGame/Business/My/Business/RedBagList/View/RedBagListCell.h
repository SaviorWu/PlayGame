//
//  RedBagListCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedBagListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbRegistNum;
@property (weak, nonatomic) IBOutlet UILabel *lbMark;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;
@property (weak, nonatomic) IBOutlet UILabel *lbDesc;
@property (nonatomic, strong) success block;
@end

NS_ASSUME_NONNULL_END
