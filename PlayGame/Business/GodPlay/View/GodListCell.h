//
//  GodListCell.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/8.
//

#import <UIKit/UIKit.h>
#import "GodListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface GodListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UILabel *lbSign;
@property (weak, nonatomic) IBOutlet UILabel *lbMark1;
@property (weak, nonatomic) IBOutlet UILabel *lbMark2;
@property (weak, nonatomic) IBOutlet UILabel *lbMark3;
@property (weak, nonatomic) IBOutlet UILabel *lbMark4;
@property (weak, nonatomic) IBOutlet UILabel *lbLocal;
- (void)setModel:(GodListModel*)model;
@end

NS_ASSUME_NONNULL_END
