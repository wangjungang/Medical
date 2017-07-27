//
//  MedicalViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "MedicalViewController.h"
#import "pharmarcyTableViewCell.h"
#import "storeViewController.h"
#import "alertView.h"
#import "CWStarRateView.h"
#import "pharmacyModel.h"
//定位经纬度
#import "ZYLocationKit.h"

@interface MedicalViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat   lat;
    CGFloat   lon;
    NSInteger   page;
    NSInteger   num;
    BOOL isRefreshing;
    BOOL isLoading;
}
@property (nonatomic,strong) UITableView *pharmacyTableview;
@property (nonatomic,strong) NSMutableArray *pharymcyArray;
@property (nonatomic,strong) NSMutableArray *phararr;
@property (nonatomic,strong) alertView *alertHud;
@property (nonatomic,strong) pharmacyModel *pharmacym;
@end

@implementation MedicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:nil leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"药店"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    self.phararr = [NSMutableArray array];
    page = 1;
    isLoading = YES;
    isRefreshing = NO;
    
    [self loaddatafromweb];
    [self.view addSubview:self.pharmacyTableview];
    [self pullRefresh];
    [self addLoadMore];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pharmacyTableview.frame = CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64);
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar showTabbar];
    [ZYLocationKit getUserLocation:^(CLLocation* item) {
        NSLog(@"%f %f",item.coordinate.latitude,item.coordinate.longitude);
        lat=item.coordinate.latitude;
        lon=item.coordinate.longitude;
    }];
    
   //[self messagealert];
}

#pragma mark ---下拉刷新

-(void)pullRefresh
{
    self.pharmacyTableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (isRefreshing == YES) {
            page = 1;
            [self loaddatafromweb];
        }
        isRefreshing = YES;
        [self.pharmacyTableview.mj_header endRefreshing];
        // 隐藏时间
       
    }];
    [self.pharmacyTableview.mj_header beginRefreshing];
}

//上拉加载更多

-(void)addLoadMore
{
    self.pharmacyTableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (isLoading == YES) {
            page++;
            NSLog(@"page===%ld",page);
            [self loaddatafromweb];
        }
        isLoading = YES;
        [self.pharmacyTableview.mj_footer endRefreshing];
        
    }];
    
}

#pragma mark - 数据源方法 

-(void)loaddatafromweb
{
    num = 10;
    self.pharymcyArray = [NSMutableArray array];
    
    [AFManager getReqURL:[NSString stringWithFormat:houstlist,lon,lat,page,num] block:^(id infor) {
        NSLog(@"info = %@",infor);
        
         if ([[infor objectForKey:@"code"]integerValue]==200)
         {
             
             if (page==1) {
                 [self.phararr removeAllObjects];
                 [self.pharmacyTableview.mj_footer resetNoMoreData];
             }
             
             if ([infor[@"data"] count]<num) {
                 [self.pharmacyTableview.mj_footer endRefreshingWithNoMoreData];
             }
             NSArray *dit = [infor objectForKey:@"data"];
             
             for (int i = 0; i<dit.count; i++) {
                 NSDictionary *dicarr = [dit objectAtIndex:i];
                 self.pharmacym = [[pharmacyModel alloc] init];
                 self.pharmacym.pharmacyImageurl = dicarr[@"picture"];
                 self.pharmacym.pharmacyName = dicarr[@"name"];
                 self.pharmacym.pharamcyNumbar = dicarr[@"scale"];
                 self.pharmacym.pharamcyDistance = [NSString stringWithFormat:@"%@%@",dicarr[@"distance"],@"m"];
                 self.pharmacym.star = [dicarr[@"star"] floatValue]/5;
                 self.pharmacym.pharamcyid = dicarr[@"id"];
                 [self.phararr addObject:self.pharmacym];
             }
             [self.pharymcyArray addObjectsFromArray:self.phararr];
             
             [self.pharmacyTableview reloadData];
             
         }
         else if([[infor objectForKey:@"cdoe"] integerValue]==201)
         {
             [NSObject wj_showHUDWithTip:@"已经加载全部"];
             if (page == 1) {
                 [self.phararr removeAllObjects];
                 
                 [self.pharmacyTableview.mj_footer endRefreshingWithNoMoreData];
                 
             }
         }
        
        
    } errorblock:^(NSError *error) {
        NSLog(@"error = %@",error);
        [NSObject wj_showHUDWithTip:@"请检查网络"];
        
    }];
    
}

#pragma mark - getters

-(UITableView *)pharmacyTableview
{
    if(!_pharmacyTableview)
    {
        _pharmacyTableview = [[UITableView alloc] init];
        _pharmacyTableview.dataSource = self;
        _pharmacyTableview.delegate = self;
       
    }
    return _pharmacyTableview;
}

-(alertView *)alertHud
{
    if(!_alertHud)
    {
        _alertHud = [[alertView alloc] initWithFrame:CGRectMake(DEVICE_WIDTH/2-90, DEVICE_HEIGHT/2-50, 180*WIDTH_SCALE, 60*HEIGHT_SCALE)];
        _alertHud.image = [UIImage imageNamed:@"组44"];
    }
    return _alertHud;
}

#pragma mark - UITableviewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.pharymcyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellidentfid = @"identfid1";
    pharmarcyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentfid];
    
    cell = [[pharmarcyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentfid];
    [cell setCellDate:self.pharymcyArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.0f*HEIGHT_SCALE;
}

//点击cell方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    storeViewController *specVC = [[storeViewController alloc] init];
    specVC.typestr = @"yaodian";
    pharmacyModel *model=self.pharymcyArray[indexPath.row];
    specVC.pharid = model.pharamcyid;
    specVC.shopname = model.pharmacyName;
    [self.navigationController pushViewController:specVC animated:YES];
}

#pragma mark - 实现方法

-(void)aldrthudclick
{
    [self.view addSubview:self.alertHud];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.alertHud removeFromSuperview];
    });
}

#pragma mark - 提示信息

-(void)messagealert
{
    UIAlertController *control = [UIAlertController alertControllerWithTitle:@"该功能尚未开放" message:@"敬请期待下次更新" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [control addAction:action];
    
    [self presentViewController:control animated:YES completion:nil];
}

@end
