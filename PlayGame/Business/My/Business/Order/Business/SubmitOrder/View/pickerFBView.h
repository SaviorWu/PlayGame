//
//  pickerFBView.h
//  CNUKwallet
//
//  Created by 。。。。 on 2020/8/27.
//  Copyright © 2020 黄焕林. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol pickViewselectDelegate <NSObject>
 
-(void)pickViewdelegateWith:(NSString *_Nullable)oneStr;
 
@end
 
 


NS_ASSUME_NONNULL_BEGIN

@interface pickerFBView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,assign)id<pickViewselectDelegate>delegate;

// pickerview
@property (nonatomic, strong)NSString *selectFB;
//确定和取消按钮
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *sureBtn;
//标题
@property(nonatomic,strong)UILabel *titlelabel;
 
//显示多少行,最多显示3行
@property(nonatomic,assign)int rowcount;
 
@property(nonatomic,strong)UIPickerView *pickView;
//背景视图
@property(nonatomic,strong)UIView *backView;
//每列需要显示的数据
//第一列
@property(nonatomic,strong)NSMutableArray *onePick;

@property (nonatomic, strong) NSString* oneStr;
@end

NS_ASSUME_NONNULL_END
