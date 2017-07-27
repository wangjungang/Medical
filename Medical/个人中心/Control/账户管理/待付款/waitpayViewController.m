//
//  waitpayViewController.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "waitpayViewController.h"
#import "waitpayView.h"
//#import "waitfirstCell.h"
#import "waitsecondCell.h"
#import "waitthirdCell.h"
#import "waitpayModel.h"
#import "settlementViewController.h"

#import "FinishShopListBuyBase.h"
#import "FinishShopListBuyData.h"
#import "FinishShopListBuyProduct.h"

#import "FinishPayCell.h"
#import "FinishPayTwoCell.h"
#import "FinishPayThreeCell.h"
//继续购买VC
#import "detailsViewController.h"

#import "JLHeaderView.h"

@interface waitpayViewController ()<UITableViewDataSource,UITableViewDelegate,JLHeaderViewDelegate>
{
    BOOL isequal;
    NSInteger  page;
    BOOL isRefreshing;
    BOOL isLoading;
    CGFloat sum;
    CGFloat oldsum;
    NSMutableArray *dataListAry;
    BOOL ischoose;
}
@property (nonatomic,strong) UITableView *waitpaytableView;
@property (nonatomic,strong) NSMutableArray *choosearray;
@property (nonatomic,strong) NSMutableArray *waitarr;
@property (nonatomic,strong) waitpayView *waitView;
@property (nonatomic,strong) waitpayModel *waitmodel;
@property (nonatomic,strong) NSDictionary *ditdata;


@property (nonatomic,strong) UIButton *choostbtn;

@property (nonatomic,strong) NSMutableArray *orderarr;
@property (nonatomic,strong) NSMutableArray *selecarr;
@end
static NSString *waitpay = @"waitpay";
static NSString *waitpay1 = @"waitpay1";
static NSString *waitpay2 = @"waitpay2";
static NSString *waitpay3 = @"waitpay3";

@implementation waitpayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.waitpaytableView];
    isequal = YES;
    isLoading = YES;
    isRefreshing = NO;
    page = 1;
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
  
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"支付"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    self.choosearray = [NSMutableArray array];
    self.waitarr = [NSMutableArray array];
    [self.view addSubview:self.waitView];
    [self getDataList];
    [self pullRefresh];
    [self addLoadMore];
    [self createTable];
    self.waitpaytableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    ischoose = NO;
    self.orderarr = [NSMutableArray array];
    self.selecarr = [NSMutableArray array];
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
   // self.waitpaytableView.frame = CGRectMake(0, 50, DEVICE_WIDTH, DEVICE_HEIGHT-110);
    self.waitView.frame = CGRectMake(0, DEVICE_HEIGHT-60, DEVICE_WIDTH, 60);
    
}

-(void)waitpay:(UIButton *)sender
{
    //[self.delegate waitPayClick:self];
    
}

#pragma mark-
#pragma mark-获取数据源

- (void)getDataList
{
    dataListAry=[NSMutableArray array];
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:weizhifuorder,uid,@"20",page] block:^(id infor)
     {
         if ([[infor objectForKey:@"code"]integerValue]==200)
         {
             FinishShopListBuyBase*buyBase=[FinishShopListBuyBase modelObjectWithDictionary:infor];
             [dataListAry addObjectsFromArray:buyBase.data];
             self.waitmodel = [[waitpayModel alloc] init];
             NSArray*dit = [infor objectForKey:@"data"];
        
             
             for (int i = 0; i<dit.count; i++) {
                 [self.orderarr addObject:[dit[i]objectForKey:@"order"]];
                 self.waitmodel.selectState = NO;
                 self.waitmodel.orderid = self.orderarr[i];
                 [self.selecarr addObject:[NSString stringWithFormat:@"%d",self.waitmodel.selectState]];
             }
             NSLog(@"selecarr=====%@",self.selecarr);
            
             [self.waitpaytableView reloadData];

         }else
         {
             if (dataListAry.count==0)
             {
                 [NSObject wj_showHUDWithTip:@"您暂时没有已完成订单"];
             }else
             {
                 [NSObject wj_showHUDWithTip:@"已经全部加载了"];
             }
         }

     } errorblock:^(NSError *error) {
         
         
     }];
    [self.waitpaytableView reloadData];
    
}

#pragma mark ---下拉刷新
-(void)pullRefresh
{
    self.waitpaytableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (isRefreshing == YES) {
            page = 1;
            [dataListAry removeAllObjects];
           
            
            [self getDataList];
            
        }
        isRefreshing = YES;
        [self.waitpaytableView.mj_header endRefreshing];
    }];
    [self.waitpaytableView.mj_header beginRefreshing];
}

//上拉加载更多
-(void)addLoadMore
{
    self.waitpaytableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (isLoading == YES) {
            page++;
            NSLog(@"page===%ld",(long)page);
            [self getDataList];
        }
        isLoading = YES;
        [self.waitpaytableView.mj_footer endRefreshing];
        
    }];
}

