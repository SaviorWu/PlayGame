//
//  UserModel.h
//  PlayGame
//
//  Created by admin on 2020/11/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserBaseModel : NSObject
@property (nonatomic, strong) NSString* sex;
@property (nonatomic, strong) NSString* nickname;
@property (nonatomic, strong) NSString* header;
@property (nonatomic, strong) NSString* age;
@end

@interface UserGameModel : UserBaseModel
@property (nonatomic, strong) NSString* gid;
@end

@interface UserModel : UserBaseModel
@property (nonatomic, strong) NSString* token;
@property (nonatomic, strong) NSString* work;
@property (nonatomic, strong) NSString* birthday;
@property (nonatomic, strong) NSString* money;
@property (nonatomic, strong) NSString* introduce_status;
@property (nonatomic, strong) NSString* interest;
@property (nonatomic, strong) NSString* nick_status;
@property (nonatomic, strong) NSString* type;
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* mobile;
@property (nonatomic, strong) NSString* distance;
@property (nonatomic, strong) NSString* star;
@property (nonatomic, strong) NSString* login_status;
@property (nonatomic, strong) NSString* pay_password;
@property (nonatomic, strong) NSString* vip;
@property (nonatomic, strong) NSString* is_alert;
@end

@interface PersonalPageModel : UserModel
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* city;
@property (nonatomic, strong) NSString* jishilv;
@property (nonatomic, strong) NSString* introduce;
@property (nonatomic, strong) NSString* login_time;
@property (nonatomic, strong) NSString* fans;
@end
NS_ASSUME_NONNULL_END
