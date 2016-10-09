//
//  SLAddPropertyViewController.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/8.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLAddPropertyViewController.h"
#import "Person+Extension.h"

@interface SLAddPropertyViewController ()

@end

@implementation SLAddPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addPropertyToCategory];
}

/**
 *  iOS面试当中经常面到的问题：如何给扩展添加属性？。
 *  动态为Category扩展加属性
 */
- (void)addPropertyToCategory {
    Person *p = [[Person alloc] initWithDict:@{@"name":@"逗比",@"age":@24,@"job":@"iOS"}];
    NSLog(@"new property is %@",p.job);
}
@end
