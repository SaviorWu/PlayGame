//
//  OrderListCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface OrderListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vBack;
@property (weak, nonatomic) IBOutlet UILabel *lbStatus;
@property (weak, nonatomic) IBOutlet UILabel *lbGameTime;
@property (weak, nonatomic) IBOutlet UILabel *lbNumber;
@property (weak, nonatomic) IBOutlet UILabel *lbGameName;
- (void)setModel:(UIBaseModel*)model;
@end

NS_ASSUME_NONNULL_END
