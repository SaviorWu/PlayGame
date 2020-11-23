//
//  PCNCASPayView.m
//  Pcn
//
//  Created by macos on 2019/11/25.
//  Copyright © 2019 深圳数联通科技有限公司. All rights reserved.
//

#define kTabbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) // 适配iPhone x 底栏高度
#define kNavibarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?88:64) // 适配iPhone x 导航栏栏高度
/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
/***  颜色*/
#define kRGBAColor(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]

#define kRGBFrom16Hex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 blue:((float)(rgbValue & 0x0000FF))/255.0 alpha:1.0]
/***  普通字体 */
#define kFont(size) [UIFont systemFontOfSize:size]
/***  常用字体*/
#define kCommonFont      kFont(16)
#define kCommonBigFont   kFont(18)
/** 通用黑色背景色*/
#define kblackBackgroundColor kRGBAColor(53.0,53.0,53.0)
/** 通用灰色背景色*/
#define kgrayBackgroundColor kRGBAColor(174, 174, 174)
/** cell分割线*/
#define ktableViewSeparatorColor kRGBFrom16Hex(0xe1e1e1)
/***  弱指针*/
#define WeakSelf(weakSelf)      __weak __typeof(&*self)weakSelf = self;


#import "SLKPayView.h"

@interface SLKPayView()

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) YN_PassWordView *pwdView;

@property (nonatomic,strong) SLTKeyboardView *keyBoardView;

@property (nonatomic,strong) UILabel *amountLabel;

@property (nonatomic,strong) UILabel *totalAmountLabel;

@property (nonatomic,strong) UILabel *discountLabel;

@property (nonatomic,strong) UILabel *purseBalanceLabel;

@property (nonatomic,strong) UIView *backView;

@property (nonatomic,strong) UITapGestureRecognizer *backTap;

@property (nonatomic,copy) void(^inputPwdCompleiton)(NSString *pwd);

@property (nonatomic,strong) SLTPayInfo *payInfo;

@property (nonatomic,strong) id target;
@end

@implementation SLKPayView

