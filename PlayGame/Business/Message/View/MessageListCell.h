//
//  MessageListCell.h
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/31.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MessageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lbNickName;
@property (weak, nonatomic) IBOutlet UILabel *lbMessage;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;

- (void)setModel:(EMConversationModel*)model;
@end

NS_ASSUME_NONNULL_END
