//
//  EMChatViewController.h
//  ChatDemo-UI3.0
//
//  Created by XieYajie on 2019/1/18.
//  Copyright © 2019 XieYajie. All rights reserved.
//

#import "EMRefreshViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class EMConversationModel;
@interface EMChatViewController : EMRefreshViewController

@property (nonatomic, assign) NSInteger direction;
@property (nonatomic, strong) NSString* vcTitle;
//@property (nonatomic, strong) NSString* from;
//@property (nonatomic, strong) NSString* to;
@property (nonatomic, strong) NSString* header;
@property (nonatomic, strong) NSString* playthisgameID;
@property (nonatomic, strong) NSString* playthisgameUsercallgodID;

@property(nonatomic, strong) UIAlertController *alertController;

- (instancetype)initWithConversationId:(NSString *)aId
                                  type:(EMConversationType)aType
                      createIfNotExist:(BOOL)aIsCreate;

- (instancetype)initWithCoversationModel:(EMConversationModel *)aModel;

@end

NS_ASSUME_NONNULL_END
