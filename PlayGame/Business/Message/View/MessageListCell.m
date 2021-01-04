//
//  MessageListCell.m
//  sweatHeart
//
//  Created by 。。。。 on 2020/8/31.
//  Copyright © 2020 FriendWu. All rights reserved.
//

#import "MessageListCell.h"
static NSString *kConversation_IsRead = @"kHaveAtMessage";
static int kConversation_AtYou = 1;
static int kConversation_AtAll = 2;
@implementation MessageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.imgHeader.layer.masksToBounds = YES;
    self.imgHeader.layer.cornerRadius = 20;
    self.imgHeader.layer.borderColor = [[UIColor colorWithHex:0xe0e0e0] CGColor];
    self.imgHeader.layer.borderWidth = 1;
}
- (NSAttributedString *)_getDetailWithModel:(EMConversation *)aConversation
{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:@""];
    
    EMMessage *lastMessage = [aConversation latestMessage];
    if (!lastMessage) {
        return attributedStr;
    }
    
    NSString *latestMessageTitle = @"";
    EMMessageBody *messageBody = lastMessage.body;
    switch (messageBody.type) {
        case EMMessageBodyTypeText:
        {
            NSString *str = [EMEmojiHelper convertEmoji:((EMTextMessageBody *)messageBody).text];
            latestMessageTitle = str;
        }
            break;
        case EMMessageBodyTypeImage:
            latestMessageTitle = @"[图片]";
            break;
        case EMMessageBodyTypeVoice:
            latestMessageTitle = @"[音频]";
            break;
        case EMMessageBodyTypeLocation:
            latestMessageTitle = @"[位置]";
            break;
        case EMMessageBodyTypeVideo:
            latestMessageTitle = @"[视频]";
            break;
        case EMMessageBodyTypeFile:
            latestMessageTitle = @"[文件]";
            break;
        default:
            break;
    }
    
//    if (lastMessage.direction == EMMessageDirectionReceive) {
//        NSString *from = lastMessage.from;
//        latestMessageTitle = [NSString stringWithFormat:@"%@: %@", from, latestMessageTitle];
//    }
    
    NSDictionary *ext = aConversation.ext;
    if (ext && [ext[kConversation_IsRead] intValue] == kConversation_AtAll) {
        NSString *allMsg = @"[有全体消息]";
        latestMessageTitle = [NSString stringWithFormat:@"%@ %@", allMsg, latestMessageTitle];
        attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
        [attributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:.0 blue:.0 alpha:0.5]} range:NSMakeRange(0, allMsg.length)];
        
    } else if (ext && [ext[kConversation_IsRead] intValue] == kConversation_AtYou) {
        NSString *atStr = @"[有人@我]";
        latestMessageTitle = [NSString stringWithFormat:@"%@ %@", atStr, latestMessageTitle];
        attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
        [attributedStr setAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1.0 green:.0 blue:.0 alpha:0.5]} range:NSMakeRange(0, atStr.length)];
    } else {
        attributedStr = [[NSMutableAttributedString alloc] initWithString:latestMessageTitle];
    }
    
    return attributedStr;
}

- (NSString *)_getTimeWithModel:(EMConversation *)aConversation
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [aConversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return latestMessageTime;
}
- (void)setModel:(EMConversationModel*)model
{
    NSString* header = @"";
    NSString* nickname = @"";

    if (model.emModel.latestMessage.direction == EMMessageDirectionReceive) {
        header = model.emModel.ext[@"fromOriginalHead"];
        nickname = model.emModel.ext[@"fromName"];
        if (header.length == 0 && nickname.length == 0) {
            header = model.emModel.ext[@"toOrignalHead"];
            nickname = model.emModel.ext[@"toName"];
        }
    }else{
        header = model.emModel.ext[@"toOrignalHead"];
        nickname = model.emModel.ext[@"toName"];
    }
    [self.imgHeader LoadImage:header withHoderImage:[UIImage imageNamed:@"头像"] successBlock:^(UIImage * _Nonnull retImage) {
        
    }];
    self.lbNickName.text = nickname.length == 0?model.name:nickname;
    self.lbTime.text = [self _getTimeWithModel:model.emModel];
    self.lbMessage.attributedText = [self _getDetailWithModel:model.emModel];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
