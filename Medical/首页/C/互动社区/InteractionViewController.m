//
//  InteractionViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "InteractionViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
//互动社区详情
#import "InteractionDetailController.h"
@interface InteractionViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView*web;
@end

@implementation InteractionViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"互动社区"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self createUI];
}
- (void)createUI
{
    _web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    _web.delegate=self;
    [self.view addSubview:_web];
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://139.224.43.42/medical/index.php/Admin/H5/indetails"]]];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [self.web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"shows"] = ^()
    {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
            [self pushDetail:[NSString stringWithFormat:@"%@",jsVal]];
        }
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"-------End Log-------");
    };
}
- (void)pushDetail:(NSString*)interactionID
{
    InteractionDetailController*detail=[InteractionDetailController new];
    detail.intercationID=[NSString stringWithFormat:@"%@",interactionID];
    [self.navigationController pushViewController:detail animated:YES];
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
