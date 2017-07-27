//
//  CaseController.m
//  Medical
//
//  Created by 李壮 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "CaseDetailController.h"
#import "MyCaseController.h"
#import "NSString+Extend.h"
@interface CaseDetailController ()
{
    UILabel*nameLb;
    UILabel*caseName;
    UILabel*canontnLb;
}
@end

@implementation CaseDetailController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"修改" title:@"我的病例"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    customNavView.CustomNavRightBtnClickBlock=^{
        MyCaseController*myCase=[MyCaseController new];
        myCase.isAdd=NO;
        myCase.name=_name;
        myCase.caseName=_caseName;
        myCase.caseAbout=_caseCount;
        myCase.caseID=_bid;
        [self.navigationController pushViewController:myCase animated:YES];
    };
    self.view.backgroundColor =[UIColor whiteColor];
    [self createUI];
}
- (void)createUI
{
    nameLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), 64, DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(40))];
    nameLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
    
    nameLb.text=[NSString stringWithFormat:@"姓名：%@",_name];
    [self.view addSubview:nameLb];
    
    caseName =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), 64+F_I6_SIZE(40), DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(40))];
    caseName.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
    caseName.text=[NSString stringWithFormat:@"病症名称：%@",_caseName];
    [self.view addSubview:caseName];
    
    UILabel*lable = [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(80)+64, DEVICE_WIDTH, F_I6_SIZE(40))];
    lable.text=@"病症介绍:";
    lable.font =[UIFont systemFontOfSize:16];
    [self.view addSubview:lable];
    
    canontnLb =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(120)+64, DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(300))];
    canontnLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
    canontnLb.numberOfLines=0;
    canontnLb.text=_caseCount;
    [self.view addSubview:canontnLb];
    CGFloat height=[_caseCount getHeightWithFontSize:F_I6_SIZE(16) andConstrainedWidth:DEVICE_WIDTH-F_I6_SIZE(20)];
    canontnLb.frame=CGRectMake(F_I6_SIZE(10), F_I6_SIZE(120)+64, DEVICE_WIDTH-F_I6_SIZE(20), height+F_I6_SIZE(10));
    UILabel *lineLb =[[UILabel alloc]initWithFrame:CGRectMake(0, canontnLb.frame.origin.y+height+F_I6_SIZE(20), DEVICE_WIDTH, F_I6_SIZE(1))];
    lineLb.backgroundColor =Line_Color;
    [self.view addSubview:lineLb];
    
    for (NSInteger i=0; i<2; i++) {
        UILabel *lineLb=[[UILabel alloc]initWithFrame:CGRectMake(0, 64+F_I6_SIZE(40)*(i+1), DEVICE_WIDTH, F_I6_SIZE(1))];
        lineLb.backgroundColor =Line_Color;
        [self.view addSubview:lineLb];
    }
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
