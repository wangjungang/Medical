//
//  RongChetController.m
//  Medical
//
//  Created by 李壮 on 2016/12/2.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "RongChetController.h"

@interface RongChetController ()

@end

@implementation RongChetController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController*tabbar =[CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
    self.navigationController.navigationBar.hidden=NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
