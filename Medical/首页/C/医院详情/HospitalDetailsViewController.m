//
//  HospitalDetailsViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "HospitalDetailsViewController.h"
#import "YuyueOfficeViewController.h"
#
@interface HospitalDetailsViewController ()

@end

@implementation HospitalDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"合作医院详情"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };

    [self createUI];
//    [self getRequestHospitalDetails];
}
//-(void)getRequestHospitalDetails
//{
//    [AFManager getReqURL:[NSString stringWithFormat:Hospital_Details_URL,self.detailsID] block:^(id infor) {
//        NSLog(@"web===%@",infor);
////        [self createUI];
//    } errorblock:^(NSError *error) {
//        
//    }];
//}
-(void)createUI
{
    UIWebView *web =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64-49)];
    [self.view addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:Hospital_Details_URL,self.detailsID]]]];
    
    UIButton *yuyueBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    yuyueBtn.backgroundColor=[UIColor wjColorFloat:KMedical_Blue];
    [yuyueBtn setTitle:@"科室预约" forState:0];
    yuyueBtn.titleLabel.textColor=[UIColor whiteColor];
    yuyueBtn.frame=CGRectMake(0, DEVICE_HEIGHT-49, DEVICE_WIDTH, 49);
    [yuyueBtn addTarget:self action:@selector(yuyueBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuyueBtn];
    
}
-(void)yuyueBtnClick:(UIButton *)button
{
    YuyueOfficeViewController *yuyueVC = [YuyueOfficeViewController new];
    yuyueVC.hospitalID = self.detailsID;
    [self.navigationController pushViewController:yuyueVC animated:YES];
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
