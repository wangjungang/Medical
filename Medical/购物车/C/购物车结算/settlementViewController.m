//
//  settlementViewController.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "settlementViewController.h"
#import "settleView.h"
#import "SettleFirstCell.h"
#import "SettleSecondCell.h"
#import "SettleThirdCell.h"
#import "SettlelastCell.h"
#import "settlementpayViewController.h"
#import "settleModel.h"
#import "AddressManager.h"

@interface settlementViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float spec;
}
@property (nonatomic,strong) settleView *settview;
@property (nonatomic,strong) UITableView *settTableview;
@property (nonatomic,strong) settleModel *settlem;
@property (nonatomic,strong) NSMutableArray *settleArr;
@property (nonatomic,strong) NSMutableArray *addressarr;
@property (nonatomic,strong) NSMutableArray *statusarr;

@end
static NSString *settletablecell1 = @"settletablecell1";
static NSString *settletablecell2 = @"settletablecell2";
static NSString *settletablecell3 = @"settletablecell3";
static NSString *settletablecell5 = @"settletablecell5";

@implementation settlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"提交订单"];
    
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
   
    [self.view addSubview:self.settview];
    [self.view addSubview:self.settTableview];
    [self loaddatafromweb];
    self.settTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(nameasd:) name:@"defaultname" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mobilesd:) name:@"defaultmobile" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addresssd:) name:@"defaultaddress" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deladdress:) name:@"deladdress" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delname:) name:@"delname" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delphone:) name:@"delphone" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addressid:) name:@"addid" object:nil];
    
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
    self.settview.frame = CGRectMake(0, DEVICE_HEIGHT-45, DEVICE_WIDTH, 45);
    self.settTableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-124);
  
}

-(void)loaddatafromweb
{
    self.settlem = [[settleModel alloc] init];
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    
    [AFManager getReqURL:[NSString stringWithFormat:orderlist,uid,self.dingdan] block:^(id infor) {
        NSLog(@"info = ------ %@",infor);
         if ([[infor objectForKey:@"code"]integerValue]==200)
         {
             NSArray *dit = [infor objectForKey:@"data"];
             self.settleArr = [NSMutableArray array];
             for (int i = 0; i<dit.count; i++) {
                 NSDictionary *dicarr = [dit objectAtIndex:i];
                 self.settlem = [[settleModel alloc] init];
                
                 if (dicarr[@"gid"]==nil||dicarr[@"gid"]==NULL) {
                     self.settlem.drugshopname = dicarr[@"name"];
                     self.settlem.drugnumber = dicarr[@"number"];
                     self.settlem.drugprice = dicarr[@"nowprice"];
                     self.settlem.drugname = dicarr[@"drug_name"];
                     self.settlem.drugshopimageurl = dicarr[@"pictures"];
                 }
                 else
                 {
                     self.settlem.drugshopname = dicarr[@"gname"];
                     self.settlem.drugname = dicarr[@"name"];
                     self.settlem.drugnumber = dicarr[@"number"];
                     self.settlem.drugprice = dicarr[@"nowprice"];
                 }
                 
                 NSString *leave = dicarr[@"level"];
                 if ([leave isEqualToString:@"0"]) {
                     self.settlem.vipstr = @"普通会员";
                 }
                 if ([leave isEqualToString:@"1"]) {
                     self.settlem.vipstr = @"VIP1";
                 }
                 if ([leave isEqualToString:@"2"]) {
                     self.settlem.vipstr = @"VIP2";
                 }
                 if ([leave isEqualToString:@"3"]) {
                     self.settlem.vipstr = @"VIP3";
                 }
                 if ([leave isEqualToString:@"4"]) {
                     self.settlem.vipstr = @"VIP4";
                 }
                 if ([leave isEqualToString:@"5"]) {
                     self.settlem.vipstr = @"VIP5";
                 }
                 if ([leave isEqualToString:@"6"]) {
                     self.settlem.vipstr = @"VIP6";
                 }
                 if ([leave isEqualToString:@"7"]) {
                     self.settlem.vipstr = @"VIP7";
                 }
                 [self.settleArr addObject:self.settlem];
                 
                 spec = [dicarr[@"sprice"] floatValue];
                 self.settlem.totalprice = [NSString stringWithFormat:@"%.2f",spec];
                 
                 self.settview.pricelabel.text = [NSString stringWithFormat:@"%@%.2f",@"¥",spec];
                 if (dicarr[@"shAddress"]==nil||dicarr[@"shAddress"]==NULL) {
                     self.settlem.name = @"请选择地址";
                     self.settlem.address = @" ";
                     self.settlem.phone = @" ";
                 }
                 else
                 {
                     self.settlem.name = dicarr[@"savename"];
                     NSString *address = dicarr[@"shAddress"];
                     NSString *area = dicarr[@"area"];
                     self.settlem.address = [NSString stringWithFormat:@"%@%@",address,area];
                     self.settlem.phone = dicarr[@"mobile"];
                 }
                 
             }
             [self.settTableview reloadData];
             
         }
        
        
    } errorblock:^(NSError *error) {
        
    }];
    
}

