//
//  ViewController.m
//  SLRuntime
//
//  Created by 光头强 on 16/10/8.
//  Copyright © 2016年 Ls. All rights reserved.
//

#import "ViewController.h"
#import "SLExchangeMethodViewController.h"
#import "SLAddMrthodViewController.h"
#import "SLAddPropertyViewController.h"
#import "SLDictToModelViewController.h"
#import "SLRuntimeToModelViewController.h"
#import "SLOtherViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, copy) NSArray *dataArr;
@end

@implementation ViewController

- (NSArray *)dataArr {
    return @[@"1.方法交换",@"2.动态添加方法",@"3.动态添加属性",@"4.字典转模型KVC实现",@"5.runtime字典转模型",@"6.其他"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"runtime应用场景";
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-20) style:(UITableViewStylePlain)];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.rowHeight = 50;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"reuse";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:str];
        cell.textLabel.text = self.dataArr[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        SLExchangeMethodViewController *vc = [[SLExchangeMethodViewController alloc] init];
        vc.title = @"runtime方法交换";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        SLAddMrthodViewController *vc = [[SLAddMrthodViewController alloc] init];
        vc.title = @"runtime动态添加方法";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        SLAddPropertyViewController *vc = [[SLAddPropertyViewController alloc] init];
        vc.title = @"runtime动态添加属性";
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 3){
        SLDictToModelViewController *vc = [[SLDictToModelViewController alloc] init];
        vc.title = @"字典转模型KVC实现";
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row == 4){
        SLRuntimeToModelViewController *vc = [[SLRuntimeToModelViewController alloc] init];
        vc.title = @"RUNTIME字典转模型KVC实现";
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        SLOtherViewController *vc = [[SLOtherViewController alloc] init];
        vc.title = @"其他";
        [self.navigationController pushViewController:vc animated:YES];
    }


}

@end
