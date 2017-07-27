//
//  detailsViewController.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "detailsViewController.h"
#import "IntegralBuyController.h"
#import "NSObject+MBProgressHUD.h"
#define KMedical_oringe @"FE7201"

//定位经纬度
#import "ZYLocationKit.h"
#import "settlementViewController.h"

//默认地址
#import "myaddressModel.h"
@interface detailsViewController ()
{
    CGFloat lon;
    CGFloat lat;
    NSString *address;
}
@property (nonatomic,strong) UIButton *buybtn;
@property (nonatomic,strong) UIButton *shopcartbtn;
@property (nonatomic,strong) UIWebView *detailwebview;
@property (nonatomic,strong) UIButton *huangoubtn;

@property (nonatomic,strong) NSMutableArray *addressarr;
@property (nonatomic,strong) myaddressModel *myaddmodel;

@property (nonatomic,strong) NSMutableArray *addidarr;
@property (nonatomic,strong) NSMutableArray *addstatusarr;
@property (nonatomic,strong) NSString *addidstr;
@end

@implementation detailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:self.drugnamestr];

    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.view addSubview:self.detailwebview];
    
    if (self.isIntegral ==YES) {
        [self.view addSubview:self.huangoubtn];
    }else
    {
        [self.view addSubview:self.shopcartbtn];
        [self.view addSubview:self.buybtn];
    }
    self.addressarr = [NSMutableArray array];
    [self loadaddress];
    self.addidarr = [NSMutableArray array];
    self.addstatusarr = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
    
    [ZYLocationKit getUserLocation:^(CLLocation* item) {
        NSLog(@"%f %f",item.coordinate.latitude,item.coordinate.longitude);
        lat=item.coordinate.latitude;
        lon=item.coordinate.longitude;
    }];
    NSLog(@"pid=-----------%@",self.pid);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([self.xiangqingtype isEqualToString:@"guoyitang"]) {
            NSString*url=[NSString stringWithFormat:guoDetial,self.pid];
            // NSString*url=[NSString stringWithFormat:guoDetial,self.pid];
            [self.detailwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];

        }
        else  {
            NSString*url=[NSString stringWithFormat:detial,self.pid,lon,lat];
            // NSString*url=[NSString stringWithFormat:guoDetial,self.pid];
            [self.detailwebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        }

        });
}

-(void)loadaddress
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:AddressListURL,uid] block:^(id infor)
     {
         NSLog(@"info = %@",infor);
         NSArray *dit = [infor objectForKey:@"data"];
         self.addressarr = [NSMutableArray array];
         for (int i = 0; i<dit.count; i++) {
             self.myaddmodel = [[myaddressModel alloc] init];
             NSDictionary *dicarr = [dit objectAtIndex:i];
             self.myaddmodel.addressname = dicarr[@"savename"];
             self.myaddmodel.addressmobile = dicarr[@"mobile"];
             self.myaddmodel.address = dicarr[@"address"];
             self.myaddmodel.area = dicarr[@"area"];
             self.myaddmodel.isdefault = dicarr[@"status"];
             self.myaddmodel.addid = dicarr[@"id"];
             [self.addressarr addObject:self.myaddmodel];
             [self.addidarr addObject:dicarr[@"id"]];
             [self.addstatusarr addObject:dicarr[@"status"]];
         }
         NSLog(@"addressarr===%@",self.addressarr);
         NSInteger index = [self.addstatusarr indexOfObject:@"0"];
         NSLog(@"index=========%ld",index);
         
         self.addidstr = [self.addidarr objectAtIndex:index];
         
         NSLog(@"addistr=====%@",self.addidstr);
     } errorblock:^(NSError *error)
     {
         NSLog(@"%@",error);
     }];

}

#pragma mark - getters

