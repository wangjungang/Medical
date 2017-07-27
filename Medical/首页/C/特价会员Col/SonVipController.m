//
//  SonVipController.m
//  Medical
//
//  Created by 李壮 on 2016/12/3.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "SonVipController.h"
#import "medicineCollectionViewCell.h"
#import "detailsViewController.h"
#import "pharmarcyPrice.h"
#import "pharmarcySales.h"
#import "VIPShopListModelsProducts.h"
@interface SonVipController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView*collectionview;
@property (nonatomic,strong) pharmarcySales *sales;
@property (nonatomic,strong) pharmarcyPrice *prices;
@end

@implementation SonVipController
static NSString *collection = @"imagecell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.sales.frame = CGRectMake(0, 0, DEVICE_WIDTH/2, 40);
    self.prices.frame = CGRectMake(DEVICE_WIDTH/2, 0, DEVICE_WIDTH/2, 40);
    [self.view addSubview:self.sales];
    [self.view addSubview:self.prices];
    [self loadCollection];
}
- (UIColor *)randomColor
{
    static BOOL seeded = NO;
    if(!seeded) {
        seeded = YES;
        srandom((unsigned)time(NULL));
    }
    CGFloat red = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark -  UICollectionView

-(void)loadCollection
{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, DEVICE_WIDTH, DEVICE_HEIGHT-140) collectionViewLayout:flowLayout];
    //设置代理
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.backgroundColor = [UIColor whiteColor];
    //注册cell和ReusableView（相当于头部）
    _collectionview.allowsMultipleSelection = YES;//默认为NO,是否可以多选
    
    
#pragma mark -- 注册单元格
    
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    
    [self.collectionview registerClass:[medicineCollectionViewCell class] forCellWithReuseIdentifier:collection];
    [self.view addSubview:self.collectionview];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate && UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shopData.products.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    medicineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collection forIndexPath:indexPath];
    [cell setCellData:self.shopData.products[indexPath.item]];
    cell.layer.borderColor = Line_Color.CGColor;
    cell.layer.borderWidth=1;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((DEVICE_WIDTH-12)/2, (DEVICE_WIDTH-12)/2);
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    detailsViewController *detailsVC = [[detailsViewController alloc] init];
    
    VIPShopListModelsProducts *model = self.shopData.products[indexPath.item];
    detailsVC.xiangqingtype = @"yaodian";
    detailsVC.pid=model.ptid;
    detailsVC.newprice = model.nowprice;
    detailsVC.drugnamestr = model.drugName;
    detailsVC.oyid=model.yid;
    [self.navigationController pushViewController:detailsVC animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - getters

-(pharmarcySales *)sales
{
    if(!_sales)
    {
        _sales = [[pharmarcySales alloc]init];
        [_sales addTarget:self action:@selector(scaleclick) forControlEvents:UIControlEventTouchUpInside];
        [_sales.layer setMasksToBounds:YES];
        [_sales.layer setBorderColor:Line_Color.CGColor];
        [_sales.layer setBorderWidth:1];
    }
    return _sales;
}

-(pharmarcyPrice *)prices
{
    if(!_prices)
    {
        _prices = [[pharmarcyPrice alloc] init];
        [_prices addTarget:self action:@selector(priceclick) forControlEvents:UIControlEventTouchUpInside];
        [_prices.layer setMasksToBounds:YES];
        [_prices.layer setBorderColor:Line_Color.CGColor];
        [_prices.layer setBorderWidth:1];
    }
    return _prices;
}

#pragma mark - 实现方法
// 销量按钮
-(void)scaleclick
{
    NSLog(@"销量");
}
// 价格按钮
-(void)priceclick
{
    NSLog(@"价格");
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
