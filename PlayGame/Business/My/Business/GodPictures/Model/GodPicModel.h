//
//  GodPicModel.h
//  PlayGame
//
//  Created by FriendWu on 2020/12/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GodPicModel : NSObject
//"uid":157370120,
//            "imgcount":6,
//            "nickname":"油炸小可爱",
//            "header":"/upload/image/20190101/nv.jpg",
//            "read_count":35
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* imgcount;
@property (nonatomic, strong) NSString* nickname;
@property (nonatomic, strong) NSString* header;
@property (nonatomic, strong) NSString* read_count;
@end

NS_ASSUME_NONNULL_END
