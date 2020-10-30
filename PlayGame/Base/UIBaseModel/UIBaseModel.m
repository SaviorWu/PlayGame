//
//  UIBaseModel.m
//  PlayGame
//
//  Created by admin on 2020/10/29.
//

#import "UIBaseModel.h"

@implementation UIBaseModel
+ (instancetype)initWithDic:(NSDictionary*)dic{
    UIBaseModel* model = [[UIBaseModel alloc] init];
    for (NSString* key in dic) {
        [model setPropertyValue:dic[key] propertyName:[NSString stringWithFormat:@"_%@",key]];
    }
    return model;
}
- (instancetype)init{
    self = [super init];
    if (self != nil) {
        self.title = @"";
        self.titleSize = 16;
        self.titleColor = UIColor.blackColor;
        self.subTitle = @"";
        self.subTitleSize = 16;
        self.subTitleColor = UIColor.blackColor;
        self.backColor = [UIColor colorWithHex:0xf8f8f8];
        self.cellHeight = @(10.0f);
        self.type = UITitleType;
        self.dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}
- (instancetype)initWithType:(UIType)type{
    self = [self init];
    if (self != nil) {
        self.type = type;
    }
    return self;
}
@end
