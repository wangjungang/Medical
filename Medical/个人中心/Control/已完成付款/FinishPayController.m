//
//  FinishPayController.m
//  Medical
//
//  Created by 李壮 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "FinishPayController.h"
//完成付款cell
#import "FinishPayCell.h"
#import "FinishPayTwoCell.h"
#import "FinishPayThreeCell.h"
//mol
//#import "HistoryPayListBase.h"
//#import "HistoryPayData.h"
#import "FinishShopListBuyBase.h"
#import "FinishShopListBuyData.h"
#import "FinishShopListBuyProduct.h"
//
#import "NSObject+HUD.h"
//继续购买VC
#import "detailsViewController.h"
@interface FinishPayController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *dataListAry;
//    NSMutableArray *sectionAry;
    NSInteger  page;
//    NSString*title;
}
@property (nonatomic,strong)UITableView *litab;
@end

@implementation FinishPayController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"已完成"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock=^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    self.view.backgroundColor=[UIColor whiteColor];
    dataListAry=[NSMutableArray array];
//    sectionAry =[NSMutableArray array];
    [self createTable];
}
- (void)createTable
{
    if (!_litab) {
        _litab =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64) style:UITableViewStyleGrouped];
        _litab.dataSource=self;
        _litab.delegate=self;
        [self.view addSubview:_litab];
        [_litab registerClass:[FinishPayCell class] forCellReuseIdentifier:@"FinishPayCell"];
        [_litab registerClass:[FinishPayTwoCell class] forCellReuseIdentifier:@"FinishPayTwoCell"];
        [_litab registerClass:[FinishPayThreeCell class] forCellReuseIdentifier:@"FinishPayThreeCell"];
        [self addInfinte];
        [self addPullRefresh];
    }else{
        [_litab reloadData];
    }
}

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
       
        [dataListAry removeAllObjects];
//        [sectionAry removeAllObjects];
        [self getDataList];
    }];
    [_litab.mj_header beginRefreshing];
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
        FinishPayCell*cell =[tableView dequeueReusableCellWithIdentifier:@"FinishPayCell"];
        FinishShopListBuyData*data=dataListAry[indexPath.section];
        FinishShopListBuyProduct*product=data.product[indexPath.row/3];
//        HistoryPayData*data=dataListAry[indexPath.section][indexPath.row/3];
        [cell setCellContent:product];
        return cell;
    }else if (indexPath.row%3==1){
        FinishPayTwoCell*cell =[tableView dequeueReusableCellWithIdentifier:@"FinishPayTwoCell"];
        FinishShopListBuyData*data=dataListAry[indexPath.section];
        FinishShopListBuyProduct*product=data.product[indexPath.row/3];
//        HistoryPayData*data=dataListAry[indexPath.section][indexPath.row/3];
        [cell setCellContent:product];
        return cell;
    }else{
        FinishPayThreeCell*cell =[tableView dequeueReusableCellWithIdentifier:@"FinishPayThreeCell"];
        cell.goOnBtn.tag=indexPath.section*10+indexPath.row*10000+5;
        [cell.goOnBtn addTarget:self action:@selector(goBuy:) forControlEvents:UIControlEventTouchUpInside];
//        cell.delegateBtn.tag=indexPath.section;
//        [cell.delegateBtn addTarget:self action:@selector(delegateBtn:) forControlEvents:UIControlEventTouchUpInside];
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
    UIView*view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, F_I6_SIZE(30))];
    UILabel*titleLb =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), 0, DEVICE_WIDTH, F_I6_SIZE(30))];
    titleLb.font=[UIFont systemFontOfSize:14];
    [view addSubview:titleLb];
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
    FinishShopListBuyData*data=dataListAry[section];
    titleLb.text=[NSString stringWithFormat:@"订单号：%@",data.order];
    return view;
}
- (void)goBuy:(UIButton*)btn
{
    NSInteger row=(btn.tag-5)/10000;
    NSInteger section=(btn.tag-5-row*10000)/10;
    FinishShopListBuyData*data=dataListAry[section];
    FinishShopListBuyProduct*product=data.product[row/3];
//    HistoryPayData*data=dataListAry[btn.tag];
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
#pragma mark-
#pragma mark-获取数据源
- (void)getDataList
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:FINISH_HISTORY_LIST_PAY_URL,uid,page,@"15"] block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            FinishShopListBuyBase*buyBase=[FinishShopListBuyBase modelObjectWithDictionary:infor];
            [dataListAry addObjectsFromArray:buyBase.data];

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
        [self createTable];

        [_litab.mj_header endRefreshing];
        [_litab.mj_footer endRefreshing];
    } errorblock:^(NSError *error) {
        [_litab.mj_header endRefreshing];
        [_litab.mj_footer endRefreshing];
    }];
}
//删除订单
- (void)delegateShopId:(NSString*)shopId
{
    [AFManager getReqURL:[NSString stringWithFormat:delOrder,shopId] block:^(id infor)
    {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
//            title=nil;
            [self addPullRefresh];
        }
    } errorblock:^(NSError *error) {
        
    }];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
