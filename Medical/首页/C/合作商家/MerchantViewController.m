//
//  MerchantViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "MerchantViewController.h"
#import "MerchantCell.h"
#import "MerchantDetailsViewController.h"
//合作商家mol
#import "JoinHandelShopBase.h"
#import "JoinHandelData.h"
@interface MerchantViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSMutableArray *dataListAry;
    BOOL isRefreshing;
    BOOL isLoading;
}
@property (nonatomic,strong)UITableView *tableView;
@end

@implementation MerchantViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    page = 1;
    isLoading = YES;
    isRefreshing = NO;
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"合作商家"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self createTableView];
    [self getDataList];
    dataListAry=[NSMutableArray array];
}
#pragma mark --创建TableView--
-(void)createTableView
{
    if (!_tableView)
    {
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT ) style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints =NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionFooterHeight = 0;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_tableView registerClass:[MerchantCell class] forCellReuseIdentifier:@"Cell"];
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
        [self pullRefresh];
        [self addLoadMore];
    }else{
        [_tableView reloadData];
    }
}

#pragma mark --UITableView代理---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"*******%lu",(unsigned long)dataListAry.count);
    return dataListAry.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setCellCongtent:dataListAry[indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
          return 200 *HEIGHT_SCALE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0.1 *HEIGHT_SCALE;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击进入商家详情%ld",indexPath.row);
    MerchantDetailsViewController *detailsVC = [MerchantDetailsViewController new];
    JoinHandelData*data=dataListAry[indexPath.row];
    detailsVC.type=data.type;
    detailsVC.ID=data.Identifier;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
#pragma mark-
#pragma mark-上拉加载更多
#pragma mark ---下拉刷新
-(void)pullRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (isRefreshing == YES) {
            page = 1;
            [self getDataList];
        }
        isRefreshing = YES;
        [self.tableView.mj_header endRefreshing];
    }];
    [self.tableView.mj_header beginRefreshing];
}
//上拉加载更多
-(void)addLoadMore
{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (isLoading == YES) {
            page++;
            NSLog(@"page===%ld",page);
            [self getDataList];
        }
        isLoading = YES;
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}
/*
- (void)addInfinte
{
    _tableView.mj_footer=[MJRefreshAutoFooter footerWithRefreshingBlock:^{
        page+=1;
        [self getDataList];
        [ _tableView.mj_footer endRefreshing];
    }];
    [_tableView.mj_footer beginRefreshing];
}
- (void)addPullRefresh
{
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [dataListAry removeAllObjects];
        [self getDataList];
        [_tableView.mj_header endRefreshing];
    }];
    
}*/
#pragma mark-
#pragma mark-获取数据源
- (void)getDataList
{
    [AFManager getReqURL:[NSString stringWithFormat:JOIN_HANDS_SHOP_URL,page,@"1"] block:^(id infor)
    {
        NSLog(@"info===%@",infor);
        if ([[infor objectForKey:@"code"] integerValue]==200)
        {
            if (page == 1)
            {
                [dataListAry removeAllObjects];
                [self.tableView.mj_footer resetNoMoreData];
                
            }
            if ([infor[@"data"] count]<3) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            JoinHandelShopBase*base=[JoinHandelShopBase modelObjectWithDictionary:infor];
            [dataListAry addObjectsFromArray:base.data];
            
            [_tableView reloadData];
            
        }
        else if([[infor objectForKey:@"code"] integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"已经加载全部"];
            
            if (page == 1) {
                [dataListAry removeAllObjects];
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
            }
        }
        

    } errorblock:^(NSError *error) {
        
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
