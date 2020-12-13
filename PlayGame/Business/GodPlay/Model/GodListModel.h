//
//  GodListModel.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GodListModel : NSObject

//            "code":20,
//            "create_time":"2020-11-18 12:32:11",
//            "distance":1,
//            "Alength":null,
//            "city":"重庆",
//            "introduce":"牛哔",
//            "sex":1,
//            "price_text":"10.00币/小时",
//            "yaxis":"29.5892760",
//            "login_status":-1,
//            "uid":133655550,
//            "xaxis":"106.5286670",
//            "login_time":"在线",
//            "price":"10.00",
//            "nickname":"伞兵一号",
//            "nick_status":1,
//            "header":"/upload/image/20201120/6642f11dd89fd15be6fb2c838e311ba2.jpg",
//            "tag_id":"[
//                \"28\",
//                \"\"
//            ]",
//            "juli":"小于5Km",
//            "audio":null,
//            "tag":"[
//                \"微信区\"
//            ]",
//            "introduce_status":1
@property (nonatomic, strong) NSString* nickname;
@property (nonatomic, strong) NSString* introduce;
@property (nonatomic, strong) NSString* distance;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* juli;
@property (nonatomic, strong) NSString* header;
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* price_text;
@property (nonatomic, strong) NSArray* tags;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
//@property (nonatomic, strong) NSString* ;
@end

NS_ASSUME_NONNULL_END
