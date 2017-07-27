//
//  ShopCarViewController.m
//  Medical
//
//  Created by 张婷 on 16/11/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "ShopCarViewController.h"
#import "shopcarView.h"
#import "shopcarCell.h"
#import "settlementViewController.h"
#import "shopcarModel.h"

@interface ShopCarViewController ()<UITableViewDataSource,UITableViewDelegate,shopTabVdelegate>
{
    BOOL isequal;
    CGFloat sum;
    CGFloat oldsum;
}
@property (nonatomic,strong) UITableView *shoptableView;
@property (nonatomic,strong) shopcarView *shopview;
@property (nonatomic,strong) shopcarCell *cell;


@property (nonatomic,strong) NSMutableArray *shoparr;
@property (nonatomic,strong) shopcarModel *shopmodel;

@property (nonatomic,strong) NSArray *dit;

@property (nonatomic,strong) NSMutableArray *pricearr;
@property (nonatomic,strong) NSMutableArray *oldpricearr;

@property (nonatomic,strong) NSMutableArray *pidarr;
@property (nonatomic,strong) NSMutableArray *numberarr;
@property (nonatomic,strong) NSMutableArray *oyidarr;
@property (nonatomic,strong) NSMutableArray *shopcaridarr;
@property (nonatomic,strong) NSString *pidstr;
@property (nonatomic,strong) NSString *oyidstr;
@property (nonatomic,strong) NSString *numberstr;
@property (nonatomic,strong) NSString *shopcaridstr;
@property (nonatomic,strong) NSString *specif;

@end
static NSString *shopidentfid = @"shopidentfid";
@implementation ShopCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [customNavView customNavLeftBtnImageName:nil leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"购物车"];
    isequal = YES;
    

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    [self.view addSubview:self.shoptableView];
    [self.view addSubview:self.shopview];
    self.shoptableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    CustomTabbarViewController *tabbar=[CustomTabbarViewController instanceTabBar];
    [tabbar showTabbar];
    self.shoptableView.frame = CGRectMake(0, 64, DEVICE_WIDTH, (DEVICE_HEIGHT-160)*HEIGHT_SCALE);
    self.shopview.frame = CGRectMake(0, DEVICE_HEIGHT-110, DEVICE_WIDTH, 60);
    [self loaddataformweb];
}

-(void)loaddataformweb
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:shopcarlist,uid] block:^(id infor) {
        NSLog(@"info = %@",infor);
        self.dit = [infor objectForKey:@"data"];
        self.shoparr = [NSMutableArray array];
        for (int i = 0; i<self.dit.count; i++) {
            NSDictionary *dicarr = [self.dit objectAtIndex:i];
            self.shopmodel = [[shopcarModel alloc] init];
            self.shopmodel.durgname = dicarr[@"drug_name"];
            self.shopmodel.durgnumber = dicarr[@"number"];
            //self.shopmodel.durgprice = dicarr[@"totalprice"];
     
            self.shopmodel.drugpid = dicarr[@"pid"];
            self.shopmodel.shopcarid = dicarr[@"id"];
            self.shopmodel.shopyid = dicarr[@"yid"];
            self.shopmodel.olddrugpirce = dicarr[@"oldprice"];
            self.shopmodel.shopcarimageurl = dicarr[@"picture"];
            self.shopmodel.newprice = dicarr[@"nowprice"];
            self.shopmodel.selectState = NO;
            CGFloat price = [dicarr[@"number"] floatValue]*[dicarr [@"nowprice"] floatValue];
            self.shopmodel.durgprice = [NSString stringWithFormat:@"%.2f",price];
            [self.shoparr addObject:self.shopmodel];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.shoptableView reloadData];
        });
        
    } errorblock:^(NSError *error) {
        [NSObject wj_showHUDWithTip:@"请检查网络"];
    }];
    
    
    for (int s=0; s<self.dit.count; s++) {
        NSDictionary *sat = self.dit[s];
        NSString *satt = [sat objectForKey:@"pid"];
        [self.pidarr addObject:satt];
    }
    
    [self totalPrice];
}

#pragma mark - getters

-(UITableView *)shoptableView
{
    if(!_shoptableView)
    {
        _shoptableView = [[UITableView alloc] init];
        _shoptableView.dataSource = self;
        _shoptableView.delegate = self;
    }
    return _shoptableView;
}

