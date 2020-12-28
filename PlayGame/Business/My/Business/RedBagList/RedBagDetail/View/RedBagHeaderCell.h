//
//  RedBagHeaderCell.h
//  PlayGame
//
//  Created by admin on 2020/12/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedBagHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UILabel *lbSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *lbMoney;

@end

NS_ASSUME_NONNULL_END
