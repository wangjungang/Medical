//
//  HomeViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "HomeViewController.h"
#import "MyFirstCell.h"
#import "MySecondCell.h"
#import "MyThirdCell.h"
#import "MyFourthCell.h"
#import "RSTFocusImage.h"
//合作商家
#import "MerchantViewController.h"
//合作医院
#import "HospitalViewController.h"
//互动社区
#import "InteractionViewController.h"
//积分换购
#import "JiFenHuangouViewController.h"
//对症下药
#import "DuizhengXiayaoViewController.h"
//对症下药HTML
#import "DuizhengxiayaoHTMLViewController.h"
//会员专享 跳转到药店店铺
#import "storeViewController.h"
//城市
#import "CityViewController.h"
//搜索C
#import "HomeSearchViewController.h"
//轮播mol
#import "HeardImageClinicData.h"
#import "HeardImageClinicBase.h"
//药品详情VC
#import "detailsViewController.h"
//热门商品mol
#import "HotListShopBase.h"
#import "HotListData.h"
//
#import "NSObject+HUD.h"
//融云
#import "ChetListController.h"
#import <RongIMKit/RongIMKit.h>
#import "RongIMKitTool.h"
#import "UserHeaderUser.h"
//特价会员Col
#import "VipShopController.h"
//刷新
#import "NSObject+MBProgressHUD.h"
#import "ZYLocationKit.h"
@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,MySecondCellDelegate,MyThirdCellDelegate,MyFourthCellDelegate,RCIMUserInfoDataSource,RCIMReceiveMessageDelegate>
{
    //banner图片数组
    NSMutableArray *_bannerImageArray;
    UIView *_backView ;
    UIView *_custonNavView;
    CustomTabbarViewController *tabbar;
    UIButton *addressButton;
    NSMutableArray *hotShopAry;
    NSInteger       page;
    UIButton *messageButton;
    MBProgressHUD *MB;
    CGFloat   lat;
    CGFloat   lon;
    NSString *subLocality;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) RCUserInfo  *userInfo2;
