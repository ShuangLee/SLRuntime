//
//  StatusItem.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/8.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "StatusItem.h"

@implementation StatusItem
+ (instancetype)itemWithDict:(NSDictionary *)dict
{
    StatusItem *item = [[self alloc] init];
    
    // KVC:把字典中所有值给模型的属性赋值
    [item setValuesForKeysWithDictionary:dict];
    
    return item;
}

// 重写系统方法? 1.想给系统方法添加额外功能 2.不想要系统方法实现
// 系统找不到就会调用这个方法,报错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
