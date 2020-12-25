//
//  RedBagCell.h
//  PlayGame
//
//  Created by admin on 2020/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedBagCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;

@end

NS_ASSUME_NONNULL_END
