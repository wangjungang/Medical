//
//  settlementpayViewController.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "settlementpayViewController.h"
#import "payCell.h"
#import "AlipayModels.h"
#import "ZhifuWanchengViewController.h"
#import "WechatPayModel.h"
//#import "FinishPayController.h"
@interface settlementpayViewController ()<UITableViewDataSource,UITableViewDelegate,myTabVdelegate>
{
    BOOL zhifu;
    UITextField *moneyTF;
    NSString *nickName;
    NSString *moneyStr;
}
@property (nonatomic,strong) UITableView *paytableview;

@property (nonatomic,strong) UIButton *paybtn;
@property (nonatomic,strong) NSMutableArray *imagearr;

@end
static NSString *paycellidentfid = @"paycellidentfid";
@implementation settlementpayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(payNoti) name:@"chongzhichenggong" object:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"支付"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [self loaddatafromweb];
    
    [self.view addSubview:self.paytableview];
    [self.view addSubview:self.paybtn];
    
    self.imagearr = [NSMutableArray arrayWithObjects:@"组19",@"椭圆5", nil];
    zhifu =YES;
    [self createChongzhiView];
}
-(void)payNoti
{
    ZhifuWanchengViewController *zhifuwanhcengVC = [ZhifuWanchengViewController new] ;
    zhifuwanhcengVC.nameStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
    zhifuwanhcengVC.moneyStr = moneyTF.text;
    [self.navigationController pushViewController:zhifuwanhcengVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.paytableview.frame = CGRectMake(0, 64 + 133/2, DEVICE_WIDTH, 133*HEIGHT_SCALE);
    self.paybtn.frame = CGRectMake(DEVICE_WIDTH/2-40, DEVICE_HEIGHT/2-20, 80, 40);

}
-(void)createChongzhiView
{
   
      UILabel * moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(16*WIDTH_SCALE,64 + (133/4-20)*HEIGHT_SCALE, DEVICE_WIDTH/2 - 40*WIDTH_SCALE, 40*WIDTH_SCALE)];
    moneyLabel.text = @"请输入金额：";
    moneyLabel.textColor = [UIColor wjColorFloat:@"666666"];
    moneyLabel.textAlignment = NSTextAlignmentLeft;
    moneyLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE];
    [self.view addSubview:moneyLabel];
    moneyTF = [[UITextField alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2, 64 , DEVICE_WIDTH/2 -20, 133/2*HEIGHT_SCALE)];
    moneyTF.placeholder = @"请输入金额";
    moneyTF.keyboardType = UIKeyboardTypeDecimalPad;
    moneyTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:moneyTF];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (64 + 133/2 -10) *HEIGHT_SCALE, DEVICE_WIDTH, 1 *HEIGHT_SCALE)];
    lineLabel.backgroundColor = Line_Color;
    [self.view addSubview:lineLabel];
 
}
-(void)loaddatafromweb
{
        
}

#pragma mark - getters

-(UITableView *)paytableview
{
    if(!_paytableview)
    {
        _paytableview = [[UITableView alloc] init];
        _paytableview.dataSource = self;
        _paytableview.delegate = self;
        _paytableview.scrollEnabled = NO;
        
    }
    return _paytableview;
}

-(UIButton *)paybtn
{
    if(!_paybtn)
    {
        _paybtn = [[UIButton alloc] init];
        _paybtn.backgroundColor = [UIColor wjColorFloat:@"13caca"];
        [_paybtn setTitleColor:[UIColor wjColorFloat:@"ffffff"] forState:UIControlStateNormal];
        _paybtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_paybtn addTarget:self action:@selector(paybtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_paybtn setTitle:@"确认支付" forState:UIControlStateNormal];
        _paybtn.layer.masksToBounds = YES;
        _paybtn.layer.cornerRadius = 5;
    }
    return _paybtn;
}

#pragma mark - UITableviewDataSource && UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
        payCell * _cell = [tableView dequeueReusableCellWithIdentifier:paycellidentfid];
        _cell = [[payCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:paycellidentfid];
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _cell.delegate = self;

        if (indexPath.row==0) {
            _cell.paynamelabel.text = @"支付宝";
            _cell.itemimage.image = [UIImage imageNamed:@"zhifubao"];
            [_cell.pointbtn setImage:[UIImage imageNamed:self.imagearr[0]] forState:UIControlStateNormal];
        }
        
        
        if (indexPath.row==1) {
            _cell.paynamelabel.text = @"微信";
            _cell.itemimage.image = [UIImage imageNamed:@"weixin"];
            [_cell.pointbtn setImage:[UIImage imageNamed:self.imagearr[1]] forState:UIControlStateNormal];
        }
        
        [_cell setSeparatorInset:UIEdgeInsetsZero];
        
        return _cell;
    

        
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 133/2 *HEIGHT_SCALE;
}

#pragma mark - 实现方法

-(void)paybtnclick
{
    NSLog(@"支付按钮");
    if (zhifu ==YES) {
        NSLog(@"支付宝");
        if ([moneyTF.text isEqualToString:@""])
        {
            [NSObject wj_alterSingleVCWithOneTitle:@"请输入金额" andTwoTitle:nil andSelfVC:self];
        }
        if (![moneyTF.text isEqualToString:@""])
        {
            [self alipay];
        }
        
    }
    else
    {
        NSLog(@"微信");
        if ([moneyTF.text isEqualToString:@""])
        {
            [NSObject wj_alterSingleVCWithOneTitle:@"请输入金额" andTwoTitle:nil andSelfVC:self];
        }
        if (![moneyTF.text isEqualToString:@""])
        {
            [self wechatPay];
        }
    }
}
#pragma mark --支付宝支付--
-(void)alipay
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:Alipay_URL,uid,moneyTF.text] block:^(id infor) {
        NSLog(@"alipay===%@",infor);
        nickName = infor[@"data"][@"nick_name"];
        [AlipayModels alipayModelWithOrderid:infor[@"data"][@"order"] withName:infor[@"data"][@"name"] withMoney:infor[@"data"][@"money"] withNotify:infor[@"data"][@"notify_url"] withViewcontroller:self];
    } errorblock:^(NSError *error) {
        
    }];
}

#pragma mark --微信支付--
-(void)wechatPay
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:@"http://139.224.43.42/medical/index.php/Admin/Wxpay/wxpay?uid=%@&money=%@",uid,moneyTF.text] block:^(id infor) {
        NSLog(@"weixin===%@",infor);
        [WechatPayModel WeiXinPay:infor[@"data"]];
    } errorblock:^(NSError *error) {
        
    }];
}
//实现代理
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSIndexPath *index = [_paytableview indexPathForCell:cell];
    
    if (indexPath.row==0) {
        self.imagearr = [NSMutableArray arrayWithObjects:@"组19",@"椭圆5", nil];
        [self.paytableview reloadData];
        zhifu = YES;
    }
    else
    {
        self.imagearr = [NSMutableArray arrayWithObjects:@"椭圆5",@"组19", nil];
        [self.paytableview reloadData];
        zhifu = NO;
    }

}
-(void)myTabVClick:(UITableViewCell *)cell
{
}

@end