#pragma mark - Show&Hide
-(void)show{
    if([self.target isKindOfClass:[UINavigationController class]]){
        SLTAuthenticateVC *authVC = [SLTAuthenticateVC new];
        authVC.inputPwdCompleiton = self.inputPwdCompleiton;
        UINavigationController *navi = (UINavigationController *)self.target;
        [navi pushViewController:authVC animated:YES];
    }else if ([self.target isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)self.target;
        
        UIView *view = vc.view;
        [view addSubview:self];
        
        self.contentView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        self.keyBoardView.frame = CGRectMake(self.keyBoardView.frame.origin.x, kScreenHeight, self.keyBoardView.frame.size.width, self.keyBoardView.frame.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            self.keyBoardView.frame = CGRectMake(self.keyBoardView.frame.origin.x, kScreenHeight-self.keyBoardView.frame.size.height, self.keyBoardView.frame.size.width, self.keyBoardView.frame.size.height);
        } completion:^(BOOL finished) {

        }];
    }
}
-(void)hide{
    
    [UIView animateWithDuration:0.2 animations:^{

        self.contentView.transform = CGAffineTransformMakeScale(0.0, 0.0);
        self.keyBoardView.frame = CGRectMake(self.keyBoardView.frame.origin.x, kScreenHeight, self.keyBoardView.frame.size.width, self.keyBoardView.frame.size.height);
        self.contentView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - Action
//-(void)tapBackView{
//    [self hide];
//}
-(void)itemAction:(UIButton *)sender{
    NSMutableString *oldStr = [NSMutableString stringWithString:self.pwdView.textF.text];
    NSString *newStr = @"";
    if (sender.tag == 11) {
        //删除
        if (oldStr.length>1) {
            newStr = [oldStr substringToIndex:(oldStr.length-1)];
        }else{
            newStr = [oldStr substringToIndex:0];
        }
    }else if (sender.tag == 9){
        //取消
        [self hide];
    }else{
        NSInteger realValue = sender.tag;
        if (sender.tag == 10) {
            realValue = 0;
        }
        [oldStr appendString:sender.currentTitle];
        newStr = oldStr;
    }
    [self.pwdView textFieldChanged:newStr];
}
-(void)cancelAction:(UIButton *)sender{
    [self hide];
}

#pragma mark - init
-(instancetype)initWithPayInfo:(SLTPayInfo *)payInfo
                        target:(id)target
            inputPwdCompleiton:(void(^)(NSString *pwdStr))completion{
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    if (self) {
        self.payInfo = payInfo;
        self.inputPwdCompleiton = completion;
        self.target = target;
        if (![self.target isMemberOfClass:[UINavigationController class]]) {
            self.backgroundColor = [UIColor clearColor];
            
            _backView = [[UIView alloc]initWithFrame:self.bounds];
            _backView.backgroundColor = kRGBAColor(40, 40, 40);
            _backView.alpha = 0.6;
            [self addSubview:_backView];
            
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBackView)];
//            [_backView addGestureRecognizer:tap];
//            self.backTap = tap;
            if(payInfo!=nil){
                [self initContentViewWithModel:payInfo];
            }
            
            self.keyBoardView = [SLTKeyboardView new];
            WeakSelf(ws);
            _keyBoardView.itemActionBlock = ^(UIButton * _Nonnull sender) {
                [ws itemAction:sender];
            };
            [self addSubview:_keyBoardView];
        }
    }
    return self;
}
-(void)initContentViewWithModel:(SLTPayInfo *)model{
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width - 30, 100)];
    _contentView.layer.cornerRadius = 5;
    _contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 50)];
    _titleLabel.font = kCommonFont;
    _titleLabel.textColor = kblackBackgroundColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"请输入支付密码";
    [self.contentView addSubview:_titleLabel];
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    [cancelButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [cancelButton setTitleColor:kgrayBackgroundColor forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:cancelButton];
    
    self.amountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleLabel.frame)+30, 0, 0)];
    _amountLabel.font = [UIFont boldSystemFontOfSize:30];
    _amountLabel.textColor = kblackBackgroundColor;
    _amountLabel.numberOfLines = 0;
    _amountLabel.textAlignment = NSTextAlignmentCenter;
    _amountLabel.text = [NSString stringWithFormat:@"%@%@",model.amount,model.unit];
    if (model.otherAmount && model.otherUnit) {
        _amountLabel.text = [NSString stringWithFormat:@"%@%@+%@%@",model.amount,model.unit,model.otherAmount,model.otherUnit];
    }
    CGFloat maxWidth = self.contentView.frame.size.width-50;
    CGFloat amountHeight = [self getLabelHeight:_amountLabel maxWidth:maxWidth];
    if (amountHeight<40) {
        maxWidth = [self getLabelWidth:_amountLabel maxHight:amountHeight];
    }
    _amountLabel.frame = CGRectMake((self.contentView.frame.size.width-maxWidth)/2.0, _amountLabel.frame.origin.y, maxWidth, amountHeight);
    [self.contentView addSubview:_amountLabel];
    
    if (model.totalAmount) {
        self.totalAmountLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_amountLabel.frame)+10, self.amountLabel.frame.origin.y, 0, 0)];
        _totalAmountLabel.font = kFont(14);
        _totalAmountLabel.textColor = kgrayBackgroundColor;
        _totalAmountLabel.text = [NSString stringWithFormat:@"%@%@",model.totalAmount,model.unit];
        [_totalAmountLabel sizeToFit];
        _totalAmountLabel.frame = CGRectMake(_totalAmountLabel.frame.origin.x, CGRectGetMaxY(_amountLabel.frame)-_totalAmountLabel.frame.size.height, _totalAmountLabel.frame.size.width, _totalAmountLabel.frame.size.height);
        [self.contentView addSubview:_totalAmountLabel];
    }
    
    if (model.discountStr) {
        self.discountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_amountLabel.frame)+10, self.contentView.frame.size.width, 15)];
        _discountLabel.font = kFont(14);
        _discountLabel.textColor = [UIColor redColor];
        _discountLabel.textAlignment = NSTextAlignmentCenter;
        _discountLabel.text = model.discountStr;
        [self.contentView addSubview:_discountLabel];
    }
    
    CGFloat nextY = CGRectGetMaxY(_amountLabel.frame)+45;
    if (model.discountStr) {
        nextY = CGRectGetMaxY(_discountLabel.frame)+40;
    }
    if (!model.otherAmount) {
        UIImageView *purseIcon = [[UIImageView alloc]initWithFrame:CGRectMake(20, nextY, 35, 35)];
        purseIcon.backgroundColor = ktableViewSeparatorColor;
        if ([model.purseImageStr hasPrefix:@"http://"] || [model.purseImageStr hasPrefix:@"https://"]) {
            dispatch_async(dispatch_queue_create(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *image = [[UIImage alloc]initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:model.purseImageStr]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    purseIcon.image = image;
                });
            });
        }else{
            purseIcon.image = [UIImage imageNamed:model.purseImageStr];
        }
        [self.contentView addSubview:purseIcon];
        //
        self.purseBalanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(purseIcon.frame)+10, purseIcon.frame.origin.y, self.contentView.frame.size.width-20-10-CGRectGetMaxX(purseIcon.frame), purseIcon.frame.size.height)];
        _purseBalanceLabel.textColor = kgrayBackgroundColor;
        _purseBalanceLabel.font = kFont(16);
        NSString *balanceStr = [NSString stringWithFormat:@"%@（可用余额：%@）",model.purseName,model.purseBalance];
        NSRange range = [balanceStr rangeOfString:model.purseName];
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:balanceStr];
        [att addAttribute:NSForegroundColorAttributeName value:kblackBackgroundColor range:range];
        _purseBalanceLabel.attributedText = att;
        [self.contentView addSubview:_purseBalanceLabel];
        //
        nextY = CGRectGetMaxY(purseIcon.frame)+30;
    }
    
    YN_PassWordView *pwdView = [[YN_PassWordView alloc]initWithFrame:CGRectMake(20, nextY, self.contentView.frame.size.width-20*2, 50)];
    pwdView.showType = 1;
    pwdView.num = 6;
    pwdView.tintColor = ktableViewSeparatorColor;
    WeakSelf(ws);
    pwdView.textBlock = ^(NSString *str) {
        if (ws.inputPwdCompleiton) {
            ws.inputPwdCompleiton(str);
        }
        [ws hide];
    };
    self.pwdView = pwdView;
    [pwdView show];
    [self.contentView addSubview:pwdView];
    
    CGFloat maxY = CGRectGetMaxY(pwdView.frame)+25;
    
    self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, (kScreenHeight-240-maxY)/2.0, self.contentView.frame.size.width, maxY);
    //
    UIViewController *vc = (UIViewController *)self.target;
    if (vc.navigationController) {
        self.contentView.frame = CGRectMake(self.contentView.frame.origin.x, (kScreenHeight-240-maxY-kNavibarHeight)/2.0+kNavibarHeight, self.contentView.frame.size.width, maxY);
    }
}
#pragma mark - Tool
-(CGFloat)getLabelWidth:(UILabel *)label maxHight:(CGFloat)maxHight{
    
    CGRect frame = CGRectMake(0, 0, 0, 0);
    
    if ([label isKindOfClass:[UILabel class]]) {
        
        //计算自适应高度
        CGRect rect = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, maxHight)
                                               options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:label.font}
                                               context:nil];
        
        frame = CGRectMake(0, 0, rect.size.width, maxHight);
    }
    
    return frame.size.width;
}
-(CGFloat)getLabelHeight:(UILabel *)label maxWidth:(CGFloat)maxWidth{
    
    CGRect frame = CGRectMake(0, 0, 0, 0);
    
    if ([label isKindOfClass:[UILabel class]]) {
        
        label.numberOfLines = 0;//无限行
        CGRect rect = [label.text boundingRectWithSize:CGSizeMake(maxWidth,MAXFLOAT)
                                               options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                            attributes:@{NSFontAttributeName:label.font}
                                               context:nil];
        
        frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
    }
    return frame.size.height;
}
@end
#pragma mark -
#pragma mark - 支付信息模型
@implementation SLTPayInfo

