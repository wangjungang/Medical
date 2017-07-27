//
//  JiFenHuangouViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "JiFenHuangouViewController.h"
#import "JifenHuangouCell.h"
//积分mol
#import "ListShopIntegralBase.h"
#import "ListShopIntegralData.h"
//
#import "NSObject+HUD.h"
//药品详情
#import "detailsViewController.h"
@interface JiFenHuangouViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger page;
//    NSMutableArray *integralDataAry;
}
@property (nonatomic,strong)UICollectionView *collectionView;

@end

@implementation JiFenHuangouViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kCOLOR(210, 210, 210, 1);
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"积分商城"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self createCollectionView];
    
    NSArray *viewsArray = self.navigationController.viewControllers;
    NSLog(@"viewsArray===%lu",(unsigned long)viewsArray.count);
    if (viewsArray.count == 3 )
    {
        
    }
    if (viewsArray.count == 2) {
        _integralDataAry=[NSMutableArray array];
        [self getIntegralShopListData];
        [self addInfinte];

    }

    
}
-(void)createCollectionView
{
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2 *WIDTH_SCALE;
        layout.minimumInteritemSpacing = 1 *HEIGHT_SCALE;
        layout.itemSize = CGSizeMake(DEVICE_WIDTH/2 - 2 *WIDTH_SCALE , 155 *HEIGHT_SCALE);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT - 64) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.contentInset = UIEdgeInsetsMake(25, 15, 0, 15);
        _collectionView.backgroundColor = kCOLOR(210, 210, 210, 0.3);
        [_collectionView registerClass:[JifenHuangouCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_collectionView];
        _collectionView.alwaysBounceVertical=YES;
       
    }
    
}
#pragma mark --UICollectionView代理方法--
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _integralDataAry.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JifenHuangouCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
    if (_integralDataAry.count!=0)
    {
        [cell setItemContentData:_integralDataAry[indexPath.item]];
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    detailsViewController*detailsVc=[detailsViewController new];
    ListShopIntegralData*data=_integralDataAry[indexPath.item];
    detailsVc.pid=[NSString stringWithFormat:@"%@",data.ptid];
    detailsVc.newprice=[NSString stringWithFormat:@"%@",data.nowprice];
    detailsVc.drugnamestr=[NSString stringWithFormat:@"%@",data.drugName];
    detailsVc.isIntegral=YES;
    [self.navigationController pushViewController:detailsVc animated:YES];
}
#pragma mark-
#pragma mark-上拉加载更多
- (void)addInfinte
{
    __weak JiFenHuangouViewController*sl=self;
    
    [sl.collectionView addInfiniteScrollingWithActionHandler:^{
        page+=1;
        [self getIntegralShopListData];
    }];
    [_collectionView triggerInfiniteScrolling];
}
#pragma mark-
#pragma mark-获取数据源
//获取积分数据
- (void)getIntegralShopListData
{
    [AFManager getReqURL:[NSString stringWithFormat:INTEGRSL_SHOP_LIST_URL,page,@"20"] block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            ListShopIntegralBase*integralBase=[ListShopIntegralBase modelObjectWithDictionary:infor];
            [_integralDataAry addObjectsFromArray:integralBase.data];
            [_collectionView reloadData];
        }else
        {
            if (_integralDataAry.count==0) {
                [NSObject wj_showHUDWithTip:@"暂时没有任何数据"];
            }else{
                [NSObject wj_showHUDWithTip:@"已经全部加载了"];
            }
        }
        [_collectionView.infiniteScrollingView stopAnimating];
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
