//
//  UITextFiledCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextFiledCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailing;

@end

NS_ASSUME_NONNULL_END