@end

#pragma mark -
#pragma mark - 键盘
@implementation SLTKeyboardView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kScreenHeight-240, kScreenWidth, 240);
        self.backgroundColor = [UIColor whiteColor];
        CGFloat itemWidth = self.frame.size.width/3.0;
        CGFloat itemHeight = self.frame.size.height/4;
        for (NSInteger i=0; i<4; i++) {
            for (NSInteger j=0; j<3; j++) {
                UIButton *item = [[UIButton alloc]initWithFrame:CGRectMake(itemWidth*j, itemHeight*i, itemWidth, itemHeight)];
                NSInteger tag = i*3+j;
                item.tag = tag;
                [item setBackgroundImage:[self imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
                item.titleLabel.font = kFont(24);
                [item setBackgroundImage:[self imageWithColor:kRGBAColor(228, 228, 228)] forState:UIControlStateSelected];
                [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [item addTarget:self action:@selector(itemAction:) forControlEvents:UIControlEventTouchUpInside];
                if (tag == 9) {
                    item.titleLabel.font = kCommonBigFont;
                    [item setTitle:@"取消" forState:UIControlStateNormal];
                }else if (tag == 10){
                    [item setTitle:@"0" forState:UIControlStateNormal];
                }else if (tag == 11){
                    [item setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
                }else{
                    [item setTitle:@(tag+1).stringValue forState:UIControlStateNormal];
                }
                [self addSubview:item];
                //
                if (i == 3 && j<2) {
                    UIView *verLine = [[UIView alloc]initWithFrame:CGRectMake((j+1)*itemWidth, 0, 0.5, self.frame.size.height)];
                    verLine.backgroundColor = ktableViewSeparatorColor;
                    [self addSubview:verLine];
                }
            }
            UIView *verLine = [[UIView alloc]initWithFrame:CGRectMake(0, i*itemHeight, self.frame.size.width, 0.5)];
            verLine.backgroundColor = ktableViewSeparatorColor;
            [self addSubview:verLine];
        }
        //分割线
        for (NSInteger i=0; i<4; i++) {
            //
            if (i<2) {
                UIView *verLine = [[UIView alloc]initWithFrame:CGRectMake((i+1)*itemWidth, 0, 0.5, self.frame.size.height)];
                verLine.backgroundColor = ktableViewSeparatorColor;
                [self addSubview:verLine];
            }
            UIView *horLine = [[UIView alloc]initWithFrame:CGRectMake(0, i*itemHeight, self.frame.size.width, 0.5)];
            horLine.backgroundColor = ktableViewSeparatorColor;
            [self addSubview:horLine];
        }
    }
    return self;
}
- (UIImage *)imageWithColor:(UIColor *)color {

    //描述一个矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);

    //获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    //使用color演示填充上下文
    CGContextSetFillColorWithColor(ctx, [color CGColor]);

    //渲染上下文
    CGContextFillRect(ctx, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
    
}
-(void)itemAction:(UIButton *)sender{
    if (self.itemActionBlock) {
        self.itemActionBlock(sender);
    }
}
@end


#pragma mark -
#pragma mark - 密码框
#define kDotSize CGSizeMake (10, 10) //密码点的大小
#define K_Field_Height self.frame.size.height  //每一个输入框的高度等于当前view的高度
@interface YN_PassWordView()<UITextFieldDelegate>

@property(nonatomic,strong)NSMutableArray *dotArr;//黑点
@property(nonatomic,strong)NSMutableArray *bottomLineArr;//下划线
@property(nonatomic,strong)NSMutableArray *codeLArr;//Lable
@end

@implementation YN_PassWordView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}
-(void)configUI{
    self.backgroundColor = [UIColor whiteColor];
    self.bottomLineArr= @[].mutableCopy;
    self.dotArr = @[].mutableCopy;
    self.codeLArr = @[].mutableCopy;
 
    
    [self.bottomLineArr removeAllObjects];
    [self.dotArr removeAllObjects];
    [self.codeLArr removeAllObjects];

    
//    passShow1,//黑点,框,没间隔
//    passShow2,//显示数字,框,没间隔
//    passShow3,//黑点,框,有间隔
//    passShow4,//显示数字,框,有间隔
//    passShow5,//显示数字,下划线,一般用做验证码
    
    if (self.showType == passShow1) {
        [self initShow1];
    }else if(self.showType == passShow2){
        [self initShow2];
        
    }else if(self.showType == passShow3){
        [self initShow3];
        
    }else if(self.showType == passShow4){
        [self initShow4];
        
    }else if(self.showType == passShow5){
        [self initShow5];
        
    }
    
}

//    passShow1,//黑点,框,没间隔
-(void)initShow1{
    CGFloat width = self.frame.size.width/self.num;
    
    for (int i = 0; i< self.num -1; i++) {
            UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame)+(i+1)*width, 0, 1,K_Field_Height)];
            lineV.backgroundColor = self.tintColor;
            [self addSubview:lineV];
    }
    
    self.dotArr = @[].mutableCopy;
    for (int i=0; i<self.num; i++) {
        UIView *dotView =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame) + (width - self.num) / 2 + i * width, CGRectGetMinY(self.textF.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width/2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES;
        [self addSubview:dotView];
        [self.dotArr addObject:dotView];
    }
    _textF.layer.borderColor = self.tintColor.CGColor;
    _textF.layer.borderWidth = 1;
    _textF.layer.masksToBounds = YES;
    
}
//    passShow2,//显示数字,框,没间隔
-(void)initShow2{
    CGFloat width = self.frame.size.width/self.num;
    
    for (int i = 0; i< self.num -1; i++) {
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame)+(i+1)*width, 0, 1,K_Field_Height)];
        lineV.backgroundColor = self.tintColor;
        [self addSubview:lineV];
    }
    
    for (int i=0; i<self.num; i++) {
        UILabel *codeL =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame) + (i)*width+1, 1, width-2, self.frame.size.height-2)];
        codeL.backgroundColor = [UIColor clearColor];
        codeL.layer.borderColor = [UIColor whiteColor].CGColor;
        codeL.layer.borderWidth = 1.f;
        codeL.textColor = self.textColor;
        codeL.hidden = YES;
        codeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:codeL];
        [self.codeLArr addObject:codeL];
    }
    
    _textF.layer.borderColor = self.tintColor.CGColor;
    _textF.layer.borderWidth = 1;
    _textF.layer.masksToBounds = YES;
}

