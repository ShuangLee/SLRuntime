//
//  NSMutableArray+Extension.m
//  LearnRuntime
//
//  Created by 光头强 on 16/7/13.
//  Copyright © 2016年 Ls. All rights reserved.
//
/**
 runtime实际应用
 1. 动态的添加对象的成员变量和方法
 2. 动态交换两个方法的实现
 3. 实现分类也可以添加属性
 4. 实现NSCoding的自动归档和解档
 5. 实现字典转模型的自动转换
 */

#import "NSMutableArray+Extension.h"
#import <objc/runtime.h>

@implementation NSMutableArray (Extension)
/** 利用runtime实现方法交换 */
/**
 *  该方法在类或者分类第一次加载的时候自动调用
 */
+ (void)load {
    Method originalMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method newMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(gtq_addObject:));
    
    // 交换方法的实现
    method_exchangeImplementations(originalMethod, newMethod);
}

/**
 *  自己的方法替换系统方法
 */
- (void)gtq_addObject:(id)object {
    if (object != nil) {
        /** 注意该方法的调用，因为方法实现已经交换了，如果调用addObject:会出现死循环 */
        [self gtq_addObject:object];
    }
}

@end
