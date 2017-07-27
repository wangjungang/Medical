//
//  InteractionDetailController.m
//  Medical
//
//  Created by 李壮 on 2016/11/29.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "InteractionDetailController.h"
#import "UMSocialTool.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface InteractionDetailController ()<UIWebViewDelegate,UMSocialUIDelegate>
{
    NSString *picUrl;
}
@property (nonatomic,strong)UIImageView*imageView;
@property (nonatomic,strong)UIWebView*web;
@end

@implementation InteractionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"社区详情"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self getCommunityPic];
    [self initUI];
}
- (void)initUI
{
    NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    _web=[[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    _web.delegate=self;
    _web.scalesPageToFit=YES;
    [self.view addSubview:_web];
    [_web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://139.224.43.42/medical/index.php/Admin/H5/interaction?id=%@&uid=%@",_intercationID,uid]]]];
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *URL = request.URL;
    NSString *scheme = [URL host];
    if ([scheme isEqualToString:@"www.baidu.com"])
    {
        if (!_imageView)
        {
            self.imageView.image=[UIImage imageNamed:@"placeholder.png"];
        }
        [UMSocialTool shareTest:self uid:_intercationID pic:_imageView.image];
        return NO;
    }
    return YES;
}
#pragma mark-
#pragma mark-获取数据
- (void)getCommunityPic
{
    [AFManager getReqURL:[NSString stringWithFormat:COMMUNITY_IMAGE_URL,_intercationID] block:^(id infor)
    {
        picUrl=[infor objectForKey:@"img"];
        self.imageView=[[UIImageView alloc]init];
        [_imageView sd_setImageWithURL:[NSURL URLWithString:picUrl] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    } errorblock:^(NSError *error)
    {
        
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
