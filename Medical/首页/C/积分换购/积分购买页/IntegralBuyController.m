//
//  IntegralBuyController.m
//  Medical
//
//  Created by 李壮 on 2016/11/25.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "IntegralBuyController.h"
#import "NSObject+HUD.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import "AddressManager.h"

//mol
#import "IntegralbuyshopBase.h"
#import "IntegralbuyshopData.h"
#import "IntegralbuyshopAddress.h"
#import "IntegralbuyshopYp.h"
@interface IntegralBuyController ()
{
    UIButton *addressBtn;
    UILabel *addressLb;
    UIImageView*drugstoreImage;
    UILabel*drugstore;
    UILabel*medicine;
    UILabel*numLb;
    UILabel*integralNum;
    NSMutableDictionary*addressDic;
    NSMutableDictionary*dataDic;
}
@property (nonatomic,strong)IntegralbuyshopYp*yp;
@property (nonatomic,strong)IntegralbuyshopAddress*address;
@end

@implementation IntegralBuyController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getShopDetail];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"积分换购"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self instanceUI];
}
- (void)instanceUI
{
    addressBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    addressBtn.frame=CGRectMake(0, 64, DEVICE_WIDTH, F_I6_SIZE(65));
    [addressBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addressBtn];
    
    addressLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(15), 64, DEVICE_WIDTH-F_I6_SIZE(30), F_I6_SIZE(65) )];
    addressLb.numberOfLines=0;
    addressLb.textColor=[UIColor wjColorFloat:@"606060"];
    addressLb.font =[UIFont systemFontOfSize:F_I6_SIZE(14)];
    [self.view addSubview:addressLb];
    
    UILabel*payType =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(15), 64+F_I6_SIZE(66), DEVICE_WIDTH-F_I6_SIZE(30), F_I6_SIZE(45))];
    payType.text=@"支付方式";
    payType.font=[UIFont systemFontOfSize:F_I6_SIZE(14)];
    payType.textColor=[UIColor wjColorFloat:@"606060"];
    [self.view addSubview:payType];
    UILabel*integralType =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(15), 64+F_I6_SIZE(66), DEVICE_WIDTH-F_I6_SIZE(30), F_I6_SIZE(45))];
    integralType.text=@"积分换购";
    integralType.textAlignment=2;
    integralType.font=[UIFont systemFontOfSize:F_I6_SIZE(14)];
    integralType.textColor=[UIColor wjColorFloat:@"606060"];
    [self.view addSubview:integralType];
    
    drugstoreImage=[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(15), 64+F_I6_SIZE(122), F_I6_SIZE(25), F_I6_SIZE(25))];
    drugstoreImage.clipsToBounds=YES;
    drugstoreImage.layer.cornerRadius=F_I6_SIZE(25.0f/2);
    [self.view addSubview:drugstoreImage];
    
    drugstore=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(45), F_I6_SIZE(112)+64, DEVICE_WIDTH-F_I6_SIZE(45), F_I6_SIZE(45))];
    drugstore.textColor=[UIColor wjColorFloat:@"606060"];
    drugstore.font=[UIFont systemFontOfSize:F_I6_SIZE(14)];
    [self.view addSubview:drugstore];
    
    medicine=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(40), F_I6_SIZE(158)+64, DEVICE_WIDTH-F_I6_SIZE(40), F_I6_SIZE(40))];
    medicine.font=[UIFont systemFontOfSize:F_I6_SIZE(14)];
    medicine.textColor=[UIColor wjColorFloat:@"606060"];
    [self.view addSubview:medicine];
    
    numLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(40), F_I6_SIZE(158)+64, DEVICE_WIDTH-F_I6_SIZE(40), F_I6_SIZE(40))];
    numLb.font=[UIFont systemFontOfSize:F_I6_SIZE(14)];
    numLb.textAlignment=1;
    numLb.textColor=[UIColor wjColorFloat:@"606060"];
    [self.view addSubview:numLb];
    
    integralNum=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(40), F_I6_SIZE(158)+64, DEVICE_WIDTH-F_I6_SIZE(55), F_I6_SIZE(40))];
    integralNum.font=[UIFont systemFontOfSize:F_I6_SIZE(14)];
    integralNum.textColor=[UIColor wjColorFloat:@"606060"];
    integralNum.textAlignment=2;
    [self.view addSubview:integralNum];
    
    for (NSInteger i=0; i<4; i++)
    {
        UILabel*lineLb=[[UILabel alloc]init];
        lineLb.backgroundColor=Line_Color;
        [self.view addSubview:lineLb];
        if (i==0)
        {
             lineLb.frame=CGRectMake(0, F_I6_SIZE(65)+64, DEVICE_WIDTH, F_I6_SIZE(1));
        }else if (i==3)
        {
            lineLb.frame=CGRectMake(0, 64+F_I6_SIZE(198), DEVICE_WIDTH, F_I6_SIZE(1));
        }else{
            lineLb.frame=CGRectMake(0, 64+F_I6_SIZE(65)+i*F_I6_SIZE(45), DEVICE_WIDTH, F_I6_SIZE(1));
        }
    }
    UIButton *finishBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    finishBtn.frame=CGRectMake(0, DEVICE_HEIGHT-F_I6_SIZE(40), DEVICE_WIDTH, F_I6_SIZE(40));
    finishBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
    [finishBtn setTitle:@"立即换购" forState:0];
    [finishBtn setTitleColor:[UIColor whiteColor] forState:0];
    [finishBtn addTarget:self action:@selector(sureBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finishBtn];
}
- (void)btnClick
{
    [self.navigationController pushViewController:[AddressManager new] animated:YES];
}
- (void)sureBtn
{
    [self getData];
}
#pragma mark-
#pragma mark-填充数据
- (void)setContentData
{
    addressLb.text=[NSString stringWithFormat:@"收货地址：%@先生 %@\n%@",_address.area,_address.mobile,_address.address];
    drugstore.text=_yp.name;
    integralNum.text=_yp.integral;
    [drugstoreImage sd_setImageWithURL:[NSURL URLWithString:[dataDic objectForKey:_yp.picture]] placeholderImage:[UIImage imageNamed:@""]];
    medicine.text=_yp.drugName;
    numLb.text=@"X1";
}
#pragma mark-
#pragma mark-获取数据源
//获取商品订单接口
- (void)getShopDetail
{
    NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:INTEGRSL_SURE_BUY_URL,uid,_ptid] block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            IntegralbuyshopBase*base=[IntegralbuyshopBase modelObjectWithDictionary:infor];
            _yp=base.data.yp;
            _address=base.data.address;
            [self setContentData];
        }
    } errorblock:^(NSError *error)
    {
        
    }];
}
//购买接口
- (void)getData
{
    NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager postReqURL:INTEGRAL_BUY_URL reqBody:@{@"uid":uid,@"pid":_ptid} block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject wj_showHUDWithTip:@"换购成功"];
        }else
        {
            
        }
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
