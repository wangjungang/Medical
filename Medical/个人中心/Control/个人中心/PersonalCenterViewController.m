//
//  PersonalCenterViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "PersonalTableViewCell.h"
//融云KIT
#import <RongIMKit/RongIMKit.h>

//表头View
#import "HeaderView.h"
//账户管理
#import "AccountManagerController.h"
//地址管理
#import "AddressManager.h"
//我的病例
#import "CaseViewController.h"
//意见反馈
#import "FeedbackController.h"
//常见问题
#import "CommonProblemController.h"
//账户余额
#import "AccountMoneyController.h"
//会员充值
#import "VIPController.h"
//完成付款
#import "FinishPayController.h"
//待付款
#import "waitpayViewController.h"

//mol
#import "UserInfoBase.h"
#import "UserInfoData.h"

#import "UserHeaderBase.h"
#import "UserHeaderUser.h"
#import "RongChetController.h"
@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource,HeaderViewDelegate>
{
    UITableView *litab;
}
@property (nonatomic,strong)UserInfoData*data;
@property (nonatomic,strong)HeaderView*headerView;
@end

@implementation PersonalCenterViewController
static NSString*PersonalTableViewCellID=@"PersonalTableViewCell";
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController*tabbar =[CustomTabbarViewController instanceTabBar];
    [tabbar showTabbar];
    self.navigationController.navigationBar.hidden=YES;
    [self getUserInfoData];
    [self RongUserInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    // Do any additional setup after loading the view.
    [self createTable];
    self.view.backgroundColor =[UIColor whiteColor];
}
- (void)createTable
{
    if (!litab)
    {
        litab =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT-49) style:UITableViewStylePlain];
        litab.dataSource=self;
        litab.delegate=self;
        [self.view addSubview:litab];
        litab.rowHeight=F_I6_SIZE(58);
        [litab registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:@"PersonalTableViewCell"];
        litab.separatorStyle=UITableViewCellSeparatorStyleNone;
        litab.tableHeaderView=self.headerView;
    }else
    {
        [litab reloadData];
    }
}
- (HeaderView*)headerView
{
    if (!_headerView) {
        _headerView=[[HeaderView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, F_I6_SIZE(210))];
        _headerView.delegate=self;
    }
    return _headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    PersonalTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"PersonalTableViewCell" forIndexPath:indexPath];
    [cell setCellContentIndexPath:indexPath];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[AddressManager new] animated:YES];
        }
            break;
        case 1:
            [self.navigationController pushViewController:[VIPController new] animated:YES];
        
            break;
        case 2:
        {
            [self.navigationController pushViewController:[CommonProblemController new] animated:YES];
        }
            break;
        case 3:
        {
             [self rongChet];
        }
            break;
        case 4:
        {
            [self.navigationController pushViewController:[CaseViewController new] animated:YES];
        }
            break;
        case 5:
        {
             [self.navigationController pushViewController:[FeedbackController new] animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)getbtnIndex:(NSInteger)btnTag
{
    switch (btnTag) {
        case 100:
            [self.navigationController pushViewController:[waitpayViewController new] animated:YES];
            break;
        case 101:
            [self.navigationController pushViewController:[FinishPayController new] animated:YES];
            break;
        case 102:
        {
            AccountMoneyController*accountMoney=[AccountMoneyController new];
            accountMoney.money=_data.money;
            [self.navigationController pushViewController:accountMoney animated:YES];
        }
            break;
        case 103:
            [self.navigationController pushViewController:[AccountManagerController new] animated:YES];
            break;
        default:
            break;
    }
}
#pragma mark-
#pragma mark-获取数据源
//获取用户信息
- (void)getUserInfoData
{
    NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:USER_INFO_RUL,uid] block:^(id infor)
    {
        NSLog(@"user====%@",infor);
        if ([[infor objectForKey:@"code"]integerValue]==200) {
            UserInfoBase*base=[UserInfoBase modelObjectWithDictionary:infor];
            _data=base.data;
            [ [NSUserDefaults standardUserDefaults]setObject:@"nickName" forKey:_data.nickName];
            [self.headerView setViewContent:_data];
           
        }
    } errorblock:^(NSError *error) {
        
    }];
}
- (void)RongUserInfo
{
    [AFManager getReqURL:[NSString stringWithFormat:@"http://139.224.43.42/medical/index.php/Admin/Api/getShow?uid=%@",[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil]] block:^(id infor)
     {
         UserHeaderBase*headerUser=[UserHeaderBase modelObjectWithDictionary:infor];
         [NSKeyedArchiver archiveRootObject:headerUser.user toFile:RONG_USER_INFO];
     } errorblock:^(NSError *error)
     {
         
     }];
}
#pragma mark-
#pragma mark-融云客服
- (void)rongChet
{
    RongChetController*chat=[[RongChetController alloc]init];
    chat.targetId=@"kefu111";
    chat.conversationType=ConversationType_PRIVATE;
    chat.title=@"客服";
    [self.navigationController pushViewController:chat animated:YES];
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