@property(nonatomic,strong)NSMutableDictionary *fourthCellHeightDic;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated
{
    tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar showTabbar];
    self.navigationController.navigationBar.hidden=YES;
    [self changeMessageBtnStatus];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fourthCellHeightDic = [[NSMutableDictionary alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getFourthCellHeight:) name:@"WEBVIEW_HEIGHT" object:nil];
    [[RongIMKitTool new]instanceRongCloud];
    [[RCIM sharedRCIM]setUserInfoDataSource:self];
    [RCIM sharedRCIM].receiveMessageDelegate=self;
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
    _bannerImageArray = [NSMutableArray array];
    hotShopAry =[NSMutableArray array];
          [self createCustomHomeNav];
    [self createTableView];
    [self getRequestHealthTips];
    MB=[NSObject showHUDView:self.view MBText:@"正在加载"];
}
-(void)getFourthCellHeight:(NSNotification *)sender
{
    MyFourthCell *cell = [sender object];
    
    if (![self.fourthCellHeightDic objectForKey:[NSString stringWithFormat:@"%ld",cell.tag]]||[[self.fourthCellHeightDic objectForKey:[NSString stringWithFormat:@"%ld",cell.tag]] floatValue] != cell.height)
    {
        [self.fourthCellHeightDic setObject:[NSNumber numberWithFloat:cell.height] forKey:[NSString stringWithFormat:@"%ld",cell.tag]];
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.tag inSection:3]] withRowAnimation:UITableViewRowAnimationNone];
    }
}
-(void)createCustomHomeNav
{
    _custonNavView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    _custonNavView.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
    [self.view addSubview:_custonNavView];
    
    addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addressButton.frame = CGRectMake(15 *WIDTH_SCALE, 32, 70 *WIDTH_SCALE, 20);
//    addressButton.backgroundColor = [UIColor redColor];
    [ZYLocationKit getUserLocation:^(CLLocation* item) {
        NSLog(@"%f=======%f",item.coordinate.latitude,item.coordinate.longitude);
        lat=item.coordinate.latitude;
        lon=item.coordinate.longitude;
        [ZYLocationKit reverseGeocode:item.coordinate callBack:^(CLPlacemark *item) {
            subLocality =   item.subLocality;
            NSLog(@"country===%@ %@ %@ %@ %@ %@ %@ %@ %@ %@",item.country,item.ISOcountryCode,item.postalCode,item.subAdministrativeArea,item.administrativeArea,item.subLocality,item.locality,item.subThoroughfare,item.thoroughfare,item.name);
            NSLog(@"qu===%@",item.subLocality);
            [addressButton setTitle:subLocality forState:UIControlStateNormal];
            
        }];
    }];

    
    addressButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    addressButton.titleLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE weight:2*WIDTH_SCALE];
    [addressButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [addressButton addTarget:self action:@selector(addressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_custonNavView addSubview:addressButton];
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(90 *WIDTH_SCALE, 28, 200*WIDTH_SCALE, 25)];
    searchButton.clipsToBounds = YES;
    searchButton.layer.cornerRadius = 11;
    searchButton.backgroundColor = [UIColor wjColorFloat:@"5adadd"];
    UIImageView *leftView = [[UIImageView alloc] init];
    leftView.frame = CGRectMake(-35 *WIDTH_SCALE, 0, 20*WIDTH_SCALE, 25);
    leftView.image = [UIImage imageNamed:@"search"];
   leftView.contentMode = UIViewContentModeCenter;
    [searchButton setTitle:@"  药品 / 症状 / 品牌" forState:0];
    [searchButton setTitleColor:[UIColor wjColorFloat:@"b9edee"] forState:UIControlStateNormal];
    searchButton.titleLabel.font = [UIFont systemFontOfSize:14*WIDTH_SCALE];
    [searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_custonNavView addSubview:searchButton];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(DEVICE_WIDTH / 2 - 75 *WIDTH_SCALE, 32, 150 *WIDTH_SCALE, 20)];
    titleLabel.text = @"首页";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17 *WIDTH_SCALE];
//    [self.view addSubview:titleLabel];
    
    messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    messageButton.frame = CGRectMake(DEVICE_WIDTH - 70*WIDTH_SCALE, 32, 55 *WIDTH_SCALE, 20);
    messageButton.tag=999;
    [messageButton setImage: [UIImage imageNamed:@"消息"] forState:0];
     [messageButton setImage: [UIImage imageNamed:@"有消息"] forState:UIControlStateSelected];
    messageButton.imageEdgeInsets = UIEdgeInsetsMake(2, 38*WIDTH_SCALE, 2, 0*WIDTH_SCALE);
    messageButton.selected=NO;
    [messageButton addTarget:self action:@selector(messageList) forControlEvents:UIControlEventTouchUpInside];
    [_custonNavView addSubview:messageButton];

}
-(void)addressButtonClick
{
    CityViewController *cityVC = [[CityViewController alloc] init];
    [cityVC cityBlock:^(NSString *city) {
        [addressButton setTitle:city forState:UIControlStateNormal];
    }];
    [self.navigationController pushViewController:cityVC animated:YES];
}
-(void)searchButtonClick:(UIButton *)button
{
    HomeSearchViewController *searchVC = [HomeSearchViewController new];
    [self.navigationController pushViewController:searchVC animated:YES];
}
#pragma mark --创建TableView--
-(void)createTableView
{
    if (!_tableView)
    {
        _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64-49 ) style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints =NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionFooterHeight = 0;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_tableView registerClass:[MyFirstCell class] forCellReuseIdentifier:@"FirstCell"];
        [_tableView registerClass:[MySecondCell class] forCellReuseIdentifier:@"SecondCell"];
        
        [_tableView registerClass:[MyThirdCell class] forCellReuseIdentifier:@"ThirdCell"];
        _tableView.showsVerticalScrollIndicator=NO;
        [_tableView registerClass:[MyFourthCell class] forCellReuseIdentifier:@"FourhCell"];
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
        
        [self getHeaderImage];
