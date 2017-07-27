//
//  DuizhengXiayaoViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "DuizhengXiayaoViewController.h"
#import "DuizhengXiayaoRightCell.h"
@interface DuizhengXiayaoViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>
{
    UITableView *_leftTable;
    UICollectionView *_rightCollectionView;
    //左侧表区头数据数组
    NSMutableArray *_leftSectionTitleArray;
    //左侧表cell数组  二维 存的是每个区的标题数组
    NSMutableArray *_leftCellTitleArray;
    //右侧表数据数组
    NSMutableArray *_rightDataArray;
    
    UIButton *_selectedButton;
    
    NSIndexPath *_lastIndexPath;
    //
//    UIView *leftView;
}
@end

@implementation DuizhengXiayaoViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar = [CustomTabbarViewController instanceTabBar];
    [tabbar hideTabbar];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = kCOLOR(210, 210, 210, 0.3);
    self.view.backgroundColor = [UIColor whiteColor];
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"对症下药"];
    [self.view addSubview:customNavView];
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
 
    _leftSectionTitleArray = [[NSMutableArray alloc] init];
//    NSMutableArray *titleArray = [[NSMutableArray alloc] init];
    _leftCellTitleArray = [[NSMutableArray alloc] init];
    _rightDataArray = [[NSMutableArray alloc] initWithObjects:@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧",@"感冒发烧", nil];
//    [self createTableView];
    [self createHeaderSanjiao:_leftSectionTitleArray];
    [self getRequestDuizhengList];
}
-(void)getRequestDuizhengList
{
    [AFManager getReqURL:Duizheng_FenleiList_URL block:^(id infor) {
        NSLog(@"list===%@",infor);
        DuizhengListDataModels *dataModels = [DuizhengListDataModels modelObjectWithDictionary:infor];
        [_leftSectionTitleArray addObjectsFromArray:dataModels.data];
//        
//        for (  DuizhengListData *data in _leftSectionTitleArray)
//        {
//        
//            [_leftCellTitleArray addObjectsFromArray:data.title];
//        }
//        [self createLeftHeadeView:_leftSectionTitleArray ]
        [self createTableView];
        [_leftTable reloadData];
    } errorblock:^(NSError *error) {
        
    }];
}
-(void)createHeaderSanjiao:(NSMutableArray *)array
{
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectedButton.tag = 999;
}
-(void)createTableView
{
    if (!_leftTable) {
        _leftTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, 110, DEVICE_HEIGHT ) style:UITableViewStyleGrouped];
        _leftTable.translatesAutoresizingMaskIntoConstraints =NO;
        _leftTable.delegate = self;
        _leftTable.dataSource = self;
        _leftTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _leftTable.sectionFooterHeight = 0;
        [_leftTable setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
        [_leftTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"leftTableCell"];
        //    _leftTable.backgroundColor = kCOLOR(210, 210, 210, 0.3);
        _leftTable.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_leftTable];
    }
    if (!_rightCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2 *WIDTH_SCALE;
        layout.minimumInteritemSpacing = 1 *HEIGHT_SCALE;
        layout.itemSize = CGSizeMake((DEVICE_WIDTH -115)/2 - 5 , 155 *HEIGHT_SCALE);
        layout.footerReferenceSize = CGSizeMake(DEVICE_WIDTH, 5*HEIGHT_SCALE);
        _rightCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(110, 64, DEVICE_WIDTH -115, DEVICE_HEIGHT ) collectionViewLayout:layout];
        _rightCollectionView.delegate = self;
        _rightCollectionView.dataSource = self;
        _rightCollectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 0);
        _rightCollectionView.backgroundColor = kCOLOR(210, 210, 210, 0.3);
        [_rightCollectionView registerClass:[DuizhengXiayaoRightCell class] forCellWithReuseIdentifier:@"rightCell"];
        [self.view addSubview:_rightCollectionView];
    }
  
}