#pragma mark - getters

- (void)createTable
{
    if (!_waitpaytableView) {
        _waitpaytableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-124) style:UITableViewStyleGrouped];
        _waitpaytableView.dataSource=self;
        _waitpaytableView.delegate=self;
        [self.view addSubview:_waitpaytableView];
        [_waitpaytableView registerClass:[FinishPayCell class] forCellReuseIdentifier:waitpay1];
        [_waitpaytableView registerClass:[FinishPayTwoCell class] forCellReuseIdentifier:waitpay2];
        [_waitpaytableView registerClass:[FinishPayThreeCell class] forCellReuseIdentifier:waitpay3];
        [self pullRefresh];
        [self addLoadMore];
    }else{
        [_waitpaytableView reloadData];
    }
}

-(waitpayView *)waitView
{
    if(!_waitView)
    {
        _waitView = [[waitpayView alloc] init];
        _waitView.backgroundColor = [UIColor whiteColor];
        _waitView.layer.masksToBounds = YES;
        _waitView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor wjColorFloat:@"999999"]);
        _waitView.layer.borderWidth = 1.0f;
        [_waitView.choosebtn addTarget:self action:@selector(chooseallbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [_waitView.invoicingbtn addTarget:self action:@selector(payment) forControlEvents:UIControlEventTouchUpInside];
        _waitView.layer.masksToBounds = YES;
        _waitView.layer.borderWidth = 0.3;
        _waitView.layer.borderColor = [[UIColor wjColorFloat:@"cccccc"] CGColor];
    }
    return _waitView;
}

#pragma mark-
#pragma mark-tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FinishShopListBuyData*data=dataListAry[section];
    return 3*data.product.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataListAry.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.row%3==0) {
        FinishPayCell*cell =[tableView dequeueReusableCellWithIdentifier:waitpay1];
        if (!cell) {
            cell = [[FinishPayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitpay1];
        }
        FinishShopListBuyData*data=dataListAry[indexPath.section];
        FinishShopListBuyProduct*product=data.product[indexPath.row/3];
        [cell setCellContent:product];
        return cell;
    }else if (indexPath.row%3==1){
        FinishPayTwoCell*cell =[tableView dequeueReusableCellWithIdentifier:waitpay2];
        if (!cell) {
            cell = [[FinishPayTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitpay2];
        }
        FinishShopListBuyData*data=dataListAry[indexPath.section];
        FinishShopListBuyProduct*product=data.product[indexPath.row/3];
        [cell setCellContent:product];
        return cell;
    }else{
        FinishPayThreeCell*cell =[tableView dequeueReusableCellWithIdentifier:waitpay3];
        if (!cell) {
            cell = [[FinishPayThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:waitpay3];
        }
        cell.goOnBtn.tag=indexPath.section*10+indexPath.row*10000+5;
        [cell.goOnBtn addTarget:self action:@selector(goBuy:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  indexPath.row%3==0?F_I6_SIZE(30):indexPath.row%3==1?F_I6_SIZE(125/2):F_I6_SIZE(30);
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    JLHeaderView *view = [[JLHeaderView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,  F_I6_SIZE(30))];
    UIButton*_delegateBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _delegateBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(75), F_I6_SIZE(5), F_I6_SIZE(60), F_I6_SIZE(20));
    _delegateBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
    [_delegateBtn setTitle:@"删除订单" forState:0];
    [_delegateBtn setTitleColor:[UIColor whiteColor] forState:0];
    _delegateBtn.clipsToBounds=YES;
    _delegateBtn.layer.cornerRadius=5;
    _delegateBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
    _delegateBtn.tag=section;
    [_delegateBtn addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_delegateBtn];
    view.section = section;
    view.delegate = self;
   // view.choosebtn.selected = NO;
   // view.orderlabel.text = self.orderarr[section];
    
    if ([self.selecarr[section]isEqualToString:@"0"]) {
        [view.choosebtn setImage:[UIImage imageNamed:@"椭圆5"] forState:normal];
    }
    else
    {
        [view.choosebtn setImage:[UIImage imageNamed:@"组19"] forState:normal];
    }
    
    return view;
}

#pragma mark - getters

- (void)goBuy:(UIButton*)btn
{
    NSInteger row=(btn.tag-5)/10000;
    NSInteger section=(btn.tag-5-row*10000)/10;
    FinishShopListBuyData*data=dataListAry[section];
    FinishShopListBuyProduct*product=data.product[row/3];
    detailsViewController*shopDetail=[detailsViewController new];
    shopDetail.newprice=product.nowprice;
    if (product.drugName)
    {
        shopDetail.pid=product.ptid;
        shopDetail.drugnamestr=product.drugName;
        shopDetail.xiangqingtype=@"yaodian";
    }
    else
    {
        shopDetail.pid=product.gid;
        shopDetail.drugnamestr=product.name;
        shopDetail.xiangqingtype=@"guoyitang";
    }
    [self.navigationController pushViewController:shopDetail animated:YES];
}

- (void)delegateBtn:(UIButton*)btn
{
    UIAlertController*alert=[UIAlertController alertControllerWithTitle:@"确认删除订单？" message:@"删除之后不能找回" preferredStyle:1];
    UIAlertAction*cacle=[UIAlertAction actionWithTitle:@"取消" style:0 handler:nil];
    UIAlertAction*sure=[UIAlertAction actionWithTitle:@"确认" style:0 handler:^(UIAlertAction * _Nonnull action) {
        FinishShopListBuyData*data=dataListAry[btn.tag];
        if (data.product.count!=0)
        {
            FinishShopListBuyProduct*product=data.product[0];
            [self delegateShopId:product.oid];
        }
    }];
    [alert addAction:cacle];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}

//删除订单

- (void)delegateShopId:(NSString*)shopId
{
    [AFManager getReqURL:[NSString stringWithFormat:delOrder,shopId] block:^(id infor)
     {
         if ([[infor objectForKey:@"code"]integerValue]==200)
         {
             [self pullRefresh];
         }
     } errorblock:^(NSError *error) {
         
     }];
}

-(void)payment
{
    NSLog(@"去付款");
    
    if (dataListAry.count==0) {
        [NSObject wj_showHUDWithTip:@"没有未付款订单"];
    }
    else
    {
        NSMutableArray *orderarray = [NSMutableArray array];
        for (int t=0; t<self.selecarr.count; t++) {
            if ([self.selecarr[t] isEqualToString:@"1"]) {
                //            NSString *orderid = [self.orderarr objectAtIndex:t];
                //            [orderarray addObject:orderid];
                FinishShopListBuyData*data=dataListAry[t];
                FinishShopListBuyProduct*product=data.product[0];
                NSString *orderid = product.oid;
                [orderarray addObject:orderid];
            }
        }
        NSString *orderid = [orderarray componentsJoinedByString:@","];
        NSLog(@"orderid=====%@",orderid);
        
        [AFManager getReqURL:[NSString stringWithFormat:nopayorder,orderid] block:^(id infor) {
            if ([[infor objectForKey:@"code"]integerValue]==200) {
                [NSObject wj_showHUDWithTip:@"付款成功"];
                [self pullRefresh];
                [self getDataList];
             
            }
            if ([[infor objectForKey:@"code"]integerValue]==201) {
                [NSObject wj_showHUDWithTip:@"付款失败"];
                
                [self pullRefresh];
            }
            if ([[infor objectForKey:@"code"]integerValue]==202) {
                [NSObject wj_showHUDWithTip:@"余额不足"];
                [self pullRefresh];
            }
        } errorblock:^(NSError *error) {
            [NSObject wj_showHUDWithTip:@"付款失败,请检查网络"];
        }];

    }
    
    
}

-(void)cellchoostbtnclick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"组19"] forState:UIControlStateNormal];
    }else
    {
        [sender setImage:[UIImage imageNamed:@"椭圆5"] forState:UIControlStateNormal];
    }
}

