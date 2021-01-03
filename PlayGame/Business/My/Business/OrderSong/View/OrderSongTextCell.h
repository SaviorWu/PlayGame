//
//  OrderSongTextCell.h
//  PlayGame
//
//  Created by FriendWu on 2021/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderSongTextCell : UITableViewCell <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbTips;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tvLeading;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tvTraling;
@property (nonatomic, strong) success block;
@end

NS_ASSUME_NONNULL_END
