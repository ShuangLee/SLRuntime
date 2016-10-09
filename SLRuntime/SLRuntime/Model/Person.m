//
//  Person.m
//  LearnRuntime
//
//  Created by 光头强 on 16/7/13.
//  Copyright © 2016年 Ls. All rights reserved.
//  归档存储自定义对象

#import "Person.h"
#import <objc/runtime.h>

@interface Person ()
{
    float height;
}
@end

@implementation Person
// 没有返回值,也没有参数
// void,(id,SEL)
void aaa(id self, SEL _cmd, NSNumber *meter) {
    NSLog(@"跑了%@", meter);
}

// 任何方法默认都有两个隐式参数,self,_cmd
// 什么时候调用:只要一个对象调用了一个未实现的方法就会调用这个方法,进行处理
// 作用:动态添加方法,处理未实现
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    if (sel == NSSelectorFromString(@"run:")) {
        // eat
        // class: 给哪个类添加方法
        // SEL: 添加哪个方法
        // IMP: 方法实现 => 函数 => 函数入口 => 函数名
        // type: 方法类型
        class_addMethod(self, sel, (IMP)aaa, "v@:@");
        
        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
    
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    unsigned int count = 0;
    //获得指向该类的所有属性的指针
    objc_property_t *propertys = class_copyPropertyList([Person class], &count);
    for (int i = 0; i < count; i++) {
        //获得Ivar
        objc_property_t property = propertys[i];
        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        //NSLog(@"属性：%d---%@",i,key);
        // 编码每个属性，利用kvc取出每个属性对应的值
        [self setValue:[dict objectForKey:key] forKey:key];
    }
    
    free(propertys);
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int count = 0;
    //获得指向该类的所有属性的指针
    objc_property_t *propertys = class_copyPropertyList([Person class], &count);
    for (int i = 0; i < count; i++) {
        //获得Ivar
        objc_property_t property = propertys[i];
        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        //NSLog(@"属性：%d---%@",i,key);
        // 编码每个属性，利用kvc取出每个属性对应的值
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    
    free(propertys);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    unsigned int count = 0;
    //获得指向该类的所有属性的指针
    objc_property_t *propertys = class_copyPropertyList([Person class], &count);
    for (int i = 0; i < count; i++) {
        //获得Ivar
        objc_property_t property = propertys[i];
        //根据objc_property_t获得其属性的名称--->C语言的字符串
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        //NSLog(@"属性：%d---%@",i,key);
        
        //解码每个属性,利用kVC取出每个属性对应的数值
        [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];;
    }
    
    free(propertys);
    
    return self;
}
@end
