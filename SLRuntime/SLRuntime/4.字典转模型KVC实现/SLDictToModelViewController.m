//
//  SLDictToModelViewController.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/8.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLDictToModelViewController.h"
#import "NSDictionary+Property.h"
#import "StatusItem.h"

@interface SLDictToModelViewController ()

@end

@implementation SLDictToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 获取文件全路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    
    // 文件全路径
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    // 设计模型,创建属性代码 => dict
    [dict createPropertyCode];
    
    // 字典转模型:KVC,MJExtension
    StatusItem *item = [StatusItem itemWithDict:dict];
    NSLog(@"%@",item.source);
}

@end
