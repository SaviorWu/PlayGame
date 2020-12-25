//
//  RedBagCinMoneyCell.h
//  PlayGame
//
//  Created by admin on 2020/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedBagCinMoneyCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbUnit;
@property (weak, nonatomic) IBOutlet UITextField *tfTextFiled;
@property (nonatomic, strong) success block;
@end

NS_ASSUME_NONNULL_END
