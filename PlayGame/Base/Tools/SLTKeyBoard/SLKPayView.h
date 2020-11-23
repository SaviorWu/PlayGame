//
//  PCNCASPayView.h
//  Pcn
//
//  Created by macos on 2019/11/25.
//  Copyright © 2019 深圳数联通科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class SLTPayInfo;

@interface SLKPayView : UIView

-(instancetype)initWithPayInfo:(nullable SLTPayInfo *)payInfo
                        target:(id)target
            inputPwdCompleiton:(void(^)(NSString *pwdStr))completion;

-(void)show;

@end

#pragma mark - 支付信息模型
/**模型赋值样例
//单一支付无折扣
//    model.amount = @"200.00";
//    model.unit = @"CV";
//    model.purseImageStr = @"icon_cz02";
//    model.purseBalance = @"701.24";
//    model.purseName = @"CV";

//单一支付有折扣
//        model.amount = @"100.00";
//        model.unit = @"CV";
//        model.purseImageStr = @"icon_cz02";
//        model.purseBalance = @"701.24";
//        model.purseName = @"CV";
//        model.totalAmount = @"200.00";
//        model.discountStr = @"抵扣100P币";

//多种支付无折扣
//    model.amount = @"100.00";
//    model.unit = @"CV";
//    model.otherAmount = @"100.00";
//    model.otherUnit = @"P币";

//多种支付有折扣
//    model.amount = @"100.00";
//    model.unit = @"CV";
//    model.otherAmount = @"100.00";
//    model.otherUnit = @"P币";
//    model.discountStr = @"数据费100专户DOS";
*/
@interface SLTPayInfo : NSObject
/** 支付金额*/
@property (nonatomic,copy) NSString *amount;
/** 支付金额单位*/
@property (nonatomic,copy) NSString *unit;
/** 支付原始总金额（没有抵扣就不传，此金额单位和amount的Unit共用）*/
@property (nonatomic,copy) NSString *totalAmount;


/** 另一种支付金额（没有就不传）*/
@property (nonatomic,assign) NSString *otherAmount;
/** 另一种支付金额单位（没有就不传）*/
@property (nonatomic,copy) NSString *otherUnit;

/** 抵扣提示语*/
@property (nonatomic,copy) NSString *discountStr;

/** 支付钱包名称*/
@property (nonatomic,copy) NSString *purseName;
/** 支付钱包余额*/
@property (nonatomic,copy) NSString *purseBalance;
/** 支付钱包图标(网络图片和本地图片都可以)*/
@property (nonatomic,copy) NSString *purseImageStr;

@end

#pragma mark - 键盘
@interface SLTKeyboardView : UIView

@property (nonatomic,copy) void(^itemActionBlock)(UIButton *sender);

@end

#pragma mark - 密码框
typedef enum:NSUInteger {
    passShow1 = 1,//黑点,框,没间隔
    passShow2,//显示数字,框,没间隔
    passShow3,//黑点,框,有间隔
    passShow4,//显示数字,框,有间隔
    passShow5,//显示数字,下划线,一般用做验证码
} passShowType;

typedef void(^textBlock) (NSString *str);

@interface YN_PassWordView : UIView

@property(nonatomic,strong)UITextField *textF;
@property(nonatomic,strong)UIColor *tintColor;//主题色
@property(nonatomic,strong)UIColor *textColor;//字体颜色
@property(nonatomic, copy)textBlock textBlock;
@property(nonatomic,assign)passShowType showType;
@property(nonatomic,assign)NSInteger num;//格子数
-(void)show;
-(void)cleanPassword;
-(void)textFieldChanged:(NSString *)newValue;

@end

#pragma mark - 验证身份控制器
@interface SLTAuthenticateVC : UIViewController

@property (nonatomic,copy) void(^inputPwdCompleiton)(NSString *pwd);

@end
NS_ASSUME_NONNULL_END
