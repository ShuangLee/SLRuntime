//
//  SLImage.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/8.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLImage.h"

@implementation SLImage
// 重写方法:想给系统的方法添加额外功能
+ (UIImage *)imageNamed:(NSString *)name
{
    // 真正加载图片
    UIImage *image = [super imageNamed:name];
    
    if (image) {
        NSLog(@"加载成功");
    } else {
        NSLog(@"加载失败");
    }
    
    return image;
    
}

@end
