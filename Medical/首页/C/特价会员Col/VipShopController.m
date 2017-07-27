//
//  VipShopController.m
//  Medical
//
//  Created by 李壮 on 2016/12/3.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "VipShopController.h"
#import "pharmarcySales.h"
#import "pharmarcyPrice.h"
#import "medicineCollectionViewCell.h"
#import "detailsViewController.h"
#import "SDCursorView.h"
#import "ShowViewController.h"
//mol
#import "VIPShopListModelsBase.h"
#import "VIPShopListModelsData.h"
#import "VIPShopListModelsProducts.h"
#import "SonVipController.h"
@interface VipShopController ()
{
    NSMutableArray *titleAry;
    NSMutableArray *dataAry;
}
@property (nonatomic,strong) pharmarcySales *sales;
@property (nonatomic,strong) pharmarcyPrice *prices;
@property (nonatomic, strong) SDCursorView *cursorView;
@end

@implementation VipShopController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:self.shopname];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    
    
    [self.view addSubview:self.sales];
    [self.view addSubview:self.prices];
    titleAry=[NSMutableArray array];
    dataAry=[NSMutableArray array];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    if (self.tpye)
    {
        [self getVipShopList];
    }else
    {
        [self getbargainsShopList];
    }
}
#pragma mark-
#pragma mark-获取数据源
- (void)getVipShopList
{
    [AFManager getReqURL:VIP_SHOP_LIST_URL block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            VIPShopListModelsBase*base=[VIPShopListModelsBase modelObjectWithDictionary:infor];
            _cursorView = [[SDCursorView alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), 40)];
            _cursorView.contentViewHeight = CGRectGetHeight(self.view.bounds)-100;
            NSMutableArray *vc=[NSMutableArray array];
            for (VIPShopListModelsData*data in base.data)
            {
                [titleAry addObject:data.name];
                SonVipController*view=[[SonVipController alloc]init];
                view.shopData=data;
                [vc addObject:view];
                
            }
            _cursorView.controllers=vc;
            _cursorView.parentViewController = self;
            _cursorView.titles = titleAry;
            //设置字体和颜色
            _cursorView.normalColor = [UIColor blackColor];
            _cursorView.selectedColor = [UIColor wjColorFloat:KMedical_Blue];
            _cursorView.selectedFont = [UIFont systemFontOfSize:16];
            _cursorView.normalFont = [UIFont systemFontOfSize:13];
            _cursorView.backgroundColor = [UIColor whiteColor];
            _cursorView.lineView.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
            
            [self.view addSubview:_cursorView];
            
            //属性设置完成后，调用此方法绘制界面
            [_cursorView reloadPages];
            
        }
    } errorblock:^(NSError *error)
    {
        
    }];
}
- (void)getbargainsShopList
{
    [AFManager getReqURL:BARGAINS_SHOP_URL block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            VIPShopListModelsBase*base=[VIPShopListModelsBase modelObjectWithDictionary:infor];
            _cursorView = [[SDCursorView alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), 40)];
            _cursorView.contentViewHeight = CGRectGetHeight(self.view.bounds)-100;
            NSMutableArray *vc=[NSMutableArray array];
            for (VIPShopListModelsData*data in base.data)
            {
                [titleAry addObject:data.name];
                SonVipController*view=[[SonVipController alloc]init];
                 view.shopData=data;
                [vc addObject:view];
            }
            _cursorView.controllers=vc;
            _cursorView.parentViewController = self;
            _cursorView.titles = titleAry;
            //设置字体和颜色
            _cursorView.normalColor = [UIColor blackColor];
            _cursorView.selectedColor = [UIColor wjColorFloat:KMedical_Blue];
            _cursorView.selectedFont = [UIFont systemFontOfSize:16];
            _cursorView.normalFont = [UIFont systemFontOfSize:13];
            _cursorView.backgroundColor = [UIColor whiteColor];
            _cursorView.lineView.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
            
            [self.view addSubview:_cursorView];
            
            //属性设置完成后，调用此方法绘制界面
            [_cursorView reloadPages];
        }
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
