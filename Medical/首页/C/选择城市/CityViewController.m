//
//  CityViewController.m
//  Zhai
//
//  Created by 周文静 on 16/8/25.
//  Copyright © 2016年 lechuangshidai. All rights reserved.
//

#import "CityViewController.h"
#import "JWCityGroup.h"
#import "MJExtension.h"
@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@property (strong, nonatomic) NSArray *cityGroups;
@property (copy,nonatomic) NSString *strCity;

@end

@implementation CityViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
}
-(NSArray *)cityGroups
{
    if (!_cityGroups) {
        _cityGroups = [JWCityGroup objectArrayWithFilename:@"cityGroups.plist"];
    }
    return _cityGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"选择城市"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };

    [self createTableView];
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
        _tableView.backgroundColor = [UIColor whiteColor];
        // 设置组索引字体的颜色
        _tableView.sectionIndexColor = [UIColor blackColor];
        [self.view addSubview:_tableView];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.cityGroups.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    JWCityGroup *g = self.cityGroups[section];
    return g.cities.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40 *HEIGHT_SCALE;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40 *HEIGHT_SCALE;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 *HEIGHT_SCALE, DEVICE_WIDTH, 1 *HEIGHT_SCALE)];
    lineLabel.backgroundColor = Line_Color;
    [cell.contentView addSubview:lineLabel];
    JWCityGroup *g = self.cityGroups[indexPath.section];
    
    cell.textLabel.text = g.cities[indexPath.row];
    return cell;
    
    
}

#pragma mark   ==============  header  ==============
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // 把每一组的title装到一个数组里在返回
    return [self.cityGroups valueForKeyPath:@"title"];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    JWCityGroup *cityGroup = self.cityGroups[indexPath.section];
    
    _strCity = [NSString stringWithFormat:@"%@",cityGroup.cities[indexPath.row]];
    
    if (self.cityBlock != nil) {
        self.cityBlock(_strCity);
    }

    [self.navigationController popViewControllerAnimated:YES];
 
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] init];
//    headerView.backgroundColor = [UIColor yellowColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10*WIDTH_SCALE, 0, DEVICE_WIDTH - 20 *WIDTH_SCALE, 40 *HEIGHT_SCALE)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16 *WIDTH_SCALE weight:2 *WIDTH_SCALE];
    JWCityGroup *g = self.cityGroups[section];
    titleLabel.text = g.title;
//    titleLabel.backgroundColor = [UIColor redColor];
    [headerView addSubview:titleLabel];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 *HEIGHT_SCALE, DEVICE_WIDTH, 1 *HEIGHT_SCALE)];
    lineLabel.backgroundColor = Line_Color;
    [headerView addSubview:lineLabel];
    return headerView;
}
-(void)cityBlock:(CityBlock)block
{
    self.cityBlock = block;
}

@end
