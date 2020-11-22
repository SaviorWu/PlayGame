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

//"game":3,
//"play_uid":133641597,
//            "get_time":"2020-09-17 18:54:06",
//            "serve_start_time":null,
//            "remark":"我要上星星",
//            "pay_money":"15.00",
//            "serve_time":null,
//            "uid":133646326,
//            "id":3549,
//            "order_type":1,
//            "play_price":"5.00",
//            "create_time":"2020-09-17 18:36:11",
//            "statustxt":"已完成",
//            "reads":null,
//            "gname":"王者荣耀",
//            "play_time":"2020-09-17 18:55:02",
//            "pay_time":"2020-09-17 18:47:30",
//            "serve_end_time":"2020-09-17 19:04:48",
//            "play_type":1,
//            "unit":"局",
//            "play_unit":3,
//            "play_round":3,
//            "order_num":"2009171836114223",
//            "time":"今天18:55",
//            "status":6
@end

NS_ASSUME_NONNULL_END
