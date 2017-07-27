//
//  CaseViewController.m
//  Medical
//
//  Created by 李壮 on 2016/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "CaseViewController.h"
//病例详细
#import "CaseDetailController.h"
//增加病例
#import "MyCaseController.h"
//
#import "MyCaseListCell.h"
#import "LZAlertView.h"
#import "NSObject+MBProgressHUD.h"
@interface CaseViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView*litab;
    NSMutableArray *caseListAry;
    MBProgressHUD*_MB;
}
@property (nonatomic,strong)CustomNavigation *customNavView;
@end

@implementation CaseViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
     [self getData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [_customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"添加" title:@"我的病例"];
    [self.view addSubview:_customNavView];
    __weak CaseViewController *weakSelf=self;
    
    weakSelf.customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    weakSelf.customNavView.CustomNavRightBtnClickBlock=^{
        MyCaseController*myCase=[MyCaseController new] ;
        myCase.isAdd=YES;
        [self.navigationController pushViewController:myCase animated:YES];
    };
    self.view.backgroundColor =[UIColor whiteColor];
   
    caseListAry =[NSMutableArray array];
}
- (void)createTable
{
    if (!litab) {
        litab =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64) style:UITableViewStyleGrouped];
        litab.dataSource=self;
        litab.delegate=self;
        litab.rowHeight=F_I6_SIZE(50);
        [self.view addSubview:litab];
        [litab registerClass:[MyCaseListCell class] forCellReuseIdentifier:@"cell"];
    }else{
        [litab reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return caseListAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    MyCaseListCell*cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (caseListAry.count!=0)
    {
        [cell setCellContent:caseListAry[indexPath.section]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CaseDetailController*caseDetail=[CaseDetailController new];
    if (caseListAry.count!=0) {
        MyCaseListDataModel*data=caseListAry[indexPath.section];
        caseDetail.name=data.userName;
        caseDetail.caseName=data.disease;
        caseDetail.caseCount=data.details;
        caseDetail.bid=data.bid;
    }
    
    [self.navigationController pushViewController:caseDetail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0?0.1f:5.0f;
}
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self delegateCase:caseListAry[indexPath.section]];
}
#pragma mark-
#pragma mark-获取数据
- (void)getData
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    _MB=[NSObject showHUDView:self.view MBText:@"正在加载"];
   [ AFManager getReqURL:[NSString stringWithFormat:CASE_LIST_URL,uid] block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
           MyCaseListBaseModel*base =[MyCaseListBaseModel modelObjectWithDictionary:infor];
            [caseListAry removeAllObjects];
            [caseListAry addObjectsFromArray:base.data];
            [self createTable];
            
        }else
        {
            [caseListAry removeAllObjects];
            if (litab)
            {
                [litab reloadData];
            }
            [[LZAlertView getInstance]getAlertView:self title:@"温馨提示" messgae:@"您还没有创建病例" alertStyle:1 cancleBtnTitle:@"我知道了"];
            [[LZAlertView getInstance]show];
        }
        [_MB hide:YES];
        _MB=nil;
    } errorblock:^(NSError *error)
    {
        [_MB hide:YES];
         _MB=nil;
    }];
}
- (void)delegateCase:(MyCaseListDataModel*)data
{
     NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    _MB=[NSObject showHUDView:self.view MBText:@"请稍后"];
    [AFManager getReqURL:[NSString stringWithFormat:DELEGATE_CASE_URL,uid,data.bid] block:^(id infor) {
        
        if ([[infor objectForKey:@"code"]integerValue]==200) {
            [self getData];
        }else{
            [NSObject showHUDView:self.view MBText:@"操作失败"];
        }
        [_MB hide:YES];
        _MB=nil;
    } errorblock:^(NSError *error) {
        [_MB hide:YES];
        _MB=nil;
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