//    passShow3,//黑点,框,有间隔
-(void)initShow3{
    CGFloat f = 10; //设置格子间隔
    
    CGFloat width = ((self.frame.size.width-(self.num-1)*f)/self.num);
    
    for (int i=0; i<self.num; i++) {
        UILabel *codeL =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame) + (i)*(width+f), 0, width, self.frame.size.height)];
        codeL.backgroundColor = [UIColor whiteColor];
        codeL.layer.borderColor= self.tintColor.CGColor;
        codeL.textColor = self.textColor;
        codeL.layer.borderWidth = 1.;
        codeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:codeL];
        [self.codeLArr addObject:codeL];
    }
    
    for (int i=0; i<self.num; i++) {
        UIView *dotView =[[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame) + i * (width+f) +(width- kDotSize.width)/2, CGRectGetMinY(self.textF.frame) + (K_Field_Height - kDotSize.height) / 2, kDotSize.width, kDotSize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = kDotSize.width/2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES;
        [self addSubview:dotView];
        [self.dotArr addObject:dotView];
    }
}
////    passShow4,//显示数字,框,有间隔
-(void)initShow4{
    CGFloat f = 10; //设置格子间隔
    CGFloat width = ((self.frame.size.width-(self.num-1)*f)/self.num);
    for (int i=0; i<self.num; i++) {
        UILabel *codeL =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame) + (i)*(width+f), 0, width, self.frame.size.height)];
        codeL.backgroundColor = [UIColor whiteColor];
        codeL.layer.borderColor= self.tintColor.CGColor;
        codeL.textColor = self.textColor;
        codeL.layer.borderWidth = 1.;
        codeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:codeL];
        [self.codeLArr addObject:codeL];
    }
    
}

