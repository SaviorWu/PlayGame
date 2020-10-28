//
//  UITableViewCell+loadCell.h
//  PlayGame
//
//  Created by admin on 2020/10/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView(LoadCell)
- (void)registCell:(NSString*)cellName;
- (void)reloadCell:(NSString*)cellName;
@end

NS_ASSUME_NONNULL_END
