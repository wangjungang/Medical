//
//  CommonProblemController.m
//  Medical
//
//  Created by 李壮 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "CommonProblemController.h"
#import "NSString+Extend.h"
#import "LZProblemBase.h"
#import "LZProblemData.h"
#import "NSObject+MBProgressHUD.h"
@interface CommonProblemController ()
{
    UILabel *titleLb;
    UILabel *contentLb;
    UIScrollView*scrollView;
    NSMutableArray *problemAry;
    MBProgressHUD*_MB;
}
@end

@implementation CommonProblemController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"常见问题"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor=[UIColor whiteColor];
    problemAry=[NSMutableArray array];
    [self setData];
    [self createUI];
}
- (void)createUI
{
    scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
    [self.view addSubview:scrollView];
}
- (void)createData
{
    UILabel*lastTwoContentLb;
    for (NSInteger i=0; i<problemAry.count; i++)
    {
        titleLb = [[UILabel alloc]init];
        LZProblemData*data=problemAry[i];
        titleLb.numberOfLines=0;
        CGFloat titleLbHeight=[data.title getHeightWithFontSize:F_I6_SIZE(16) andConstrainedWidth:DEVICE_WIDTH-F_I6_SIZE(20)];
        if (lastTwoContentLb) {
            titleLb.frame=CGRectMake(0, lastTwoContentLb.frame.origin.y+lastTwoContentLb.frame.size.height, DEVICE_WIDTH, titleLbHeight);
        }else{
            titleLb.frame=CGRectMake(0, 0, DEVICE_WIDTH, titleLbHeight);
        }
        titleLb.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
        titleLb.backgroundColor =[UIColor wjColorFloat:@"b9b9b9"];
        NSMutableAttributedString*text1=[[NSMutableAttributedString alloc]initWithString:data.title];
        //设置字体颜色
            
        //设置缩进、行距
        
        NSMutableParagraphStyle *style1 = [[NSMutableParagraphStyle alloc] init];
        style1.headIndent = F_I6_SIZE(10);//缩进
        style1.firstLineHeadIndent = F_I6_SIZE(10);
        [text1 addAttribute:NSParagraphStyleAttributeName value:style1 range:NSMakeRange(0, text1.length)];
        titleLb.attributedText=text1;
        titleLb.textColor=[UIColor whiteColor];
        [scrollView addSubview:titleLb];
        
        CGFloat height=[data.content getHeightWithFontSize:F_I6_SIZE(16) andConstrainedWidth:DEVICE_WIDTH-F_I6_SIZE(20) ];
        contentLb =[[UILabel alloc]initWithFrame:CGRectMake(0,titleLb.frame.origin.y+titleLb.frame.size.height, DEVICE_WIDTH, height)];
        contentLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
        contentLb.textColor=[UIColor wjColorFloat:@"c0c0c0"];
        NSMutableAttributedString*text=[[NSMutableAttributedString alloc]initWithString:data.content];
        //设置字体颜色
        
        [text addAttribute:NSForegroundColorAttributeName value:[UIColor wjColorFloat:@"c0c0c0"] range:NSMakeRange(0, text.length)];
        
        //设置缩进、行距
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.headIndent = F_I6_SIZE(10);//缩进
        style.firstLineHeadIndent = F_I6_SIZE(42);
        [text addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
        lastTwoContentLb=contentLb;
        contentLb.numberOfLines=0;
        contentLb.attributedText=text;
        [scrollView addSubview:contentLb];
    }
    CGFloat scrollHeight=lastTwoContentLb.frame.origin.y+lastTwoContentLb.frame.size.width>(DEVICE_HEIGHT-64)?lastTwoContentLb.frame.origin.y+lastTwoContentLb.frame.size.width:(DEVICE_HEIGHT-64);
    scrollView.contentSize=CGSizeMake(DEVICE_WIDTH, scrollHeight);
}
- (void)setData
{
    _MB=[NSObject showHUDView:self.view MBText:@"正在加载"];
    [AFManager getReqURL:PROBLEM_URL block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            LZProblemBase*base=[LZProblemBase modelObjectWithDictionary:infor];
            [problemAry addObjectsFromArray:base.data];
            [self createData];
        }
        [_MB hide:YES];
        _MB=nil;
    } errorblock:^(NSError *error)
    {
        _MB=nil;
        [_MB hide:YES];
    }];
}
- (void)test
{
//    [AFManager getReqURL:@"http://139.224.43.42/medical/index.php/Admin/Api/html" block:^(id infor) {
//        NSLog(@"%@",infor);
//        UIWebView *web=[[UIWebView alloc]initWithFrame:self.view.frame];
//        [self.view addSubview:web];
//        [web loadHTMLString:[infor objectForKey:@"data"] baseURL:nil];
//    } errorblock:^(NSError *error) {
//        
//    }];
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
