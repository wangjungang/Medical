//
//  HospitalViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "HospitalViewController.h"
#import "HospitalCell.h"
#import "HospitalDetailsViewController.h"
#import "HomeSearchViewController.h"
@interface HospitalViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    
    NSInteger page;
    BOOL isRefreshing;
    BOOL isLoading;
}
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation HospitalViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 1;
    isLoading = YES;
    isRefreshing = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"合作医院"];
    self.view.backgroundColor = [UIColor whiteColor];
    
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
//
    [self createCollectionView];
    [self.view addSubview:customNavView];
    NSArray *viewsArray = self.navigationController.viewControllers;
    NSLog(@"viewsArray===%lu",(unsigned long)viewsArray.count);
    if (viewsArray.count == 3 )
    {
        
    }
    if (viewsArray.count == 2) {
        _dataModelsArray = [[NSMutableArray alloc] init];
        [self getRequestHospitalList];
    }
    
}
-(void)getRequestHospitalList
{
    [AFManager getReqURL:[NSString stringWithFormat:Hospital_List_URL,page,@"15"] block:^(id infor) {
        NSLog(@"info===%@",infor);
        if ([[infor objectForKey:@"code"] integerValue]==200)
        {
            if (page == 1)
            {
                [_dataModelsArray removeAllObjects];
                [self.collectionView.mj_footer resetNoMoreData];
                
            }
            if ([infor[@"data"] count]<15) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }
            HospitalListDataModels *dataModels = [HospitalListDataModels modelObjectWithDictionary:infor];
            [_dataModelsArray addObjectsFromArray:dataModels.data];
            [_collectionView reloadData];
            
        }
        else if([[infor objectForKey:@"code"] integerValue]==201)
        {
            [NSObject wj_showHUDWithTip:@"已经加载全部"];
                
            if (page == 1) {
                [_dataModelsArray removeAllObjects];
            
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                
            }
        }

    } errorblock:^(NSError *error) {
         [NSObject wj_showHUDWithTip:@"获取失败"];
    }];
}
-(void)createCollectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 10 *WIDTH_SCALE;
        layout.minimumInteritemSpacing = 1 *HEIGHT_SCALE;
        layout.itemSize = CGSizeMake(DEVICE_WIDTH/3 - 20 *WIDTH_SCALE , 125 *HEIGHT_SCALE);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT - 64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.contentInset = UIEdgeInsetsMake(2, 0, 0, 0);
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[HospitalCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_collectionView];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self pullRefresh];
            [self addLoadMore];
//        });
    }
    
}
#pragma mark ---下拉刷新
-(void)pullRefresh
{
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (isRefreshing == YES) {
            page = 1;
            [self getRequestHospitalList];
        }
        isRefreshing = YES;
        [self.collectionView.mj_header endRefreshing];
    }];
     [self.collectionView.mj_header beginRefreshing];
}
//上拉加载更多
-(void)addLoadMore
{
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (isLoading == YES) {
            page++;
            NSLog(@"page===%ld",page);
            [self getRequestHospitalList];
        }
        isLoading = YES;
        [self.collectionView.mj_footer endRefreshing];

  }];
    

}
#pragma mark --UICollectionView代理方法--
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataModelsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HospitalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor purpleColor];
    [cell getHospitalListDataSource:_dataModelsArray indexPath:indexPath];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击医院%ld",indexPath.item);
    HospitalDetailsViewController *detailsVC = [HospitalDetailsViewController new];
    HospitalListData *data  = _dataModelsArray[indexPath.item];
    detailsVC.detailsID = data.dataIdentifier;
    [self.navigationController pushViewController:detailsVC animated:YES];
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
