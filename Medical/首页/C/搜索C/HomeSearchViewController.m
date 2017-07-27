//
//  HomeSearchViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "HomeSearchViewController.h"
#import "ZYLocationKit.h"
#import "HospitalViewController.h"
#import "ClinicViewController.h"
#import "JiFenHuangouViewController.h"
//积分mol
#import "ListShopIntegralBase.h"
#import "ListShopIntegralData.h"
@interface HomeSearchViewController ()<UITextFieldDelegate>
{
     UIView *_custonNavView;
    UIButton *_typeButton;
    UIView *_typeView ;
    CGFloat   lat;
    CGFloat   lon;
    UITextField *searchTF;
    UIImageView *typeImageView;
    NSArray *titleArray;
    NSString *typeStr;
}
@end

@implementation HomeSearchViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
    [ZYLocationKit getUserLocation:^(CLLocation* item) {
        NSLog(@"%f=======%f",item.coordinate.latitude,item.coordinate.longitude);
        lat=item.coordinate.latitude;
        lon=item.coordinate.longitude;
        
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    titleArray = [[NSArray alloc] initWithObjects:@"医院",@"诊所",@"商品", nil];
    [self createCustomHomeNav];
    [self createTypeView];
    
        typeStr = @"1";
    
}
-(void)createCustomHomeNav
{
    _custonNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    _custonNavView.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
    [self.view addSubview:_custonNavView];
    
    
    searchTF = [[UITextField alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2 - 125 *WIDTH_SCALE, 28, 250*WIDTH_SCALE, 25)];
    searchTF.attributedPlaceholder =[[NSAttributedString alloc] initWithString:@"  药品 / 症状 / 品牌" attributes:@{NSStrokeColorAttributeName:kCOLOR(191, 237, 238, 1),NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    searchTF.borderStyle = UITextBorderStyleNone;
    searchTF.clipsToBounds = YES;
    searchTF.layer.cornerRadius = 11;
    searchTF.backgroundColor = [UIColor wjColorFloat:@"5adadd"];
    UIImageView *leftView = [[UIImageView alloc] init];
    leftView.frame = CGRectMake(-35 *WIDTH_SCALE, 0, 20*WIDTH_SCALE, 25);
    leftView.image = [UIImage imageNamed:@"search"];
    leftView.contentMode = UIViewContentModeCenter;
    searchTF.leftView = leftView;
    searchTF.leftViewMode = UITextFieldViewModeAlways;
    searchTF.returnKeyType = UIReturnKeySearch;
    searchTF.delegate = self;
    searchTF.font = [UIFont systemFontOfSize:14 *WIDTH_SCALE];
    searchTF.textColor = kCOLOR(191, 237, 238, 1);
    [_custonNavView addSubview:searchTF];

    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame = CGRectMake(DEVICE_WIDTH - 50*WIDTH_SCALE, 32, 50 *WIDTH_SCALE, 20);
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
     cancelButton.titleLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE weight:2*WIDTH_SCALE];
//    cancelButton.backgroundColor = [UIColor redColor];
    cancelButton.imageEdgeInsets = UIEdgeInsetsMake(2, 38*WIDTH_SCALE, 2, 0*WIDTH_SCALE);
    [_custonNavView addSubview:cancelButton];
    
    _typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _typeButton.frame = CGRectMake(20 *WIDTH_SCALE, 32,40 *WIDTH_SCALE, 20);
    _typeButton.backgroundColor = [UIColor redColor];
    [_typeButton setTitle:@"医院" forState:UIControlStateNormal];
//    _typeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [_typeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10*WIDTH_SCALE, 0, 10)];
//    _typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _typeButton.titleLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE weight:2*WIDTH_SCALE];
    [_typeButton setImage:[UIImage imageNamed:@"下拉-1"] forState:UIControlStateNormal];
    _typeButton.imageEdgeInsets = UIEdgeInsetsMake(10, 32 *WIDTH_SCALE, 3, 2*WIDTH_SCALE);
    [_typeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_typeButton addTarget:self action:@selector(typeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_custonNavView addSubview:_typeButton];
    
}
-(void)cancelButtonClick:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"点击搜索");
    [self getRequestSearch];
    return YES;
}
static int a = 0;
-(void)typeButtonClick
{
    
    a ++;
    if (a%2 == 1)
    {
        typeImageView.hidden = NO;
        
    }
    if (a%2 == 0)
    {
        typeImageView.hidden = YES;
    }
}

-(void)createTypeView
{
    _typeView = [[UIView alloc] initWithFrame:CGRectMake(5 *WIDTH_SCALE, 52, 80 *WIDTH_SCALE, 105 *HEIGHT_SCALE)];
    _typeView.backgroundColor = [UIColor whiteColor];
    _typeView.hidden = YES;
//    [self.view addSubview:_typeView];
    typeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5 *WIDTH_SCALE, 52, 80 *WIDTH_SCALE, 105 *HEIGHT_SCALE)];
    typeImageView.userInteractionEnabled = YES;
    typeImageView.image = [UIImage imageNamed:@"bg"];
    typeImageView.hidden = YES;
    [self.view addSubview:typeImageView];
    for (int i = 0; i <3; i ++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
//        button.backgroundColor = [UIColor redColor];
        [typeImageView addSubview:button];
        button.tag = 100 +i;
        button.frame = CGRectMake(0 *HEIGHT_SCALE  , 15 * HEIGHT_SCALE + i * 30 *HEIGHT_SCALE,  80 *WIDTH_SCALE  ,  30 *HEIGHT_SCALE);
        button.titleLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE weight:2*WIDTH_SCALE];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 15 * HEIGHT_SCALE +( i + 1)* 30 *HEIGHT_SCALE, 60 *WIDTH_SCALE, 1 *HEIGHT_SCALE)];
        lineLabel.backgroundColor = [UIColor whiteColor];
        [typeImageView addSubview:lineLabel];
    }
    
}
-(void)buttonClick:(UIButton *)button
{
    a++;
    typeImageView.hidden = YES;
    typeStr = [NSString stringWithFormat:@"%ld",(long)button.tag +1 - 100];
    [_typeButton setTitle:titleArray[button.tag - 100] forState:UIControlStateNormal];
}
-(void)getRequestSearch
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    
    [AFManager getReqURL:[NSString stringWithFormat:Search_URL,typeStr,searchTF.text,@"1",@"10",uid,lon,lat] block:^(id infor) {
        NSLog(@"typeStr ==== %@",typeStr);
        NSLog(@"url====%@",[NSString stringWithFormat:Search_URL,typeStr,searchTF.text,@"1",@"10",uid,lon,lat]);
        NSLog(@"******infor === %@",infor);
        if ([[infor objectForKey:@"code"] integerValue] == 200)
        {
            if([typeStr isEqualToString:@"1"])
            {
                //医院
              HospitalViewController *hospitalVC =  [HospitalViewController new];
                HospitalListDataModels *dataModels = [HospitalListDataModels modelObjectWithDictionary:infor];
                NSMutableArray *dataArray = [[NSMutableArray alloc] init];
                [dataArray addObjectsFromArray:dataModels.data];
                hospitalVC.dataModelsArray = dataArray;
                [self.navigationController pushViewController:hospitalVC animated:YES];
            }
            if([typeStr isEqualToString:@"2"])
            {
                //诊所
            }
            if([typeStr isEqualToString:@"3"])
            {
                //商品
                JiFenHuangouViewController *jifenVC = [JiFenHuangouViewController new];
                ListShopIntegralBase*integralBase=[ListShopIntegralBase modelObjectWithDictionary:infor];
                NSMutableArray *dataArray = [[NSMutableArray alloc] init];
                [dataArray addObjectsFromArray:integralBase.data];
                jifenVC.integralDataAry = dataArray;
                [self.navigationController pushViewController:jifenVC animated:YES];
            }
        }
        if ([[infor objectForKey:@"code"] integerValue] == 201)
        {
            [NSObject wj_alterSingleVCWithOneTitle:@"没有搜索到任何数据" andTwoTitle:nil andSelfVC:self];
        }
        if ([[infor objectForKey:@"code"] integerValue] == 202)
        {
            [NSObject wj_alterSingleVCWithOneTitle:@"请输入您想要搜索的内容" andTwoTitle:nil andSelfVC:self];
        }
        if ([[infor objectForKey:@"code"] integerValue] == 205)
        {
            [NSObject wj_alterSingleVCWithOneTitle:@"搜索失败，请重试" andTwoTitle:nil andSelfVC:self];
        }
        
    } errorblock:^(NSError *error) {
        
    }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    
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
