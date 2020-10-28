//
//  UITableViewCell+loadCell.m
//  PlayGame
//
//  Created by admin on 2020/10/28.
//

#import "UITableViewCell+loadCell.h"

@implementation UITableView(LoadCell)
- (void)registCell:(NSString*)cellName
{
    [self registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
}
- (void)reloadCell:(NSString*)cellName
{
    [self dequeueReusableCellWithIdentifier:cellName];
}
@end