//        [self addInfinte];
    }
}

#pragma mark --UITableView代理---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section==3?hotShopAry.count:1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MyFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:@"FirstCell" forIndexPath:indexPath];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return firstCell;
    }
    else if (indexPath.section == 1)
    {
        MySecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell" forIndexPath:indexPath];
        secondCell.selectionStyle = UITableViewCellSelectionStyleNone;
        secondCell.delegate = self;
        return secondCell;
    }
    else if (indexPath.section == 2)
    {
        MyThirdCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCell" forIndexPath:indexPath];
        thirdCell.Delegate=self;
        thirdCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return thirdCell;
    }
    else
    {
        MyFourthCell * fourthCell = [tableView dequeueReusableCellWithIdentifier:@"FourhCell" forIndexPath:indexPath];
        fourthCell.backgroundColor = [UIColor whiteColor];
        fourthCell.tag = indexPath.row;
        fourthCell.delegate = self;
        [fourthCell createWebViewDatasource:hotShopAry indexPathRow:indexPath.row];

        fourthCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return fourthCell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 0.1 *HEIGHT_SCALE;
    }
    else if (indexPath.section == 1)
    {
        
        return 200*HEIGHT_SCALE;
    }
    else if (indexPath.section == 2)
    {
        if (DEVICE_HEIGHT > 600)
        {
            return 78 *HEIGHT_SCALE;
        }
        return 72 *HEIGHT_SCALE;
    }
    else
    {
        return [[self.fourthCellHeightDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]] floatValue];

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.1 *HEIGHT_SCALE;
    }
    else if (section == 1)
    {
        return 1 *HEIGHT_SCALE;
    }
    else if (section == 2)
    {
        return 6 *HEIGHT_SCALE;
    }
    else
    {
        return 35 *HEIGHT_SCALE;
    }
}
#pragma mark --创建第一区区头--
-(void)createFirstSectionHearder
{
    if (!_backView)
    {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 150 *HEIGHT_SCALE)];
        RSTFocusImage *focus = [[RSTFocusImage alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 150 *HEIGHT_SCALE) Images:_bannerImageArray Placeholder:[UIImage imageNamed:@"placeholder.png"]];
        focus.backgroundColor = [UIColor redColor];
        [_backView addSubview:focus];
        _tableView.tableHeaderView  = _backView;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2)
    {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 6 *HEIGHT_SCALE)];
        UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
        topLine.backgroundColor = kCOLOR(199, 199, 199, 0.6);
        [bgView addSubview:topLine];
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, DEVICE_WIDTH, 1)];
        bottomLine.backgroundColor = kCOLOR(199, 199, 199, 0.6);
        [bgView addSubview:bottomLine];
        return bgView;
    }else if (section==3){
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 35 *HEIGHT_SCALE)];
        UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
        topLine.backgroundColor = kCOLOR(199, 199, 199, 0.6);
        [bgView addSubview:topLine];
        UILabel *bottomLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, DEVICE_WIDTH, 1)];
        bottomLine.backgroundColor = kCOLOR(199, 199, 199, 0.6);
        [bgView addSubview:bottomLine];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 15 *HEIGHT_SCALE, 80 *WIDTH_SCALE, 15 *HEIGHT_SCALE)];
        titleLabel.text = @"健康助手";
        titleLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE];
        titleLabel.textColor = [UIColor wjColorFloat:@"000000"];
        [bgView addSubview:titleLabel];
        UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 34 *HEIGHT_SCALE, DEVICE_WIDTH -20 *WIDTH_SCALE, 1 *HEIGHT_SCALE)];
        lineLabel.backgroundColor = Line_Color;
        [bgView addSubview:lineLabel];
        return bgView;
    }
    return nil;
}
#pragma mark --二区六个button点击方法   button.tag = i;--
-(void)clickButtonViewWithTag:(NSInteger)index
{
    NSLog(@"第二区%ld",(long)index);
//      CustomTabbarViewController * tabbar = [CustomTabbarViewController instanceTabBar];
    switch (index) {
        case 0:
            [[CustomTabbarViewController instanceTabBar] jumpClinicViewController];
            break;
            
        case 1:
        {
            //国医堂商品
            storeViewController *storeVC = [storeViewController new];
            storeVC.typestr = @"guoyitang";
            [self.navigationController pushViewController:storeVC animated:YES];
        }
//            [tabbar jumpMedicalViewController];
            break;
        case 2://家庭医生
            [NSObject wj_alterSingleVCWithOneTitle:@"该模块尚未开通，敬请期待！" andTwoTitle:nil andSelfVC:self];
            break;
        case 3://快速问诊
            [NSObject wj_alterSingleVCWithOneTitle:@"该模块尚未开通，敬请期待！" andTwoTitle:nil andSelfVC:self];
            break;
        case 4:
            [self.navigationController pushViewController:[HospitalViewController new] animated:YES];

            break;
        case 5:
            [self.navigationController pushViewController:[InteractionViewController new] animated:YES];

            break;
        case 6:
            
            break;
        default:
            break;
    }
}
#pragma mark --三区四个button点击方法  bigButton.tag = 10+i;--
-(void)myThirdCellButtonClick:(NSInteger)index
{
    NSLog(@"第三区%ld",(long)index);
    switch (index) {
        case 10:
        {
            //会员专享
            VipShopController *storeVC = [VipShopController new];
            storeVC.shopname=@"会员专享";
            storeVC.tpye=YES;
            [self.navigationController pushViewController:storeVC animated:YES];
        }
            break;
        case 11:
        {
            //特价商品
            VipShopController *storeVC = [VipShopController new];
            storeVC.shopname=@"特价商品";
            [self.navigationController pushViewController:storeVC animated:YES];
        }
            break;
        case 12:
            [self.navigationController pushViewController:[JiFenHuangouViewController new] animated:YES];
            break;
        case 13:
        {
            [self.navigationController pushViewController:[MerchantViewController new] animated:YES];
            
        }
            break;
        default:
            break;
    }
}
#pragma mark --四区button点击方法   button.tag = 100 +i;--
-(void)myFourthCellClickButtonTag:(NSInteger)index
{
    NSInteger section = index/1000000;
    NSInteger row = (index%1000000)/10;
    NSInteger tag = (index%1000000)%10;
    NSLog(@"%s | %ld  |%ld|%ld|%ld",__func__,index,section,row,tag);
    NSArray*array=hotShopAry[row];
   detailsViewController*detailsVc =[detailsViewController new];
    HotListData*data=array[tag-1];
    detailsVc.pid=[NSString stringWithFormat:@"%@",data.ptid];
    detailsVc.newprice=[NSString stringWithFormat:@"%@",data.nowprice];
    detailsVc.drugnamestr=[NSString stringWithFormat:@"%@",data.drugName];
    [self.navigationController pushViewController:detailsVc animated:YES];
}
#pragma mark-
#pragma mark-上拉加载更多
- (void)addInfinte
{
    __weak HomeViewController*sl=self;
    
    [sl.tableView addInfiniteScrollingWithActionHandler:^{
        page+=1;
//        [self getHotList];
    }];
    [_tableView triggerInfiniteScrolling];
}
#pragma mark-
#pragma mark-获取数据源
//轮播
- (void)getHeaderImage
{
    [AFManager getReqURL:[NSString stringWithFormat:HEARD_IMAGE_URL,@"4"] block:^(id infor)
     {
         if ([[infor objectForKey:@"code"]integerValue]==200)
         {
             HeardImageClinicBase*imageBase=[HeardImageClinicBase modelObjectWithDictionary:infor];
             [_bannerImageArray removeAllObjects];
             [_bannerImageArray addObjectsFromArray:imageBase.data.picture];
             [self createFirstSectionHearder];
         }
         [MB hide:YES];
     } errorblock:^(NSError *error)
     {
          [MB hide:YES];
     }];
}
#pragma mark --健康小贴士--
-(void)getRequestHealthTips
{
    [AFManager getReqURL:Health_Tips_URL block:^(id infor) {
        NSLog(@"health===%@",infor);
        if ([[infor objectForKey:@"code"] integerValue]==200)
        {
            HealthTipsDataModels *dataModels = [HealthTipsDataModels modelObjectWithDictionary:infor];
            [hotShopAry addObjectsFromArray:dataModels.data];
            [_tableView reloadData];
        }
        else  if ([[infor objectForKey:@"code"] integerValue]==201)
        {
            
        }
        
    } errorblock:^(NSError *error) {
        
    }];
}
//热门药品列表
//- (void)getHotList
//{
//    [AFManager getReqURL:[NSString stringWithFormat:HOT_SHOP_LIST_URL,page,@"15"] block:^(id infor)
//    {
//        if ([[infor objectForKey:@"code"]integerValue]==200)
//        {
//            HotListShopBase*shopBase=[HotListShopBase modelObjectWithDictionary:infor];
//            NSMutableArray *array=[NSMutableArray array];
//            [array addObjectsFromArray:shopBase.data];
//            
//            NSInteger currentCount=0;
//            while (currentCount<array.count)
//            {
//                NSInteger pageNum =(array.count-currentCount>2 )?2:array.count-currentCount;
//                NSArray *newItems =[array subarrayWithRange:NSMakeRange(currentCount, pageNum)];
//                currentCount+=pageNum;
//                [hotShopAry addObject:newItems];
//            }
//            [_tableView reloadData];
//        }else
//        {
//            if (hotShopAry.count==0)
//            {
//                [NSObject wj_showHUDWithTip:@"暂时没有热门商品"];
//            }else
//            {
//                [NSObject wj_showHUDWithTip:@"已经全部加载了"];
//            }
//        }
//        [_tableView.infiniteScrollingView stopAnimating];
//    } errorblock:^(NSError *error)
//    {
//        [NSObject wj_showHUDWithTip:@"网络错误"];
//    }];
//}
//融云消息列表
- (void)messageList
{
    tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
    self.navigationController.navigationBar.hidden=NO;
    [self.navigationController pushViewController:[ChetListController new] animated:YES];
}
//融云给用户设置头像
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    dispatch_async(dispatch_get_main_queue(), ^{
            [AFManager getReqURL:[NSString stringWithFormat:@"http://139.224.43.42/medical/index.php/Admin/Api/getShow?uid=%@",userId] block:^(id infor)
             {
                 _userInfo2=[[RCUserInfo alloc]initWithUserId:userId name:[[infor objectForKey:@"user"] objectForKey:@"name"] portrait:[[infor objectForKey:@"user"] objectForKey:@"portraitUri"]];
                 if (_userInfo2) {
                     completion(_userInfo2);
                 }else
                 {
                     completion(nil);
                 }
             } errorblock:^(NSError *error)
             {
                 
             }];
    });
}
- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left
{
    [self changeMessageBtnStatus];
}
- (void)changeMessageBtnStatus
{
    if ([[RCIMClient sharedRCIMClient]getUnreadCount:@[@(ConversationType_PRIVATE)]]==0)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            messageButton.selected=NO;
        });    }else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            messageButton.selected=YES;
        });
    }
}
-(BOOL)onRCIMCustomLocalNotification:(RCMessage*)message
                      withSenderName:(NSString *)senderName
{
    [self changeMessageBtnStatus];
    [UIApplication sharedApplication].applicationIconBadgeNumber=[[RCIMClient sharedRCIMClient]getUnreadCount:@[@(ConversationType_PRIVATE)]];
    return NO;
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