//    passShow5,//显示数字,下划线,一般用做验证码
-(void)initShow5{
        CGFloat f = 10; //设置间隔
     CGFloat width = ((self.frame.size.width-(self.num-1)*f)/self.num);
    
    for (int i =0; i<self.num; i++) {
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame) + (i)*(width+f), K_Field_Height-1,width,1)];
        lineV.backgroundColor = [UIColor grayColor];//原始线的颜色
        [self addSubview:lineV];
        [self.bottomLineArr addObject:lineV];
        
    }
    
    for (int i=0; i<self.num; i++) {
        UILabel *codeL =[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textF.frame) + (i)*(width+f), 0, width, K_Field_Height-1)];
        codeL.backgroundColor = [UIColor whiteColor];
        codeL.textColor = self.textColor;
        codeL.hidden = YES;
        codeL.textAlignment = NSTextAlignmentCenter;
        [self addSubview:codeL];
        [self.codeLArr addObject:codeL];
    }
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }else if(string.length == 0){
        return YES;
    }else if(textField.text.length >= self.num){
        return NO;
    }else{
        return YES;
    }
}
-(void)cleanPassword{
    self.textF.text = @"";

    [self textFieldDidChange:self.textF];


}
-(void)textFieldChanged:(NSString *)newValue{
    self.textF.text = newValue;
    [self textFieldDidChange:self.textF];
}
- (void)textFieldDidChange:(UITextField *)textField
{
    switch (_showType) {
        case 1:
        {
            for (UIView *dotView in self.dotArr) {
                dotView.hidden = YES;
            }
            
            for (int i = 0; i < textField.text.length; i++) {
                ((UIView *)[self.dotArr objectAtIndex:i]).hidden = NO;
            }
        }
            break;
        case 2:{
            for (UILabel *codeL in self.codeLArr) {
                codeL.hidden = YES;
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UILabel *)[self.codeLArr objectAtIndex:i]).hidden = NO;
                ((UILabel *)[self.codeLArr objectAtIndex:i]).text =[textField.text substringWithRange:NSMakeRange(i, 1)];
            }
        }
            break;
        case 3:{
            for (UIView *dotView in self.dotArr) {
                dotView.hidden = YES;
            }
            
            for (int i = 0; i < textField.text.length; i++) {
                ((UIView *)[self.dotArr objectAtIndex:i]).hidden = NO;
            }
            
        }
            break;
        case 4:{
            
            for (UILabel *codeL in self.codeLArr) {
                codeL.text = @"";
                
            }
          for (int i = 0; i < textField.text.length; i++) {
                ((UILabel *)[self.codeLArr objectAtIndex:i]).hidden = NO;
                ((UILabel *)[self.codeLArr objectAtIndex:i]).text =[textField.text substringWithRange:NSMakeRange(i, 1)];
            }
        }
            break;
        case 5:{
            for (UILabel *codeL in self.codeLArr) {
                codeL.hidden = YES;
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UILabel *)[self.codeLArr objectAtIndex:i]).hidden = NO;
                ((UILabel *)[self.codeLArr objectAtIndex:i]).text =[textField.text substringWithRange:NSMakeRange(i, 1)];
            }
            
            for (UIView *lineV in self.bottomLineArr) {
                lineV.backgroundColor = [UIColor grayColor];
            }
            for (int i = 0; i < textField.text.length; i++) {
                ((UIView *)[self.bottomLineArr objectAtIndex:i]).backgroundColor = self.tintColor;
            }
        }
            break;
        default:
            break;
    }

    if (textField.text.length == self.num) {
        if (_textBlock) {
            self.textBlock(textField.text);
        }
        
    }
    

}

