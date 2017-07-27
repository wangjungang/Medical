//
//  DetailClinvController.m
//  Medical
//
//  Created by 李壮 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "DetailClinvController.h"
//
#import "CustomTabbarViewController.h"
//
#import "HWAlertView.h"
#import "NSObject+HUD.h"
#import "NSObject+MBProgressHUD.h"
#import "NSString+Extend.h"
//
//
#import "DatePickView.h"
#import "WYWebProgressLayer.h"
#import "UIView+Frame.h"
//
#import "RongChetController.h"
@interface DetailClinvController ()<HWAlertViewDelegate,UIWebViewDelegate,DatePickViewDelegate>
{
    UIWebView *_webView;
    UITextField*timeTF;
    WYWebProgressLayer *_progressLayer; ///< 网页加载进度条
    HWAlertView *alert;
}
@end

@implementation DetailClinvController
- (void)viewWillAppear:(BOOL)animated
{
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
    self.navigationController.navigationBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:@"图层44.png" rightBtnTitle:nil title:_chetTitle];
    [customNavView setRightBtnFrame:CGRectMake(DEVICE_WIDTH - 20 *WIDTH_SCALE - 15 *WIDTH_SCALE, 32, 25, 20)];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock =^{
        [self callPhone];
    };
    [self createUI];
}
#pragma mark-
#pragma mark-创建UI
- (void)createUI
{
    _webView =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64-49)];
    _webView.delegate=self;
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://139.224.43.42/medical/index.php/Admin/H5/details?id=%@",_clinvID]]]];
    _progressLayer = [WYWebProgressLayer new];
    _progressLayer.frame = CGRectMake(0, 64, DEVICE_WIDTH, 2);
    [self.view.layer addSublayer:_progressLayer];

    
    UIButton *advanceBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    advanceBtn.backgroundColor=[UIColor wjColorFloat:KMedical_Blue];
    [advanceBtn setTitle:@"预约" forState:0];
    [advanceBtn setImage:[UIImage imageNamed:@"图层45.png"] forState:0];
    advanceBtn.titleLabel.textColor=[UIColor whiteColor];
    advanceBtn.frame=CGRectMake(0, DEVICE_HEIGHT-49, DEVICE_WIDTH/2, 49);
    [advanceBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [advanceBtn addTarget:self action:@selector(advanceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:advanceBtn];
    
    UIButton *aboutBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    aboutBtn.backgroundColor=[UIColor colorWithRed:230.f/255 green:90.f/255 blue:40.f/255 alpha:1];
    [aboutBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [aboutBtn setTitle:@"问诊" forState:0];
    [aboutBtn setImage:[UIImage imageNamed:@"图层25.png"] forState:0];
    aboutBtn.frame=CGRectMake(DEVICE_WIDTH/2, DEVICE_HEIGHT-49, DEVICE_WIDTH/2, 49);
    [aboutBtn addTarget:self action:@selector(aboutBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aboutBtn];
}
#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressLayer finishedLoad];
}
#pragma mark-
#pragma mark-预约按钮
- (void)advanceBtnClick
{
    alert=[[HWAlertView alloc]initWithFrame:self.view.frame backImageFrame:CGRectMake(0, 0, 280, 240) imageName:@"组34.png"alertTitle:@"预约"];
    [alert setTFNum:4 x:F_I6_SIZE(33/2)+65 y:50 height:280-F_I6_SIZE(33)-65 width:20 interval:40];
    [alert setLbNum:4 x:F_I6_SIZE(33/2) y:50 height:60 width:20 interval:40 lbtitleAry:@[@"姓       名:",@"联系电话:",@"时       间:",@"地       址:"]];
    alert.cancleBtn.frame=CGRectMake(160, 210, 70, 25);
    [alert.cancleBtn setTitle:@"取消" forState:0];
    alert.cancleBtn.layer.cornerRadius=5;
    alert.cancleBtn.clipsToBounds=YES;
    alert.cancleBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
    [alert.cancleBtn setTitleColor:[UIColor whiteColor] forState:0];
    alert.cancleBtn.backgroundColor=[UIColor colorWithRed:169.f/255 green:169.f/255 blue:169.f/255 alpha:1];
    
    alert.sureBtn.frame=CGRectMake(50, 210, 70, 25);
    [alert.sureBtn setTitle:@"预约" forState:UIControlStateNormal];
    [alert.sureBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    alert.sureBtn.layer.cornerRadius=5;
    alert.sureBtn.clipsToBounds=YES;
    [alert.sureBtn setTitleColor: [UIColor whiteColor] forState:0];
    alert.sureBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
    alert.sureBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
    alert.delegate =self;
    alert.datePick.frame=CGRectMake(0, DEVICE_HEIGHT, DEVICE_WIDTH,F_I6_SIZE(215) );
    [self.view addSubview:alert];
    [alert show];
}

#pragma mark-
#pragma mark-问诊按钮
- (void)aboutBtnClick
{
    if (self.targedId)
    {
        [self rongChet:self.targedId title:self.chetTitle];
    }
}
#pragma mark-
#pragma mark-融云客服
- (void)rongChet:(NSString*)targetId title:(NSString*)title;
{
    RongChetController*chat=[[RongChetController alloc]init];
    chat.targetId=self.targedId;
    chat.conversationType=ConversationType_PRIVATE;
    chat.title=title;
    [self.navigationController pushViewController:chat animated:YES];
}
#pragma mark-
#pragma mark-HWalert代理方法
- (void)alertView:(HWAlertView *)alertView didSelectOptionButtonWithTag:(NSInteger)tag TFContents:(NSMutableArray *)contents
{
    [self postclinv:contents];
}
#pragma mark -
#pragma mark 拨打电话
- (void)callPhone
{
    if ([NSString checkTelNumber:_phone] ) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",_phone];
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:str]])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        }
    }else
    {
        [NSString wj_showHUDWithTip:@"该诊所未填写联系电话"];
    }
}
#pragma mark-
#pragma mark-获取数据源
//获取详情页
- (void)getData
{
//    [AFManager getReqURL:[NSString stringWithFormat:CLINIC_DETAIL_URL,_clinvID] block:^(id infor)
//    {
//        
//    } errorblock:^(NSError *error)
//    {
//    
//    }];
}
//预约诊所
- (void)postclinv:(NSMutableArray*)array
{
    NSString*name=array[0];
    NSString*phone=array[1];
    NSString*time=array[2];
    NSString*address=array[3];
    if ([name deleteSpace].length ==0)
    {
        [NSObject showWarning:@"姓名不能为空" showHUDView:self.view];
        return;
    }else if (![NSString checkTelNumber:phone]){
        [NSObject showWarning:@"请填写正确的手机号" showHUDView:self.view];
        return;
    }else if ([time deleteSpace].length==0){
        [NSObject showWarning:@"请填写时间" showHUDView:self.view];
        return;
    }else if([address deleteSpace].length==0){
        [NSObject showWarning:@"地址不能为空" showHUDView:self.view];
        return;
    }
    [AFManager postReqURL:WALK_CLINIC_URL reqBody:@{@"name":name,@"iphone":phone,@"times":time,@"address":address,@"zsid":_clinvID} block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200) {
            [NSObject showWarning:@"预约成功" showHUDView:self.view];
            
        }else{
            [NSObject showWarning:@"预约失败" showHUDView:self.view];
        }
        [alert dismiss];
        [alert setHidden:YES];
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
