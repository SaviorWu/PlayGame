//
//  JTBaseTabBarController.h
//  CNUKwallet
//
//  Created by 黄焕林 on 2020/3/20.
//  Copyright © 2020 黄焕林. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JTBaseTabBarController : UITabBarController <UITabBarControllerDelegate>

+ (JTBaseTabBarController *)sharedInstance;

@property (nonatomic, assign) NSUInteger selectedTabBarIndex;

@end

NS_ASSUME_NONNULL_END
