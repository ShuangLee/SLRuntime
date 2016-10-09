//
//  SLRuntimeToModelViewController.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/9.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLRuntimeToModelViewController.h"
#import "NSDictionary+Property.h"
#import "StatusItem.h"
#import "NSObject+Model.h"

@implementation SLRuntimeToModelViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 获取文件全路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    
    // 文件全路径
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    // 设计模型,创建属性代码 => dict
    //    [dict[@"user"] createPropertyCode];
    
    // 字典转模型:KVC,MJExtension
    StatusItem *item = [StatusItem modelWithDict:dict];
    
    NSLog(@"%@",item.user);
}
@end
