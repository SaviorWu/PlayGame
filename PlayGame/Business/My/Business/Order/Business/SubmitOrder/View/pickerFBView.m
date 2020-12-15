//
//  pickerFBView.m
//  CNUKwallet
//
//  Created by 。。。。 on 2020/8/27.
//  Copyright © 2020 黄焕林. All rights reserved.
//

#import "pickerFBView.h"
#define Width [UIScreen mainScreen].bounds.size.width/320.0
 
#define Height [UIScreen mainScreen].bounds.size.height/480.0

@implementation pickerFBView
-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self) {
        
        //页面透明背景相当于蒙版
        _backView =[[UIView alloc]initWithFrame:CGRectMake(0,  0,SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backView.backgroundColor =[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [self addSubview:_backView];
        
        //存放按钮、picker的白色背景
        UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0,  SCREEN_HEIGHT - 180*Height,SCREEN_WIDTH, 30*Height)];
        view.backgroundColor = [UIColor colorWithHex:0xEBEBEB];
        [_backView addSubview:view];
        //picker的标题label
        _titlelabel =[[UILabel alloc]initWithFrame:CGRectMake(100*Width, 5*Height, 130*Width, 20*Height)];
        _titlelabel.textAlignment =NSTextAlignmentCenter;
        _titlelabel.textColor =[UIColor whiteColor];
        [view addSubview:_titlelabel];
        
        //picker创建
        _pickView =[[UIPickerView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 150*Height, SCREEN_WIDTH, 150*Height)];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.backgroundColor =[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
        _pickView.showsSelectionIndicator = YES;
        [self addSubview:_pickView];
 
        //取消、确定按钮创建
        _cancelBtn =[[UIButton alloc]initWithFrame:CGRectMake(10*Width, 0*Height, 50*Width, 30*Height)];
        [_cancelBtn addTarget:self action:@selector(cancelpickview) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor colorWithHex:0x9AA0A6] forState:UIControlStateNormal];
        [view addSubview:_cancelBtn];
        
        _sureBtn = [[UIButton alloc]initWithFrame:CGRectMake(260*Width, 0*Height, 50*Width, 30*Height)];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureselectBtn) forControlEvents:UIControlEventTouchUpInside];
        [_sureBtn setTitleColor:[UIColor colorWithHex:0x04A875] forState:UIControlStateNormal];
        [view addSubview:_sureBtn];
        
    }
    return self;
}
- (void)setOneStr:(NSString *)oneStr
{
    _oneStr = oneStr;
    NSInteger iIndex = 0;
    for (int i = 0; i < _onePick.count; i++) {
        if ([_onePick[i] isEqualToString:_oneStr]) {
            break;
        }
        iIndex++;
    }
    [self.pickView selectRow:iIndex inComponent:0 animated:YES];
}
- (void)setOnePick:(NSMutableArray *)onePick
{
    _onePick = onePick;
    [_pickView reloadAllComponents];
}
//选择方法
-(void)sureselectBtn
{
    if ([self.delegate respondsToSelector:@selector(pickViewdelegateWith:)]) {
        [self.delegate pickViewdelegateWith:_oneStr];
        [self removeFromSuperview];
    }
}
 
//取消方法
-(void)cancelpickview
{
    [self removeFromSuperview];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _onePick.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 25*Height;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%@",_onePick[row]];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%@",_onePick[row]);
    _oneStr = _onePick[row];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
