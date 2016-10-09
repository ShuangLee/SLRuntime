//
//  Person+Extension.m
//  LearnRuntime
//
//  Created by 光头强 on 16/7/13.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "Person+Extension.h"
#import <objc/runtime.h>
// 动态添加属性:什么时候需要动态添加属性
// 开发场景
// 给系统的类添加属性的时候,可以使用runtime动态添加属性方法
// 本质:动态添加属性,就是让某个属性与对象产生关联
// runtime一般都是针对系统的类
@implementation Person (Extension)
char cJob;

- (void)setJob:(NSString *)job {
    objc_setAssociatedObject(self, &cJob, job, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)job {
    return objc_getAssociatedObject(self, &cJob);
}
@end
