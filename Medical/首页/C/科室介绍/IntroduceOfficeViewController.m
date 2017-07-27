//
//  IntroduceOfficeViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "IntroduceOfficeViewController.h"
#import "OnlineConsultationViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
//聊天
#import "RongChetController.h"
@interface IntroduceOfficeViewController ()<UIWebViewDelegate>

@end

@implementation IntroduceOfficeViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"科室介绍"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self createUI];
}
-(void)createUI
{
    UIWebView *web =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64-49)];
    [self.view addSubview:web];
    web.delegate = self;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:DEPARTMENT_DETAIL_URL,_ID]]]];
    UIButton *yuyueBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    yuyueBtn.backgroundColor=[UIColor wjColorFloat:KMedical_Blue];
    [yuyueBtn setTitle:@"在线咨询" forState:0];
    yuyueBtn.titleLabel.textColor=[UIColor whiteColor];
    yuyueBtn.frame=CGRectMake(0, DEVICE_HEIGHT-49, DEVICE_WIDTH, 49);
    [yuyueBtn addTarget:self action:@selector(yuyueButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:yuyueBtn];
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"skip"] = ^()
    {
        NSLog(@"111");
        [self callPhone];
    };
}
#pragma mark -
#pragma mark 拨打电话
- (void)callPhone
{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_phone];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:str]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
}
-(void)yuyueBtnClick:(UIButton *)button
{
    OnlineConsultationViewController *onlineVC = [OnlineConsultationViewController new];
    [self.navigationController pushViewController:onlineVC animated:YES];
}
-(void)yuyueButtonClick
{
    [self rongChet];
}
#pragma mark-
#pragma mark-融云客服
- (void)rongChet
{
    RongChetController*chat=[[RongChetController alloc]init];
    chat.targetId=self.ltId;
    chat.conversationType=ConversationType_PRIVATE;
    chat.title=self.chetName;
    [self.navigationController pushViewController:chat animated:YES];
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