-(shopcarView *)shopview
{
    if(!_shopview)
    {
        _shopview = [[shopcarView alloc] init];
        _shopview.backgroundColor = [UIColor whiteColor];
        [_shopview.choosebtn addTarget:self action:@selector(chooseallbtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [_shopview.invoicingbtn addTarget:self action:@selector(payment) forControlEvents:UIControlEventTouchUpInside];
        _shopview.layer.masksToBounds = YES;
        _shopview.layer.borderWidth = 0.3;
        _shopview.layer.borderColor = [[UIColor wjColorFloat:@"cccccc"] CGColor];
    }
    return _shopview;
}

#pragma mark -UITableViewDataSource && UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shoparr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [tableView dequeueReusableCellWithIdentifier:shopidentfid];
    if (!_cell) {
        _cell = [[shopcarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:shopidentfid];
    }
     _cell.delegate = self;
    [_cell setCellDate:self.shoparr[indexPath.row]];
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [_cell setSeparatorInset:UIEdgeInsetsZero];
    return _cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 188.0f/2*HEIGHT_SCALE;
}

#pragma mark - 实现方法

//全选按钮方法

-(void)chooseallbtnclick:(UIButton *)sender
{
    //判断是否选中，是改成否，否改成是，改变图片状态
    sender.tag = !sender.tag;
    if (sender.tag)
    {
        [sender setImage:[UIImage imageNamed:@"组19"] forState:UIControlStateNormal];
        
    }else{
        [sender setImage:[UIImage imageNamed:@"椭圆5"] forState:UIControlStateNormal];
    }
    //改变单元格选中状态
    for (int i=0; i<self.shoparr.count; i++)
    {
        shopcarModel *model = [self.shoparr objectAtIndex:i];
        model.selectState = sender.tag;
    }
    //计算价格
    [self totalPrice];
    //刷新表格
    [self.shoptableView reloadData];
}

-(void)payment
{
    NSLog(@"去结账");
    
    NSMutableArray *selecarr = [NSMutableArray array];
    
    for (int i=0; i<self.shoparr.count; i++) {
        shopcarModel *model = self.shoparr[i];
        NSString *str = [NSString stringWithFormat:@"%d",model.selectState];
        [selecarr addObject:str];
    }
    
    if ([selecarr containsObject:@"1"])
    {
        self.pidarr = [NSMutableArray array];
        self.oyidarr = [NSMutableArray array];
        self.numberarr = [NSMutableArray array];
        self.shopcaridarr = [NSMutableArray array];
        
        for (int t=0; t<self.shoparr.count; t++) {
            if ([selecarr[t] isEqualToString:@"1"]) {
                shopcarModel *model = [self.shoparr objectAtIndex:t];
                [self.shopcaridarr addObject:model.shopcarid];
            }
        }
        self.shopcaridstr = [self.shopcaridarr componentsJoinedByString:@","];
        NSLog(@"numberstr ------- %@",self.numberstr);
        
        NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
        
        NSInteger arcdom=arc4random();
        NSString *idStr=[NSString stringWithFormat:@"%ld",(long)arcdom];
        NSDate* today = [NSDate date];
        NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString* s1 = [df stringFromDate:today];
        NSDate* date1 = [df dateFromString:s1];
        NSDateFormatter*df2 = [[NSDateFormatter alloc]init];//格式化
        [df2 setDateFormat:@"yyyyMMddHHmmss"];
        [df2 setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
        NSLog(@"data===%@",[df2 stringFromDate:date1]);
        
        NSString *dingdanstr  = [NSString stringWithFormat:@"%@%@%@",[df2 stringFromDate:date1],uid,idStr];

        
        NSDictionary *dit = [NSDictionary dictionary];
        dit = @{@"ouid":uid,@"aid":@"2",@"id":dingdanstr,@"cartid":self.shopcaridstr};
        NSLog(@"dit--------------%@",dit);
        
        [AFManager postReqURL:addorder reqBody:dit block:^(id infor) {
        
           NSLog(@"info===%@",infor);
           if ([[infor objectForKey:@"code"]integerValue]==200) {
               [NSObject wj_showHUDWithTip:@"添加成功"];
               settlementViewController *settleVC = [[settlementViewController alloc] init];
               settleVC.dingdan = dingdanstr;
               [self.navigationController pushViewController:settleVC animated:YES];
               
               sum=0.0;
               oldsum = 0.0;
               self.shopview.combinedlabel.text = [NSString stringWithFormat:@"%@%.2f",@"商品总价:¥",sum];
               self.shopview.specificpricelabel.text = [NSString stringWithFormat:@"%@%.2f%@%.2f",@"总额",oldsum,@"享折扣¥",sum];
               
               self.specif = [NSString stringWithFormat:@"%lf",sum];
               
           }
        
       }];
        
   }
   else
   {
        [NSObject wj_showHUDWithTip:@"请选择商品"];
     
   }
    
}

#pragma mark -- 计算价格

-(void)totalPrice
{
    //遍历整个数据源，然后判断如果是选中的商品，就计算价格（单价 * 商品数量）

    for ( int i =0; i<self.shoparr.count; i++)
    {
        shopcarModel *model = [self.shoparr objectAtIndex:i];
        if (model.selectState)
        {
            CGFloat pri = [model.newprice floatValue] * [model.durgnumber floatValue];
            
            sum = sum +pri;
            CGFloat pldpri = [model.olddrugpirce floatValue] *[model.durgnumber floatValue] ;
            oldsum = oldsum +pldpri;
        }
    }
    NSLog(@"%f",sum);
    
    self.shopview.combinedlabel.text = [NSString stringWithFormat:@"%@%.2f",@"商品总价:¥",sum];
    self.shopview.specificpricelabel.text = [NSString stringWithFormat:@"%@%.2f%@%.2f",@"总额",oldsum,@"享折扣¥",sum];
    
    self.specif = [NSString stringWithFormat:@"%lf",sum];
    
    sum=0.0;
    oldsum = 0.0;
}

#pragma mark - shopTabVdelegate

-(void)shopaddClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [_shoptableView indexPathForCell:cell];
    NSLog(@"add===%ld",index.row);
    
    shopcarModel *model = self.shoparr[index.row];
    int number = [model.durgnumber intValue] +1;
    model.durgnumber = [NSString stringWithFormat:@"%d",number];
   
    CGFloat drugprice = number * [model.newprice floatValue];
    model.durgprice = [NSString stringWithFormat:@"%.2f",drugprice];
    
    [self totalPrice];
    
    //[self loaddataformweb];
    
    NSString *numberstr = [NSString stringWithFormat:@"%d",number];
    NSLog(@"numberstr---------%@",numberstr);
    [AFManager postReqURL:editcart reqBody:@{@"id":model.shopcarid,@"number":numberstr} block:^(id infor) {
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
//            [NSObject wj_showHUDWithTip:@"修改成功"];
        }
        else
        {
            [NSObject wj_showHUDWithTip:@"请检查网络"];
        }
    }];
    
    [self.shoptableView reloadData];
}

-(void)shopdeleteClick:(UITableViewCell *)cell
{
    NSIndexPath *index = [_shoptableView indexPathForCell:cell];
    NSLog(@"delete===%ld",index.row);
    shopcarModel *model = self.shoparr[index.row];
    if ([model.durgnumber intValue]>1) {
        int number = [model.durgnumber intValue] -1;
        model.durgnumber = [NSString stringWithFormat:@"%d",number];
        CGFloat drugprice = number * [model.newprice floatValue];
        model.durgprice = [NSString stringWithFormat:@"%.2f",drugprice];
        NSString *numberstr = [NSString stringWithFormat:@"%d",number];
        NSLog(@"numberstr---------%@",numberstr);
        [AFManager postReqURL:editcart reqBody:@{@"id":model.shopcarid,@"number":numberstr} block:^(id infor) {
            if ([[infor objectForKey:@"code"]integerValue]==200)
            {
//                [NSObject wj_showHUDWithTip:@"修改成功"];
            }
            else
            {
                [NSObject wj_showHUDWithTip:@"请检查网络"];
            }
        }];
    }
    [self totalPrice];
    [self.shoptableView reloadData];
}

-(void)shopTabVClick:(UITableViewCell *)cell
{

    NSIndexPath *index = [_shoptableView indexPathForCell:cell];
    
    /**
     *  判断当期是否为选中状态，如果选中状态点击则更改成未选中，如果未选中点击则更改成选中状态
     */
    shopcarModel *model = _shoparr[index.row];
    
    if (model.selectState)
    {
        model.selectState = NO;
    }
    else
    {
        model.selectState = YES;
    }
    
    //刷新整个表格
    [self.shoptableView reloadData];
    
    //计算价格
    [self totalPrice];
    
    //刷新当前行
    [self.shoptableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:@"确定要删除这个商品吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        shopcarModel *model = self.shoparr[indexPath.row];
        NSString *shopid = model.shopcarid;
        NSLog(@"shopid = %@",shopid);
        NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
        
        [AFManager getReqURL:[NSString stringWithFormat:delshopcar,shopid,uid] block:^(id infor) {
             NSLog(@"info = %@",infor);
            if ([[infor objectForKey:@"code"]integerValue]==200)
            {
                [NSObject wj_showHUDWithTip:@"删除成功"];
                [self totalPrice];
            }
            if ([[infor objectForKey:@"code"]integerValue]==201)
            {
                [NSObject wj_showHUDWithTip:@"删除错误，请检查网络"];
            }
        } errorblock:^(NSError *error) {
            NSLog(@"error = %@",error);
            [NSObject wj_showHUDWithTip:@"请检查网络"];
        }];
        
        
        [tableView setEditing:NO animated:YES];
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [self.shoparr removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [self.shoptableView reloadData];
            
        }
        
    }];
    
    [alertcontrol addAction:action1];
    [alertcontrol addAction:action2];
    [self presentViewController:alertcontrol animated:YES completion:nil];
    
}

//修改编辑按钮文字

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//设置进入编辑状态时，Cell不会缩进

- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