-(UITextField *)textF{
    if (!_textF) {
        _textF = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, K_Field_Height)];
        _textF.backgroundColor = [UIColor whiteColor];
        //输入的文字颜色为白色
        _textF.textColor = [UIColor whiteColor];
        //输入框光标的颜色为白色
        _textF.tintColor = [UIColor whiteColor];
        _textF.delegate = self;
        _textF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textF.keyboardType = UIKeyboardTypeNumberPad;
        [_textF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:_textF];
    }
     return _textF;

}


- (void)setNum:(NSInteger)num{
    _num = num;
}

-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
}
-(void)setShowType:(passShowType)showType{
    _showType = showType;
}
-(void)setTintColor:(UIColor *)tintColor{
    _tintColor = tintColor;
}
-(void)show{
    if(_textColor == nil){
        _textColor = [UIColor blackColor];
    }
    if (!_showType) {
        _showType = passShow1;
    }
    if(_tintColor == nil){
        _tintColor = [UIColor blackColor];
    }
    if(!_num ){
        _num =6;//默认
    }
    [self configUI];
    
}
@end

#pragma mark -
#pragma mark - 验证身份控制器
@interface SLTAuthenticateVC()

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) YN_PassWordView *pwdView;

@property (nonatomic,strong) SLTKeyboardView *keyBoardView;

