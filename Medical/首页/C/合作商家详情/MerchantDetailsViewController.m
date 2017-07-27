//
//  MerchantDetailsViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "MerchantDetailsViewController.h"
#import "HWAlertView.h"
#import "NSString+Extend.h"
#import "NSObject+MBProgressHUD.h"
@interface MerchantDetailsViewController ()<HWAlertViewDelegate>
{
    UIWebView *web;
    HWAlertView *alert;
}
@end

@implementation MerchantDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"合作商家详情"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self createUI];
}
-(void)createUI
{
    web =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64-49)];
    [self.view addSubview:web];
    NSString *url;
    if (_type==1)
    {
        url=[NSString stringWithFormat:SHOP_DETAIL_URL,_ID];
    }else if (_type==2)
    {
        url=[NSString stringWithFormat:Hospital_Details_URL,_ID];
    }else
    {
        url=[NSString stringWithFormat:CLINIC_DETAIL_URL,_ID];
    }
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    UIButton *yuyueBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    yuyueBtn.backgroundColor=[UIColor wjColorFloat:KMedical_Blue];
    [yuyueBtn setTitle:@"商家预约" forState:0];
    yuyueBtn.titleLabel.textColor=[UIColor whiteColor];
    yuyueBtn.frame=CGRectMake(0, DEVICE_HEIGHT-49, DEVICE_WIDTH, 49);
    [yuyueBtn addTarget:self action:@selector(yuyueBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuyueBtn];

}
-(void)yuyueBtnClick:(UIButton *)button
{
    alert=[[HWAlertView alloc]initWithFrame:self.view.frame backImageFrame:CGRectMake(0, 0, 280, 180) imageName:@"组34.png"alertTitle:@"商家预约"];
    [alert setTFNum:2 x:F_I6_SIZE(33/2)+65 y:50 height:280-F_I6_SIZE(33)-65 width:20 interval:40];
    [alert setLbNum:2 x:F_I6_SIZE(33/2) y:50 height:60 width:20 interval:40 lbtitleAry:@[@"姓       名:",@"联系电话:"]];
    alert.cancleBtn.frame=CGRectMake(160, 140, 70, 25);
    [alert.cancleBtn setTitle:@"取消" forState:0];
    alert.cancleBtn.layer.cornerRadius=5;
    alert.cancleBtn.clipsToBounds=YES;
    alert.cancleBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
    [alert.cancleBtn setTitleColor:[UIColor whiteColor] forState:0];
    alert.cancleBtn.backgroundColor=[UIColor colorWithRed:169.f/255 green:169.f/255 blue:169.f/255 alpha:1];
    
    alert.sureBtn.frame=CGRectMake(50, 140, 70, 25);
    [alert.sureBtn setTitle:@"预约" forState:UIControlStateNormal];
    [alert.sureBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    alert.sureBtn.layer.cornerRadius=5;
    alert.sureBtn.clipsToBounds=YES;
    [alert.sureBtn setTitleColor: [UIColor whiteColor] forState:0];
    alert.sureBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
    alert.sureBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
    alert.delegate =self;
    [self.view addSubview:alert];
    [alert show];
}
#pragma mark-HWalert代理方法
- (void)alertView:(HWAlertView *)alertView didSelectOptionButtonWithTag:(NSInteger)tag TFContents:(NSMutableArray *)contents
{
    NSString *name=contents[0];
    NSString *phone=contents[1];
    if ([name deleteSpace].length==0||![NSString checkTelNumber:phone])
    {
        if ([name deleteSpace].length==0) {
            [NSObject showWarning:@"请填写姓名" showHUDView:self.view];
        }else{
            [NSObject showWarning:@"请填写正确的手机号" showHUDView:self.view];
        }
    }else
    {
        NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
        NSDictionary*dic=@{@"name":name,@"iphone":phone,@"uid":uid,@"sid":_ID};
        [self postShopData:dic];
    }
}
#pragma mark-
#pragma mark-获取数据源
- (void)postShopData:(NSDictionary*)dic
{
    [AFManager postReqURL:SHOP_ABOUT_URL reqBody:dic block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject showWarning:@"预约成功" showHUDView:self.view];
        }
        else
        {
            [NSObject showWarning:@"预约失败" showHUDView:self.view];
        }
        [alert setHidden:YES];
        [alert dismiss];
    }];
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
