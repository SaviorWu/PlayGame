//
//  MyPorketCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/11/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyPorketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *btnRecharge;
@property (weak, nonatomic) IBOutlet UILabel *lbCoin;
@property (nonatomic, strong) success block;
@end

NS_ASSUME_NONNULL_END
