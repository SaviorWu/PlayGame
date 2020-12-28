//
//  RedBagModel.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RedBagUserModel : NSObject
//"uid":173661435,
//                "uname":"着急的猫咪",
//                "rpacket_s_id":2,
//                "rpacket_title":"着急的猫咪的红包",
//                "rpacket_receive_date":"2020-10-13 17:26:22",
//                "rpacket_id":3,
//                "rpacket_price":"82.11",
//                "uheader":"/upload/image/20190101/nan.jpg"
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* uname;
@property (nonatomic, strong) NSString* rpacket_s_id;
@property (nonatomic, strong) NSString* rpacket_title;
@property (nonatomic, strong) NSString* rpacket_receive_date;
@property (nonatomic, strong) NSString* rpacket_id;
@property (nonatomic, strong) NSString* rpacket_price;
@property (nonatomic, strong) NSString* uheader;
@end

@interface RedBagModel : NSObject

@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* rpacket_s_title;
@property (nonatomic, strong) NSString* rpactet_s_desc;
@property (nonatomic, strong) NSString* shenqing;
@property (nonatomic, strong) NSString* rpacket_s_uheader;
@property (nonatomic, strong) NSString* applicants_count;
@property (nonatomic, strong) NSString* rpacket_s_id;
@property (nonatomic, strong) NSString* rpacket_s_start_date;
@property (nonatomic, strong) NSString* rpacket_s_price;
@property (nonatomic, strong) NSString* rpacket_s_uname;
@property (nonatomic, strong) NSString* rpacket_s_createtime;
@property (nonatomic, strong) NSString* rpacket_s_state;
@property (nonatomic, strong) NSString* rpacket_s_end_date;

@property (nonatomic, strong) NSString* send_count;
@property (nonatomic, strong) NSMutableArray<RedBagUserModel*>* send_list;
@end


NS_ASSUME_NONNULL_END
