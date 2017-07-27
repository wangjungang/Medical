//
//  ClinicViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "ClinicViewController.h"
#import "RSTFocusImage.h"
//详情页
#import "DetailClinvController.h"
//单例tabbar
#import "CustomTabbarViewController.h"
//
#import "WebViewController.h"
//
#import "NSObject+HUD.h"
//定位经纬度
#import "ZYLocationKit.h"
//mol诊所列表
#import "ClinicListBase.h"
#import "ClinicListData.h"
//轮播mol
#import "HeardImageClinicBase.h"
#import "HeardImageClinicData.h"
//cel
#import "ClinicTableViewCell.h"

@interface ClinicViewController ()<UITableViewDelegate,UITableViewDataSource,RSTFocusImageDelegate>
{
    NSInteger page;
    CGFloat   lat;
    CGFloat   lon;
    NSMutableArray *dataAry;
    NSMutableArray *imageAry;
}
@property(nonatomic,strong)UITableView*litab;
@end

@implementation ClinicViewController

static NSString* ClinicTableViewCellID= @"ClinicTableViewCell";
- (void)viewWillAppear:(BOOL)animated
{
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar showTabbar];
    [ZYLocationKit getUserLocation:^(CLLocation* item) {
        NSLog(@"%f=======%f",item.coordinate.latitude,item.coordinate.longitude);
        lat=item.coordinate.latitude;
        lon=item.coordinate.longitude;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:nil leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"诊所"];
    [self.view addSubview:customNavView];
    [self createTable];
    dataAry =[NSMutableArray array];
    imageAry=[NSMutableArray array];
    
}
- (void)createTable
{
    if (!_litab)
    {
        _litab =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64-44) style:UITableViewStyleGrouped];
        _litab.dataSource=self;
        _litab.delegate=self;
        _litab.rowHeight=F_I6_SIZE(167/2);
        [self.view addSubview:_litab];
        [_litab registerClass:[ClinicTableViewCell class] forCellReuseIdentifier:ClinicTableViewCellID];
        [self getHeaderImage];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addInfinte];
            [self addPullRefresh];
        });
    }else
    {
        [_litab reloadData];
    }
}
#pragma mark-
#pragma mark-table协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClinicTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:ClinicTableViewCellID forIndexPath:indexPath];
    
    ClinicListData*data;
    if (dataAry.count!=0)
    {
        data=dataAry[indexPath.row];
    }
    [cell setCellContent:data];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailClinvController*detail=[DetailClinvController new];
    ClinicListData*data=dataAry[indexPath.row];
    detail.clinvID=data.dataIdentifier;
    detail.phone =data.phone;
    detail.chetTitle=data.name;
    detail.targedId=data.ltid;
   [ self.navigationController pushViewController:detail animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
#pragma mark-
#pragma mark-***************轮播图协议方法****************
- (void)tapFocusWithIndex:(NSInteger)index
{
//    WebViewController*webView=[WebViewController new];
//    webView.loadUrl=@"http://www.baidu.com";
//    [self.navigationController pushViewController:webView animated:YES];
}
//#pragma mark-
//#pragma mark-上拉加载更多
//- (void)addInfinte
//{
//    __weak ClinicViewController*sl=self;
//    
//    [sl.litab addInfiniteScrollingWithActionHandler:^{
//        page+=1;
//        [self getDataList];
//    }];
//    [_litab triggerInfiniteScrolling];
//}
//- (void)addPullRefresh
//{
//    __weak ClinicViewController*sl=self;
//    [sl.litab addPullToRefreshWithActionHandler:^{
//        page=1;
//        [dataAry removeAllObjects];
//        [self getDataList];
//    }];
////    [_litab triggerPullToRefresh];
//}
#pragma mark-
#pragma mark-上拉加载更多
- (void)addInfinte
{
    _litab.mj_footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page+=1;
        [self getDataList];
    }];
}
- (void)addPullRefresh
{
    _litab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [dataAry removeAllObjects];
        [self getDataList];
    }];
    [_litab.mj_header beginRefreshing];
}
#pragma mark-
#pragma mark-获取数据源
//获取诊所列表
- (void)getDataList
{
    //40.113659 116.293508
    [AFManager getReqURL:[NSString stringWithFormat:GET_CLINIC_LIST_URL,page,@"15",lat,lon] block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            ClinicListBase*base=[ClinicListBase modelObjectWithDictionary:infor];
            if (base.data.count==0&&dataAry.count==0)
            {
                 [NSObject wj_showHUDWithTip:@"附近没有符合的诊所"];
            }else if(base.data.count==0)
            {
                 [NSObject wj_showHUDWithTip:@"已经全部加载了"];
            }else
            {
                [dataAry addObjectsFromArray:base.data];
                [self createTable];
                [NSObject wj_showHUDWithTip:@"获取成功"];
            }
        }else
        {
             [NSObject wj_showHUDWithTip:@"已经全部加载了"];
        }
//        [_litab.pullToRefreshView stopAnimating];
//        [_litab.infiniteScrollingView stopAnimating];
        [_litab.mj_header endRefreshing];
        [_litab.mj_footer endRefreshing];
    } errorblock:^(NSError *error)
    {
        [NSObject wj_showHUDWithTip:@"获取失败"];
//        [_litab.infiniteScrollingView stopAnimating];
//        [_litab.pullToRefreshView stopAnimating];
        [_litab.mj_header endRefreshing];
        [_litab.mj_footer endRefreshing];
    }];
}
//轮播
- (void)getHeaderImage
{
    [AFManager getReqURL:[NSString stringWithFormat:HEARD_IMAGE_URL,@"4"] block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            HeardImageClinicBase*imageBase=[HeardImageClinicBase modelObjectWithDictionary:infor];
            [imageAry removeAllObjects];
            [imageAry addObjectsFromArray:imageBase.data.picture];
            
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, F_I6_SIZE(208))];
            RSTFocusImage*RSImage=[[RSTFocusImage alloc]initWithFrame:view.frame Images:imageAry Placeholder:[UIImage imageNamed:@"placeholder.png"]];
            RSImage.delegate=self;
            RSImage.interval=2;
            [view addSubview:RSImage];
            _litab.tableHeaderView=view;
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