-(void)chooseallbtnclick:(UIButton *)sender
{
    //判断是否选中，是改成否，否改成是，改变图片状态
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        [sender setImage:[UIImage imageNamed:@"组19"] forState:UIControlStateNormal];
        //改变单元格选中状态
        self.selecarr = [NSMutableArray array];

        for (int i=0; i<dataListAry.count; i++)
        {
            [self.selecarr addObject:@"1"];
           // [self.selecarr replaceObjectAtIndex:i withObject:@"1"];
        }
        
    }else{
        [sender setImage:[UIImage imageNamed:@"椭圆5"] forState:UIControlStateNormal];
        //改变单元格选中状态
        self.selecarr = [NSMutableArray array];
        for (int i=0; i<dataListAry.count; i++)
        {
            [self.selecarr addObject:@"0"];
            //[self.selecarr replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    
    NSLog(@"arr=====%@",self.selecarr);
    [self.waitpaytableView reloadData];
    
}

- (void)foldHeaderInSection:(NSInteger)SectionHeader andid:(UIButton *)sender
{
    NSLog(@"%ld",(long)SectionHeader);
    sender.selected = !sender.selected;
    ischoose = !ischoose;
    
    if (ischoose==YES) {
        [self.selecarr replaceObjectAtIndex:SectionHeader withObject:@"1"];
        NSLog(@"arr = %@",self.selecarr);
    }
    if (ischoose==NO)
    {
        [self.selecarr replaceObjectAtIndex:SectionHeader withObject:@"0"];
        NSLog(@"arr = %@",self.selecarr);
    }
    
    //刷新整个表格
    [self.waitpaytableView reloadData];
    

}
@end
