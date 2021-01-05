//
//  ChatTopView.h
//  PlayGame
//
//  Created by admin on 2021/1/5.
//

#import <UIKit/UIKit.h>
#import "MLModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^clickHeaderBlock) (NSString* str);
@interface ChatTopView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
- (instancetype)initWithFrame:(CGRect)frame withArray:(NSMutableArray*)array;
@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) NSMutableArray* arrayData;
@property (nonatomic, strong) clickHeaderBlock selectUserBlock;
@property (nonatomic, strong) clickHeaderBlock playSongBlock;
@end

NS_ASSUME_NONNULL_END
