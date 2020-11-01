//
//  UIBaseModel.h
//  PlayGame
//
//  Created by admin on 2020/10/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define BM_title @"title"
#define BM_titleSize @"titleSize"
#define BM_titleColor @"titleColor"
#define BM_subTitle @"subTitle"
#define BM_subTitleSize @"subTitleSize"
#define BM_subTitleColor @"subTitleColor"
#define BM_backColor @"backColor"
#define BM_cellHeight @"cellHeight"
#define BM_type @"type"
#define BM_leading @"leading"
#define BM_trading @"trading"
#define BM_top @"top"
#define BM_bottom @"bottom"
#define BM_dataArray @"dataArray"
#define BM_KeyBoardType @"keyboardType"
#define BM_Width @"width"
typedef enum _UIType {
    UITitleType  = 1,
    UITextType,
    UIFiledType,
    UISwitchType,
    UITipsType,
    UISpaceType,
    UIVerificationType,
    UIConfirnBtnType,
    UIForgetRegistType,
    UILabelButtonType
} UIType;


@interface UIBaseModel : NSObject
+ (instancetype)initWithDic:(NSDictionary*)dic;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSNumber* titleSize;
@property (nonatomic, strong) UIColor* titleColor;
@property (nonatomic, strong) NSString* subTitle;
@property (nonatomic, strong) NSNumber* subTitleSize;
@property (nonatomic, strong) UIColor* subTitleColor;

@property (nonatomic, strong) UIColor* backColor;
@property (nonatomic, strong) NSNumber* cellHeight;
@property (nonatomic, strong) NSNumber* type;

@property (nonatomic, strong) NSNumber* leading;
@property (nonatomic, strong) NSNumber* trading;
@property (nonatomic, strong) NSNumber* width;
@property (nonatomic, strong) NSNumber* top;
@property (nonatomic, strong) NSNumber* bottom;

@property (nonatomic, strong) NSNumber* keyboardType;
@property (nonatomic, strong) NSMutableArray* dataArray;
@end

NS_ASSUME_NONNULL_END
