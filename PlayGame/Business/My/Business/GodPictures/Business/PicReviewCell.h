//
//  PicReviewCell.h
//  PlayGame
//
//  Created by admin on 2020/12/25.
//

#import <UIKit/UIKit.h>
#import "EBBannerView.h"
#import "KYPhotoBrowserController.h"
NS_ASSUME_NONNULL_BEGIN

@interface PicReviewCell : UITableViewCell<KYPhotoBrowserControllerDelegate>
@property (weak, nonatomic) IBOutlet EBBannerView *picView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;

@end

NS_ASSUME_NONNULL_END
