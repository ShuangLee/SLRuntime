//
//  UIImage+log.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/8.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "UIImage+log.h"
#import <objc/message.h>

@implementation UIImage (log)
// 把类加载进内存的时候调用,只会调用一次
+ (void)load
{
    // self -> UIImage
    // 获取imageNamed
    // 获取哪个类的方法
    // SEL:获取哪个方法
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    // 获取xmg_imageNamed
    Method xmg_imageNamedMethod = class_getClassMethod(self, @selector(sl_imageNamed:));
    
    // 交互方法:runtime
    method_exchangeImplementations(imageNamedMethod, xmg_imageNamedMethod);
    // 调用imageNamed => sl_imageNamedMethod
    // 调用sl_imageNamedMethod => imageNamed
}

// 会调用多次
//+ (void)initialize
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//
//    });
//
//}

// 在分类中,最好不要重写系统方法,一旦重写,把系统方法实现给干掉

//+ (UIImage *)imageNamed:(NSString *)name
//{
//    // super -> 父类NSObject
//
//}

// 1.加载图片
// 2.判断是否加载成功
+ (UIImage *)sl_imageNamed:(NSString *)name
{
    // 图片
    UIImage *image = [UIImage sl_imageNamed:name];
    
    if (image) {
        NSLog(@"加载成功");
    } else {
        NSLog(@"加载失败");
    }
    
    return image;
}
@end