#pragma mark -
#pragma mark tableView代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_selectedButton.tag == section )
    {
        DuizhengListData *data = _leftSectionTitleArray[section];
        [_leftCellTitleArray addObjectsFromArray:data.title];
    //当表展开的时候，再返回对应的行数
//        NSMutableArray *array = _leftCellTitleArray[section];
        return _leftCellTitleArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        UITableViewCell *leftCell =[tableView dequeueReusableCellWithIdentifier:@"leftTableCell" forIndexPath:indexPath];
        leftCell.textLabel.font=[UIFont systemFontOfSize:12 *WIDTH_SCALE weight:1 *WIDTH_SCALE];
//        leftCell.backgroundColor = [UIColor purpleColor];
        leftCell.textLabel.textColor = [UIColor wjColorFloat:@"5b5b5b"];
    DuizhengListData *data = _leftSectionTitleArray[indexPath.section];
    [_leftCellTitleArray addObjectsFromArray:data.title];
    DuizhengListTitle *title = _leftCellTitleArray[indexPath.row];
//    leftCell.textLabel.text = title.classfition;
        leftCell.textLabel.text = [NSString stringWithFormat:@"· %@",title.classfition] ;
        leftCell.textLabel.textAlignment = NSTextAlignmentCenter;
        UILabel *cellLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 39 *HEIGHT_SCALE, 110, 1 *HEIGHT_SCALE)];
    
        cellLineLabel.backgroundColor = kCOLOR(210, 210, 210, 0.2);
        [leftCell.contentView addSubview:cellLineLabel];

    leftCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return leftCell;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return _leftSectionTitleArray.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _leftSectionTitleArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 40 *HEIGHT_SCALE;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 40 *HEIGHT_SCALE;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
       UIView * leftView = [[UIView alloc] init];
//        leftView.backgroundColor = [UIColor yellowColor];
        leftView.tag = section;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLeftSectionHeaderRecognizer:)];
        [leftView addGestureRecognizer:tap];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40 *HEIGHT_SCALE)];
        DuizhengListData *data = _leftSectionTitleArray[section];
        titleLabel.text = data.classfition;
        titleLabel.textColor = [UIColor wjColorFloat:@"5b5b5b"];
        titleLabel.textAlignment = NSTextAlignmentRight;
        titleLabel.font = [UIFont systemFontOfSize:14*WIDTH_SCALE weight:1*WIDTH_SCALE];
        [leftView addSubview:titleLabel];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(85, 17*HEIGHT_SCALE, 5, 5)];
    if (_selectedButton.tag == section) {
        imageview.image = [UIImage imageNamed:@"三角2"];
    }
    else{
        imageview.image = [UIImage imageNamed:@"三角1"];
    }
    [leftView addSubview:imageview];

        UILabel *secLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 38 *HEIGHT_SCALE, 110, 2 *HEIGHT_SCALE)];
        secLineLabel.backgroundColor = kCOLOR(210, 210, 210, 0.3);
        [leftView addSubview:secLineLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 110, 40 *HEIGHT_SCALE);
    button.backgroundColor = [UIColor clearColor];
    button.tag = section;
    [button addTarget:self action:@selector(tapLeftSectionHeaderRecognizer:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:button];
    return leftView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (UITableViewCell *tempCell in [tableView visibleCells])
    {
        if ([cell isEqual:tempCell])
        {
            cell.textLabel.textColor = [UIColor wjColorFloat:@"01c4c8"];
        }
        else
        {
            tempCell.textLabel.textColor = [UIColor wjColorFloat:@"5b5b5b"];

        }
    }
    _lastIndexPath = indexPath;
    [_rightCollectionView setContentOffset:CGPointMake(-5 *WIDTH_SCALE,(indexPath.section+1)* indexPath.row *( (15/2  +1) *155 *HEIGHT_SCALE + 18*HEIGHT_SCALE)) animated:YES];
//    [_rightCollectionView reloadData];
    
}
#pragma mark --左边区头的点击方法
-(void)tapLeftSectionHeaderRecognizer:(UIButton *)button
{
    
    if (_selectedButton.tag == button.tag) {
        _selectedButton.tag = 999;
    }
    else{
        _selectedButton.tag = button.tag;
    }

    [_leftTable reloadData];

}

#pragma mark --UICollectionView代理方法--
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 15;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DuizhengXiayaoRightCell *rightCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rightCell" forIndexPath:indexPath];
    rightCell.backgroundColor = [UIColor whiteColor];
    [rightCell getDuizhengRightDataSource:_rightDataArray];

    return rightCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击医院%ld",indexPath.item);
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"111");

//  NSInteger index =  _rightCollectionView.contentOffset.y/( (15/2  +1) *155 *HEIGHT_SCALE + 18*HEIGHT_SCALE);
//    NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:index/15];
//    NSIndexPath *indexPath = [[NSIndexPath alloc] initWithIndex:index/15];
    
//    if (_selectedButton.tag == index) {
//        _selectedButton.tag = 999;
//    }
//    else{
//        _selectedButton.tag = index;
//    }
//    
//    [_leftTable reloadData];
//    UITableViewCell *cell = [_leftTable cellForRowAtIndexPath:indexPath];
//    for (UITableViewCell *tempCell in [_leftTable visibleCells])
//    {
//        if ([cell isEqual:tempCell])
//        {
//            cell.textLabel.textColor = [UIColor wjColorFloat:@"01c4c8"];
//        }
//        else
//        {
//            tempCell.textLabel.textColor = [UIColor wjColorFloat:@"5b5b5b"];
//            
//        }
//    }
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
