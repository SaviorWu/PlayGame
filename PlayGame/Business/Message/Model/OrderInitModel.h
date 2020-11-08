#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface GamemyModel : NSObject
@property (nonatomic, strong) NSString * unit;
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * game_type;
@property (nonatomic, strong) NSString * gname;
@property (nonatomic, strong) NSString * game_id;
@end

@interface GamesModel : NSObject
@property (nonatomic, strong) NSString * price;
@property (nonatomic, strong) NSString * game_type;
@property (nonatomic, strong) NSString * title;
@end

//@interface UserModel : NSObject
//@property (nonatomic, strong) NSString * nickname;
//@property (nonatomic, strong) NSString * nick_status;
//@property (nonatomic, strong) NSString * header;
//@end
//
//@interface OrderInitModel : NSObject
//@property (nonatomic,strong) GamemyModel* gamemy;
//@property (nonatomic,strong) GamesModel* games;
//@property (nonatomic,strong) UserModel* user;
//@end

NS_ASSUME_NONNULL_END
