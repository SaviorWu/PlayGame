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
//"unit":"币/小时",
//            "price":"10.00",
//            "game_type":2,
//            "gname":"自定义技能",
//            "game_id":8
@end

@interface OrderGameModel : NSObject
//"price":"10.00",
//                "game_type":2,
//                "title":"自定义技能"
@property (nonatomic, strong) NSString* price;
@property (nonatomic, strong) NSString* game_type;
@property (nonatomic, strong) NSString* title;
@end
NS_ASSUME_NONNULL_END
