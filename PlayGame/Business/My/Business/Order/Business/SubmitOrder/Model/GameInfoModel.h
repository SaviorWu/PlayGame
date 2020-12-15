//
//  GameInfoModel.h
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GameInfoModel : NSObject
@property (nonatomic, strong) NSString* unit;
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* game_type;
@property (nonatomic, strong) NSString* gname;
@property (nonatomic, strong) NSString* game_id;
@end

@interface OrderGameModel : NSObject
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* game_type;
@property (nonatomic, strong) NSString* title;
@end
NS_ASSUME_NONNULL_END