#pragma mark - getters

-(settleView *)settview
{
    if(!_settview)
    {
        _settview = [[settleView alloc] init];
        [_settview.settlebtn addTarget:self action:@selector(settbtnclick) forControlEvents:UIControlEventTouchUpInside];
        _settview.layer.masksToBounds = YES;
        _settview.layer.borderWidth = 0.3;
        _settview.layer.borderColor = [[UIColor wjColorFloat:@"cccccc"] CGColor];
    }
    return _settview;
}

-(UITableView *)settTableview
{
    if(!_settTableview)
    {
        _settTableview = [[UITableView alloc] init];
        _settTableview.dataSource = self;
        _settTableview.delegate = self;
        //_settTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_settTableview setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    return _settTableview;
}

#pragma mark -  实现方法

-(void)settbtnclick
{
    NSLog(@"提交订单");
    if ( [self.settlem.name isEqualToString:@"请选择地址"]) {
        [NSObject wj_showHUDWithTip:@"请选择地址"];
    }
    else
    {
        NSString *specstr = [NSString stringWithFormat:@"%.2f",spec];
        NSString *price = [NSString stringWithFormat:@"%@%@",@"支付价格",specstr];
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"支付信息" message:price preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
            
            [AFManager getReqURL:[NSString stringWithFormat:orderbuy,uid,self.dingdan] block:^(id infor) {
                
                if ([[infor objectForKey:@"code"]integerValue]==200)
                {
                    [NSObject wj_showHUDWithTip:@"支付成功"];
                }
                if ([[infor objectForKey:@"code"]integerValue]==201)
                {
                    [NSObject wj_showHUDWithTip:@"支付失败"];
                    
                }
                if ([[infor objectForKey:@"code"]integerValue]==202)
                {
                    [NSObject wj_showHUDWithTip:@"余额不足"];
                }
                
            } errorblock:^(NSError *error) {
                [NSObject wj_showHUDWithTip:@"请检查网络"];
            }];
            
        }];
        [controller addAction:action1];
        [controller addAction:action2];
        [self presentViewController:controller animated:YES completion:nil];
    }
    
    
}

#pragma mark - UITableviewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }
    if (section==1) {
        return self.settleArr.count;
    }
    if (section==2) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            SettleFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:settletablecell1];
            if (!cell) {
                cell = [[SettleFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settletablecell1];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            [cell setCellDate:self.settlem];
            return cell;
        }
        if (indexPath.row==1) {
            SettleSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:settletablecell2];
            if (!cell) {
                cell = [[SettleSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settletablecell2];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setSeparatorInset:UIEdgeInsetsZero];
            return cell;
        }
        
    }
    if (indexPath.section==1) {
        SettleThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:settletablecell3];
        if (!cell) {
            cell = [[SettleThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settletablecell3];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setCellDate:self.settleArr[indexPath.row]];
        return cell;
    }
    if (indexPath.section==2) {
        SettlelastCell *cell = [tableView dequeueReusableCellWithIdentifier:settletablecell5];
        if (!cell) {
            cell = [[SettlelastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settletablecell5];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setCellDate:self.settlem];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 135/2*HEIGHT_SCALE;
        }
        if (indexPath.row==1) {
            return 90/2*HEIGHT_SCALE;
        }
            }
    if (indexPath.section==1) {
        return 120*HEIGHT_SCALE;
    }
    if (indexPath.section==2) {
        return 45*HEIGHT_SCALE;
    }
    return 0;
}

//点击cell方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        AddressManager *addmvc = [[AddressManager alloc] init];
        [self.navigationController pushViewController:addmvc animated:YES];
    }
}

//取消分区区头和区尾高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

#pragma mark - 观察者方法 -KVO通知

-(void)nameasd:(NSNotification *)notifocation
{
    NSString *name  =(NSString *)[notifocation object];
    self.settlem.name = name;
    [self.settTableview reloadData];
    
}

-(void)mobilesd:(NSNotification *)notifocation
{
    NSString *mobile = (NSString *)[notifocation object];
    self.settlem.phone = mobile;
    [self.settTableview reloadData];
}

-(void)addresssd:(NSNotification *)notifocation
{
    NSString *address =(NSString *)[notifocation object];
    self.settlem.address = address;
    [self.settTableview reloadData];
}

-(void)deladdress:(NSNotification *)notifocation
{
    NSString *address =(NSString *)[notifocation object];
    self.settlem.address = address;
    [self.settTableview reloadData];
}

-(void)delname:(NSNotification *)notifocation
{
    NSString *name =(NSString *)[notifocation object];
    self.settlem.name = name;
    [self.settTableview reloadData];
}

-(void)delphone:(NSNotification *)notifocation
{
    NSString *phone =(NSString *)[notifocation object];
    self.settlem.phone = phone;
    [self.settTableview reloadData];
}

-(void)addressid:(NSNotification *)notifocation
{
    NSString *addressid =(NSString *)[notifocation object];
//    self.settlem.phone = phone;
//    [self.settTableview reloadData];
    NSLog(@"addressid = %@",addressid);
    
}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
