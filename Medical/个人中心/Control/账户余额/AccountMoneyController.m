//
//  AccountMoneyController.m
//  Medical
//
//  Created by 李壮 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "AccountMoneyController.h"
#import "settlementpayViewController.h"
@interface AccountMoneyController ()

@end

@implementation AccountMoneyController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [[NSNotificationCenter defaultCenter] ]
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"余额"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor=[UIColor whiteColor];
    [self createUI];
}
- (void)createUI
{
    UIImageView *moneyImage =[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(135), F_I6_SIZE(150)+64, DEVICE_WIDTH-F_I6_SIZE(270), F_I6_SIZE(75))];
    moneyImage.image =[UIImage imageNamed:@"矢量智能对象.png"];
    [self.view addSubview:moneyImage];
    UILabel *moneyLb =[[UILabel alloc]initWithFrame:CGRectMake(0, F_I6_SIZE(240)+64, DEVICE_WIDTH, F_I6_SIZE(18))];
    moneyLb.font =[UIFont systemFontOfSize:F_I6_SIZE(18)];
    moneyLb.textColor =[UIColor wjColorFloat:@"000000"];
    if ([_money isEqualToString:@""])
    {
        _money=@"没有余额，请充值";
        moneyLb.text=[NSString stringWithFormat:@"¥%@",_money];
    }
    else
    {
         moneyLb.text=[NSString stringWithFormat:@"¥%@元宝",_money];
    }
   
    moneyLb.textAlignment=1;
    [self.view addSubview:moneyLb];
    
    UIButton *chongzhiButton = [UIButton buttonWithType:UIButtonTypeCustom];
    chongzhiButton.frame = CGRectMake(DEVICE_WIDTH/2 - 50 *WIDTH_SCALE, 400 *HEIGHT_SCALE, 100 *WIDTH_SCALE, 30 *HEIGHT_SCALE);
    chongzhiButton.backgroundColor = [UIColor  wjColorFloat:KMedical_Blue];
    [chongzhiButton setTitle:@"充值" forState:UIControlStateNormal];
    [chongzhiButton addTarget:self action:@selector(chongzhiButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chongzhiButton];
}
-(void)chongzhiButtonClick:(UIButton *)button
{
    settlementpayViewController *payVC= [settlementpayViewController new];
    [self.navigationController pushViewController:payVC animated:YES];
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
