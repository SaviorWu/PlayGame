//
//  UIBaseModel.h
//  PlayGame
//
//  Created by admin on 2020/10/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum _UIType {
    UITitleType  = 0,
    UITextType,
    UIFiledType,
    UISwitchType,
    UITipsType,
    UISpaceType
} UIType;

@interface UIBaseModel : NSObject
+ (instancetype)initWithDic:(NSDictionary*)dic;
- (instancetype)initWithType:(UIType)type;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, assign) NSInteger titleSize;
@property (nonatomic, strong) UIColor* titleColor;
@property (nonatomic, strong) NSString* subTitle;
@property (nonatomic, assign) NSInteger subTitleSize;
@property (nonatomic, strong) UIColor* subTitleColor;

@property (nonatomic, strong) UIColor* backColor;
@property (nonatomic, assign) NSNumber* cellHeight;
@property (nonatomic, assign) UIType type;
@property (nonatomic, strong) NSMutableArray* dataArray;
@end

NS_ASSUME_NONNULL_END
