//
//  DuizhengxiayaoHTMLViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/24.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "DuizhengxiayaoHTMLViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "detailsViewController.h"
@interface DuizhengxiayaoHTMLViewController ()<UIWebViewDelegate>
{
    NSString *ID;
    NSString *name;
    NSString *price;
}
@end

@implementation DuizhengxiayaoHTMLViewController
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
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"对症下药"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self createUI];
}
-(void)createUI
{
    UIWebView *web =[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    [self.view addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Duizheng_HTML_URL]]];
    web.delegate = self;
   

}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"xiangqingBtn"] = ^()
    {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        ID = args[0];
        name = args[1];
        price = args[2];
        //        for (JSValue *jsVal in args) {
        NSLog(@"====%@",args);
            NSLog(@"111：%@  %@", ID,name);
//        }
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"-------End Log-------");
        NSLog(@"点击了");
        [self click];
    };
}
-(void)click
{
    detailsViewController *detailsVC = [detailsViewController new];
    detailsVC.pid = [NSString stringWithFormat:@"%@",ID];
    detailsVC.newprice = [NSString stringWithFormat:@"%@",price];
    detailsVC.drugnamestr = [NSString stringWithFormat:@"%@",name];
    [self.navigationController pushViewController:detailsVC animated:YES];
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
