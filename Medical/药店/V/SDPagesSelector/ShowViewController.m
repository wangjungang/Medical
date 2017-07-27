//
//  ShowViewController.m
//  SDPagesSelector
//
//  Created by 宋东昊 on 16/7/15.
//  Copyright © 2016年 songdh. All rights reserved.
//

#import "ShowViewController.h"
#import "detailsViewController.h"
#import "medicineCollectionViewCell.h"
#import "storeModel.h"
#import "pharmarcySales.h"
#import "pharmarcyPrice.h"
@interface ShowViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
{
       NSInteger num;
}
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic,strong)  UICollectionView *collectionview;
@property (nonatomic,strong) storeModel *smodel;
@property (nonatomic,strong) NSMutableArray *shoparr;

@property (nonatomic,strong) pharmarcySales *sales;
@property (nonatomic,strong) pharmarcyPrice *prices;

@property (nonatomic,strong) NSMutableArray *quanbuarr;

@property (nonatomic,strong) NSMutableArray *productarr;
@end
static NSString *collection = @"imagecell";
@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   // self.view.backgroundColor = [self randomColor];
    
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    _contentLabel.center = self.view.center;
    _contentLabel.textColor = [UIColor redColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.text = self.content;
    //[self.view addSubview:_contentLabel];
    
    self.sales.frame = CGRectMake(0, 0, DEVICE_WIDTH/2, 40);
    self.prices.frame = CGRectMake(DEVICE_WIDTH/2, 0, DEVICE_WIDTH/2, 40);
    
    self.productarr = [NSMutableArray array];
    
    [self loadCollection];
    self.quanbuarr = [NSMutableArray array];
    [self.view addSubview:self.collectionview];
    [self.view addSubview:self.sales];
    [self.view addSubview:self.prices];
    
    
    if ([self.showtypestr isEqualToString:@"guoyitang"]) {
        [self loaddatadel];
    }
    if ([self.showtypestr isEqualToString:@"yaodian"]) {
        [self loaddatafromweb];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)loaddatafromweb
{
    [AFManager getReqURL:[NSString stringWithFormat:productlist,self.shopid,@"",self.content,@""] block:^(id infor) {
        
        NSLog(@"info = %@",infor);
        NSArray*dit = [infor objectForKey:@"data"];
        NSMutableArray *contarr = [NSMutableArray array];
        for (int i = 0; i<dit.count; i++) {
            [contarr addObject:[dit[i]objectForKey:@"id"]];
        }
        NSLog(@"contarr------- = %@",contarr);
        NSInteger inter = [contarr indexOfObject:self.content];
        NSArray *product = [dit[inter]objectForKey:@"product"];
        NSLog(@"pruduct = ----11111----%@",product);
        self.shoparr = [NSMutableArray array];
        for (int i = 0; i<product.count; i++) {
            NSDictionary *dicarr = [product objectAtIndex:i];
            self.smodel = [[storeModel alloc] init];
            self.smodel.drugnamestr = dicarr[@"drug_name"];
            self.smodel.drugeffectstr = dicarr[@"effect"];
            self.smodel.oldpricestr = dicarr[@"oldprice"];
            self.smodel.newpricestr = dicarr[@"nowprice"];
            self.smodel.picimageurl = dicarr[@"pictures"];
            self.smodel.pid = dicarr[@"ptid"];
            
            self.smodel.yid = dicarr[@"yid"];
            [self.shoparr addObject:self.smodel];
        }
        
        [self.quanbuarr addObjectsFromArray:self.shoparr];
        [self.collectionview reloadData];
    } errorblock:^(NSError *error) {
        
    }];
    
}
//国医堂
-(void)loaddatadel
{
    [AFManager getReqURL:[NSString stringWithFormat:guoyitang] block:^(id infor) {
        
        NSLog(@"info = %@",infor);
        NSArray*dit = [infor objectForKey:@"data"];
        NSMutableArray *contarr = [NSMutableArray array];
 //       NSMutableArray *contarr = [NSMutableArray arrayWithObject:@"quanbu"];
        for (int i = 0; i<dit.count; i++) {
            [contarr addObject:[dit[i]objectForKey:@"id"]];
            [self.productarr addObject:contarr];
        }
        
        NSLog(@"contarr------- = %@",self.productarr);
        
        
        NSInteger inter = [contarr indexOfObject:self.content];
        
        
        NSArray *product = [dit[inter]objectForKey:@"product"];
        NSLog(@"pruduct = ----11111----%@",product);
        self.shoparr = [NSMutableArray array];
        for (int i = 0; i<product.count; i++) {
            NSDictionary *dit = [product objectAtIndex:i];
            self.smodel = [[storeModel alloc] init];
            self.smodel.drugnamestr = dit[@"name"];
            self.smodel.drugeffectstr = dit[@"effect"];
            self.smodel.oldpricestr = dit[@"oldprice"];
            self.smodel.newpricestr = dit[@"nowprice"];
            self.smodel.picimageurl = dit[@"picture"];
            self.smodel.pid = dit[@"id"];
            self.smodel.gid = dit[@"gid"];
            self.smodel.yid = dit[@"yid"];
            [self.shoparr addObject:self.smodel];
        }
        
        [self.quanbuarr addObjectsFromArray:self.shoparr];
        [self.collectionview reloadData];
    } errorblock:^(NSError *error) {
        
    }];

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
    //[self.view addSubview:self.collectionview];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate && UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.quanbuarr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    medicineCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collection forIndexPath:indexPath];
    [cell setCellDate:self.quanbuarr[indexPath.row]];
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
    
    storeModel *model = self.shoparr[indexPath.item];
    if ([self.showtypestr isEqualToString:@"yaodian"]) {
        detailsVC.pid = model.pid;
        detailsVC.xiangqingtype = @"yaodian";
    }
    if ([self.showtypestr isEqualToString:@"guoyitang"]) {
         detailsVC.pid = model.gid;
         detailsVC.xiangqingtype = @"guoyitang";
    }
    detailsVC.oyid = model.yid;
    detailsVC.newprice = model.newpricestr;
    detailsVC.drugnamestr = model.drugnamestr;
    [self.navigationController pushViewController:detailsVC animated:YES];
    NSLog(@"选择%ld",indexPath.row);
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

@end
