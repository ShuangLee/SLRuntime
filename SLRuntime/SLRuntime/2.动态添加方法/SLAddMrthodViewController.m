//
//  SLAddMrthodViewController.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/8.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "SLAddMrthodViewController.h"
#import "Person.h"
#import <objc/message.h>

@interface SLAddMrthodViewController ()

@end

@implementation SLAddMrthodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //    _cmd:当前方法的方法编号
    
    Person *p = [[Person alloc] init];
    
    // 执行某个方法  在内部动态添加
    [p performSelector:@selector(run:) withObject:@20];
    
    // 直接动态添加
    [self runtimeAddMethod];
}


/**
 *  动态添加方法
 */
- (void)runtimeAddMethod {
    Person *p = [[Person alloc] init];
    
    //给Person类添加方法say
    /*
     (IMP)sayHello 意思是sayHello的地址指针;
     "v@:" 意思是，v代表无返回值void，如果是i则代表int；@代表 id self; : 代表 SEL _cmd;
     “v@:@@” 意思是，两个参数的没有返回值。
     */
    class_addMethod([Person class], @selector(say), (IMP)sayHello, "v@:");
    
    if ([p respondsToSelector:@selector(say)]) {
        [p performSelector:@selector(say)];
    } else {
        NSLog(@"Sorry,Method is not exist");
    }
}

/*这个有两个地方留意一下：
 1.void的前面没有+、-号，因为只是C的代码。
 2.必须有两个指定参数(id self,SEL _cmd)
 */
void sayHello(id self, SEL _cmd) {
    NSLog(@"Hello GuangTong");
}

@end
