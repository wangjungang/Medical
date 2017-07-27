//
//  WebViewController.m
//  Medical
//
//  Created by 李壮 on 2016/11/17.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()
@property (nonatomic,strong)UIWebView*webView;
@end

@implementation WebViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"诊所"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
}
- (UIWebView*)webView
{
    if (!_webView) {
        _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)setLoadUrl:(NSString *)loadUrl
{
    if ([_loadUrl isEqualToString:loadUrl])
    {
        return;
    }
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:loadUrl]]];
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