@end

@implementation SLTAuthenticateVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.keyBoardView = [SLTKeyboardView new];
    WeakSelf(ws);
    _keyBoardView.itemActionBlock = ^(UIButton * _Nonnull sender) {
        [ws itemAction:sender];
    };
    [self.view addSubview:_keyBoardView];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (kScreenHeight-_keyBoardView.frame.size.height-kNavibarHeight)/2.0, self.view.frame.size.width, 15)];
    _titleLabel.font = kFont(14);
    _titleLabel.textColor = kblackBackgroundColor;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"请输入支付密码，以验证身份";
    [self.view addSubview:_titleLabel];
    
    
    YN_PassWordView *pwdView = [[YN_PassWordView alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(_titleLabel.frame)+30, self.view.frame.size.width-20*2, 50)];
    pwdView.showType = passShow3;
    pwdView.num = 6;
    pwdView.tintColor = ktableViewSeparatorColor;
    pwdView.textBlock = ^(NSString *str) {
        if (ws.inputPwdCompleiton) {
            ws.inputPwdCompleiton(str);
        }
        [ws hide];
    };
    self.pwdView = pwdView;
    [pwdView show];
    [self.view addSubview:pwdView];
}
-(void)hide{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)itemAction:(UIButton *)sender{
    NSMutableString *oldStr = [NSMutableString stringWithString:self.pwdView.textF.text];
    NSString *newStr = @"";
    if (sender.tag == 11) {
        //删除
        if (oldStr.length>1) {
            newStr = [oldStr substringToIndex:(oldStr.length-1)];
        }else{
            newStr = [oldStr substringToIndex:0];
        }
    }else if (sender.tag == 9){
        //取消
        [self hide];
    }else{
        NSInteger realValue = sender.tag;
        if (sender.tag == 10) {
            realValue = 0;
        }
        [oldStr appendString:sender.currentTitle];
        newStr = oldStr;
    }
    [self.pwdView textFieldChanged:newStr];
}
@end
