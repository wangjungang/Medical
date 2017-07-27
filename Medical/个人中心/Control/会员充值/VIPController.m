//
//  VIPController.m
//  Medical
//
//  Created by 李壮 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "VIPController.h"

@interface VIPController ()

@end

@implementation VIPController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"会员充值"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor=[UIColor whiteColor];
    [self createUI];
}
- (void)createUI
{
    NSArray*btnAry=@[@"充值100元",@"充值200元",@"充值300元",@"充值400元"];
    NSArray*vipNumAry=@[@"VIP1",@"VIP2",@"VIP3",@"VIP4"];
    for (NSInteger i=0; i<4; i++) {
        UILabel *frame=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(10)+64+F_I6_SIZE(60)*i, DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(50))];
        frame.layer.borderColor=[kCOLOR(210, 210, 210, 0.3)CGColor];
        frame.layer.borderWidth=F_I6_SIZE(1);
        [self.view addSubview:frame];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(12.5), F_I6_SIZE(29), F_I6_SIZE(26))];
        image.image =[UIImage imageNamed:@"图层19.png"];
        [frame addSubview:image];
        
        UILabel*vipLb =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(39), F_I6_SIZE(21.5), F_I6_SIZE(50), F_I6_SIZE(18))];
        vipLb.text=vipNumAry[i];
        vipLb.textColor=[UIColor wjColorFloat:@"ff6927"];
        [frame addSubview:vipLb];
        
        UILabel*contentLb =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(90), F_I6_SIZE(12.5), F_I6_SIZE(135), F_I6_SIZE(30))];
        contentLb.numberOfLines=0;
        contentLb.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        contentLb.textColor=[UIColor wjColorFloat:@"c0c0c0"];
        contentLb.text=@"进入社区诊所和药店都要扣一定的元宝。";
        [frame addSubview:contentLb];
        
        UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        btn.backgroundColor = [UIColor wjColorFloat:@"ff6927"];
        btn.layer.cornerRadius=5;
        btn.clipsToBounds=YES;
        btn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(110), F_I6_SIZE(11), F_I6_SIZE(80), F_I6_SIZE(28));
        btn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
        [btn setTitle:btnAry[i] forState:0];
        btn.tag=100+i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [frame addSubview:btn];
    }
}
- (void)btnClick:(UIButton*)btn
{
    
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
