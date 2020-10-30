//
//  UITableViewCell.m
//  PlayGame
//
//  Created by admin on 2020/10/30.
//

#import "NSObject+setProperty.h"

@implementation NSObject(property)
- (BOOL)setPropertyValue:(id)propertyValue propertyName:(NSString *)propertyName {
    
    BOOL isPropertyExist= NO;
    unsigned int methodCount = 0;
    
    Ivar * ivars = class_copyIvarList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSLog(@"%@拥有的成员变量的类型为%s，名字为 %s ",NSStringFromClass([self class]),type, name);
        NSString *tempPropertyName = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
        if([tempPropertyName isEqualToString:propertyName])
        {
            isPropertyExist = YES;
            object_setIvar(self, ivar,propertyValue);
            NSLog(@"object_setIvar:%@",object_getIvar(self, ivar));
            break;
        }
    }
    return isPropertyExist;
}
@end
