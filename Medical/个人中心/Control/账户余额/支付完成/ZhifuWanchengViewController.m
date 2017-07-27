//
//  ZhifuWanchengViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/29.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "ZhifuWanchengViewController.h"
#import "UserHeaderUser.h"
@interface ZhifuWanchengViewController ()

@end

@implementation ZhifuWanchengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"支付完成"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popToRootViewControllerAnimated:YES];

    };
    self.view.backgroundColor=[UIColor whiteColor];
    [self createUI];
}
-(void)createUI
{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2 -50 *WIDTH_SCALE, 64 + 80 *HEIGHT_SCALE, 100 *WIDTH_SCALE, 100 *WIDTH_SCALE)];
//    imageView.backgroundColor = [UIColor redColor];
    imageView.image = [UIImage imageNamed:@"支付成功"];
    [self.view addSubview:imageView];
    
    UILabel *chenggongLabel = [[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2 - 50 *WIDTH_SCALE, 64 +(140 + 15 )*HEIGHT_SCALE, 100 *WIDTH_SCALE, 80 *HEIGHT_SCALE)];
    chenggongLabel.text = @"支付完成";
    chenggongLabel.textAlignment = NSTextAlignmentCenter;
    chenggongLabel.font = [UIFont systemFontOfSize:17 *WIDTH_SCALE];
    chenggongLabel.textColor = [UIColor blackColor];
    [self.view addSubview:chenggongLabel];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 225 *HEIGHT_SCALE, DEVICE_WIDTH, 1 *HEIGHT_SCALE)];
    topLabel.backgroundColor = Line_Color;
    [self.view addSubview:topLabel];

    //账户名称
    UILabel *nickNameLabel =[[UILabel alloc] initWithFrame:CGRectMake(15 *WIDTH_SCALE, 64 +230 *HEIGHT_SCALE, DEVICE_WIDTH/2 - 15 *WIDTH_SCALE, 20 *HEIGHT_SCALE)];
    nickNameLabel.text = @"账户名称";
    nickNameLabel.textColor = [UIColor blackColor];
    nickNameLabel.font = [UIFont systemFontOfSize:14 *WIDTH_SCALE];
    nickNameLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:nickNameLabel];
    
    UILabel *nameLabel =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 64 +230 *HEIGHT_SCALE, DEVICE_WIDTH/2 - 15 *WIDTH_SCALE, 20 *HEIGHT_SCALE)];
    UserHeaderUser*userHeaedeModel=[NSKeyedUnarchiver unarchiveObjectWithFile:RONG_USER_INFO];
    nameLabel.text = userHeaedeModel.nickName;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:14 *WIDTH_SCALE];
    nameLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:nameLabel];
    
    //充值金额
    UILabel *chongzhijinerLabel =[[UILabel alloc] initWithFrame:CGRectMake(15 *WIDTH_SCALE, 64 +270 *HEIGHT_SCALE, DEVICE_WIDTH/2 - 15 *WIDTH_SCALE, 20 *HEIGHT_SCALE)];
    chongzhijinerLabel.text = @"充值金额";
    chongzhijinerLabel.textColor = [UIColor blackColor];
    chongzhijinerLabel.font = [UIFont systemFontOfSize:14 *WIDTH_SCALE];
    chongzhijinerLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:chongzhijinerLabel];
    UILabel *moneyLabel =[[UILabel alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 64 +270 *HEIGHT_SCALE, DEVICE_WIDTH/2 - 15 *WIDTH_SCALE, 20 *HEIGHT_SCALE)];
    moneyLabel.text = self.moneyStr;
    moneyLabel.textColor = [UIColor blackColor];
    moneyLabel.font = [UIFont systemFontOfSize:14 *WIDTH_SCALE];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:moneyLabel];

    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64 + 300 *HEIGHT_SCALE, DEVICE_WIDTH, 1 *HEIGHT_SCALE)];
    bottomLabel.backgroundColor = Line_Color;
    [self.view addSubview:bottomLabel];

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(DEVICE_WIDTH/2 - 50 *WIDTH_SCALE , 64 + 320 *HEIGHT_SCALE, 100 *WIDTH_SCALE, 35 *HEIGHT_SCALE);
    button.backgroundColor = [UIColor wjColorFloat: KMedical_Blue];
    [button setTitle:@"完成" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)buttonClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
