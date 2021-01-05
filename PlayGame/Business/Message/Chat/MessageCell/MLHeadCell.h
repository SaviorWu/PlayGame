//
//  MLHeadCell.h
//  PlayGame
//
//  Created by admin on 2021/1/5.
//

#import <UIKit/UIKit.h>
#import "MLModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^clickBlock)(void);
@interface MLHeadCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnDown;
@property (weak, nonatomic) IBOutlet UIImageView *imgHead;
@property (nonatomic, strong) clickBlock block;
- (void)setModel:(MLModel* )model;
@end

NS_ASSUME_NONNULL_END
