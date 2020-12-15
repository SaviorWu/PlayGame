//
//  OrderModel.h
//  PlayGame
//
//  Created by FriendWu on 2020/11/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderModel : NSObject
@property (nonatomic, strong) NSString* id;
@property (nonatomic, strong) NSString* game;
@property (nonatomic, strong) NSString* play_uid;
@property (nonatomic, strong) NSString* get_time;
@property (nonatomic, strong) NSString* play_price;
@property (nonatomic, strong) NSString* gname;
@property (nonatomic, strong) NSString* unit;
@property (nonatomic, strong) NSString* play_unit;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* play_round;
@property (nonatomic, strong) NSString* statustxt;
@property (nonatomic, strong) NSString* order_num;
@property (nonatomic, strong) NSString* pay_money;
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* commt;

@end

NS_ASSUME_NONNULL_END
