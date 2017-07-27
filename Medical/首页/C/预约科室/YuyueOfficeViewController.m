//
//  YuyueOfficeViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "YuyueOfficeViewController.h"
#import "YuyueOfficeCell.h"
#import "IntroduceOfficeViewController.h"
@interface YuyueOfficeViewController ()<UITableViewDelegate,UITableViewDataSource,YuyueOfficeCellDelegate>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    NSMutableArray *_childArray;
}
@end

@implementation YuyueOfficeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"科室预约"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    _dataArray = [[NSMutableArray alloc] init];
    _childArray = [[NSMutableArray alloc] init];
    [self createTableView];
    [self getRequestMechantOffice];
}
//请求科室分类列表
-(void)getRequestMechantOffice
{
    [AFManager getReqURL:[NSString stringWithFormat:Medical_Office_URL,self.hospitalID] block:^(id infor) {
        if ([[infor objectForKey:@"code"] integerValue]==200)
        {
            KeshiDetailsDataModels *dataModels = [KeshiDetailsDataModels modelObjectWithDictionary:infor];
            [_dataArray addObjectsFromArray:dataModels.data];
            [_tableView reloadData];
        }
    } errorblock:^(NSError *error) {
        
    }];
}
-(void)createTableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT ) style:UITableViewStyleGrouped];
        _tableView.translatesAutoresizingMaskIntoConstraints =NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.sectionFooterHeight = 0;
        [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_tableView registerClass:[YuyueOfficeCell class] forCellReuseIdentifier:@"leftTableCell"];
        //    _leftTable.backgroundColor = kCOLOR(210, 210, 210, 0.3);
        _tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_tableView];
    }
}
#pragma mark -
#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YuyueOfficeCell *cell =[tableView dequeueReusableCellWithIdentifier:@"leftTableCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor purpleColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    KeshiDetailsData *data = _dataArray[indexPath.row];
    [_childArray addObjectsFromArray:data.child];
//    cell.yuyueNameLabel.text = data.name;
    cell.delegate = self;
    [cell getYuyueOffinceDataSource:data indexPath:indexPath];
    return cell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1 *HEIGHT_SCALE;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    KeshiDetailsData *data = _dataArray[indexPath.row];
    return data.rowH;
}
#pragma mark --科室按钮点击方法 delegate-
-(void)yuyueOfficeButtonClick:(long)index
{
    IntroduceOfficeViewController *introduceVC = [IntroduceOfficeViewController new];
    NSInteger row=(index-10)/1000;
    KeshiDetailsData *data=_dataArray[row];
    NSInteger btnIndex=(index-10)%1000;
    KeshiDetailsChild*child=data.child[btnIndex];
    introduceVC.ID=child.childIdentifier;
    introduceVC.phone=child.phone;
    introduceVC.ltId =child.ltid;
    introduceVC.chetName=child.name;
    [self.navigationController pushViewController:introduceVC animated:YES];
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
