//
//  UIVerificationCodeCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIVerificationCodeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;
@property (weak, nonatomic) IBOutlet UIButton *btnVerification;
@end

NS_ASSUME_NONNULL_END