-(UIButton *)shopcartbtn
{
    if(!_shopcartbtn)
    {
        _shopcartbtn = [[UIButton alloc] init];
        _shopcartbtn.backgroundColor=[UIColor wjColorFloat:KMedical_Blue];
        [_shopcartbtn setTitle:@"加入购物车" forState:0];
        [_shopcartbtn setImage:[UIImage imageNamed:@"图层32.png"] forState:0];
        _shopcartbtn.titleLabel.textColor=[UIColor whiteColor];
        _shopcartbtn.frame=CGRectMake(0, DEVICE_HEIGHT-49, DEVICE_WIDTH/2, 49);
        [_shopcartbtn setImageEdgeInsets:UIEdgeInsetsMake(12, 0, 12, 0)];
        [_shopcartbtn addTarget:self action:@selector(shopcarbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopcartbtn;
}

-(UIButton *)buybtn
{
    if(!_buybtn)
    {
        _buybtn = [[UIButton alloc] init];
        _buybtn.backgroundColor = [UIColor wjColorFloat:KMedical_oringe];
        [_buybtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buybtn setImage:[UIImage imageNamed:@"图层33"] forState:UIControlStateNormal];
        _buybtn.titleLabel.textColor = [UIColor whiteColor];
        _buybtn.frame=CGRectMake(DEVICE_WIDTH/2, DEVICE_HEIGHT-49, DEVICE_WIDTH/2, 49);
        [_buybtn setImageEdgeInsets:UIEdgeInsetsMake(12, 0, 12, 0)];
        [_buybtn addTarget:self action:@selector(buybtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buybtn;
}

-(UIButton *)huangoubtn
{
    if(!_huangoubtn)
    {
//        _huangoubtn = [[UIButton alloc] init];
        [_huangoubtn setTitle:@"换购" forState:UIControlStateNormal];
        _huangoubtn.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
        _huangoubtn.frame = CGRectMake(0, DEVICE_HEIGHT-49, DEVICE_WIDTH, 49);
        [_huangoubtn addTarget:self action:@selector(huangoubtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _huangoubtn;
}

-(UIWebView *)detailwebview
{
    if(!_detailwebview)
    {
        _detailwebview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64-49)];
    }
    return _detailwebview;
}

#pragma mark - 实现方法

-(void)shopcarbtnClick
{
    UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:@"选择加入购物车的数量" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
        UITextField *numbertext = alertcontrol.textFields.firstObject;
        numbertext.keyboardType = UIKeyboardTypeNumberPad;
        NSString *number = numbertext.text;
        NSString *pid = self.pid;
        
        CGFloat total = [self.newprice floatValue]*[number floatValue];
        
        NSString *totalprice = [NSString stringWithFormat:@"%.2f",total];
        NSDate *date=[NSDate date];//获取当前时间
        NSDateFormatter *format1=[[NSDateFormatter alloc]init];
        [format1 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
        NSString *str1=[format1 stringFromDate:date];
        
        if ([self.xiangqingtype isEqualToString:@"guoyitang"]) {
            [AFManager postReqURL:addcart reqBody:@{@"uid":uid,@"number":number,@"gid":pid,@"totalprice":totalprice,@"addtime":str1} block:^(id infor) {
                NSLog(@"info===%@",infor);
                if ([[infor objectForKey:@"code"]integerValue]==200) {
                    [NSObject wj_showHUDWithTip:@"添加成功"];
                }
            }];
        }else
        {
            [AFManager postReqURL:addcart reqBody:@{@"uid":uid,@"number":number,@"pid":pid,@"totalprice":totalprice,@"addtime":str1} block:^(id infor) {
                NSLog(@"info===%@",infor);
                if ([[infor objectForKey:@"code"]integerValue]==200) {
                    [NSObject wj_showHUDWithTip:@"添加成功"];
                }
            }];
        }
        
    }];
    [alertcontrol addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
       textField.placeholder = @"输入数量";
    }];
    [alertcontrol addAction:action];
    [alertcontrol addAction:action2];
    [self presentViewController:alertcontrol animated:YES completion:nil];
    
}

-(void)buybtnClick
{
    NSLog(@"立即购买");
    
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    NSDate *date=[NSDate date];//获取当前时间
    NSDateFormatter *format1=[[NSDateFormatter alloc]init];
    [format1 setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    NSString *str1=[format1 stringFromDate:date];
    
    NSInteger arcdom=arc4random();
    NSString *idStr=[NSString stringWithFormat:@"%ld",(long)arcdom];
    NSDate* today = [NSDate date];
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* s1 = [df stringFromDate:today];
    NSDate* date1 = [df dateFromString:s1];
    NSDateFormatter*df2 = [[NSDateFormatter alloc]init];//格式化
    [df2 setDateFormat:@"yyyyMMddHHmmss"];
    [df2 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
    NSLog(@"data===%@",[df2 stringFromDate:date1]);
    
    NSString *dingdanstr  = [NSString stringWithFormat:@"%@%@%@",[df2 stringFromDate:date1],uid,idStr];
    
    NSDictionary *dit = [NSDictionary dictionary];
    
    if ([self.xiangqingtype isEqualToString:@"guoyitang"]) {
        dit = @{@"ouid":uid,@"gid":self.pid,@"aid":@"1",@"gnum":@"1",@"sprice":self.newprice,@"order":dingdanstr,@"order_addtime":str1};
    }
    else
    {
        dit = @{@"ouid":uid,@"pid":self.pid,@"oyid":self.oyid,@"aid":@"1",@"number":@"1",@"sprice":self.newprice,@"order":dingdanstr,@"order_addtime":str1};
    }
    
    NSLog(@"dit--------------%@",dit);
    
    [AFManager postReqURL:buyorder reqBody:dit block:^(id infor) {
        
        NSLog(@"info===%@",infor);
        if ([[infor objectForKey:@"code"]integerValue]==200) {
            [NSObject wj_showHUDWithTip:@"添加成功"];
            settlementViewController *settleVC = [[settlementViewController alloc] init];
            settleVC.dingdan = dingdanstr;
            [self.navigationController pushViewController:settleVC animated:YES];
            
        }else if ([[infor objectForKey:@"code"]integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"请检查网络"];
        }
        
    }];
    
}

-(void)huangoubtnclick
{
//    IntegralBuyController*buyC=[IntegralBuyController new];
//    buyC.ptid=_pid;
//    [self.navigationController pushViewController:buyC animated:YES];
}

@end
