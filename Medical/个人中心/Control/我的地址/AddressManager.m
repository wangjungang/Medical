//
//  AddressManager.m
//  YeWenOwner
//
//  Created by HOSO MAC 1 on 16/8/23.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import "AddressManager.h"
//自定义cell
#import "AddressCell.h"

//新增地址cell
#import "NewAddress.h"

//
#import "myaddressModel.h"
#import "NSString+Extend.h"
#define CELLID @"AddressCell"
#define CELL2ID @"btnCell"
@interface AddressManager ()<UITableViewDelegate,UITableViewDataSource,defaultTabVdelegate>
{
    UITableView *litab;
    NSMutableArray *dataSource;
}
@property (nonatomic,strong)CustomNavigation *customNavView;
    
@property (nonatomic,strong)myaddressModel *myaddmodel;

@property (nonatomic,strong)NSMutableArray *addressarr;

@property (nonatomic,strong)NSString *namestr;
@property (nonatomic,strong)NSString *addressstr;
@property (nonatomic,strong)NSString *mobilestr;
@end

@implementation AddressManager
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[CustomTabbarViewController instanceTabBar]hideTabbar];
    [self loaddatafromweb];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   _customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    [_customNavView customNavLeftBtnImageName:@"back.png" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:@"添加" title:@"地址管理"];
    [self.view addSubview:_customNavView];
    __weak AddressManager *weakSelf=self;
    weakSelf.customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    weakSelf.customNavView.CustomNavRightBtnClickBlock=^{
        NewAddress*address=[NewAddress new];
        address.index=0;
        address.isAdd=YES;
        address.type = @"添加";
        [self.navigationController pushViewController:address animated:YES];
    };
    weakSelf.customNavView.ChanageViewFrameBlock=^(BOOL isShow){
        if (!isShow) {
            [self getAddressDataSource];
        }
    };
    [self initTable];
    
}

-(void)loaddatafromweb
{
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    [AFManager getReqURL:[NSString stringWithFormat:AddressListURL,uid] block:^(id infor)
     {
         NSLog(@"info = %@",infor);
         NSArray *dit = [infor objectForKey:@"data"];
         self.addressarr = [NSMutableArray array];
         for (int i = 0; i<dit.count; i++) {
             self.myaddmodel = [[myaddressModel alloc] init];
             NSDictionary *dicarr = [dit objectAtIndex:i];
             self.myaddmodel.addressname = dicarr[@"savename"];
             self.myaddmodel.addressmobile = dicarr[@"mobile"];
             self.myaddmodel.address = dicarr[@"address"];
             self.myaddmodel.area = dicarr[@"area"];
             self.myaddmodel.isdefault = dicarr[@"status"];
             self.myaddmodel.addid = dicarr[@"id"];
             [self.addressarr addObject:self.myaddmodel];
         }
         dispatch_async(dispatch_get_main_queue(), ^{
             [litab reloadData];
         });
         
     } errorblock:^(NSError *error)
     {
         NSLog(@"%@",error);
     }];
}

- (void)initTable
{
    if (!litab) {
        litab =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStyleGrouped];
        litab.dataSource=self;
        litab.delegate=self;
        [self.view addSubview:litab];
        [litab registerClass:[AddressCell class] forCellReuseIdentifier:CELLID];
        
    }else{
        [litab reloadData];
    }
}

#pragma mark -
#pragma mark 获取地址

- (void)getAddressDataSource
{
   
}

#pragma mark -
#pragma mark tableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    cell = [[AddressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELLID];
    [cell setCellDataSource:self.addressarr[indexPath.section]];
    cell.delegate = self;
    return cell;;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.addressarr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewAddress *newvc = [[NewAddress alloc] init];
    newvc.type = @"cell";
    myaddressModel *model=self.addressarr[indexPath.section];
    newvc.namestr = model.addressname;
   // NSString *add = model.address;
    newvc.addressid = model.addid;
  
//    NSArray *array = [add componentsSeparatedByString:@"."];
//    for (int i = 0; i<array.count; i++) {
//        newvc.cityaddress = [array objectAtIndex:0];
//        newvc.detailedaddress = [array objectAtIndex:1];
//    }
    
    
    newvc.cityaddress = model.address;
    newvc.detailedaddress = model.area;
    newvc.phonestr = model.addressmobile;
    [self.navigationController pushViewController:newvc animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        return F_I6_SIZE(100);
    }else{
        return F_I6_SIZE(30);
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section==0?0.1:5;
}

#pragma mark - 滑动删除

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
        UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            
            UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:@"确定要删除这个地址吗" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
                myaddressModel *model=self.addressarr[indexPath.section];
                NSString *addid = model.addid;
                [AFManager getReqURL:[NSString stringWithFormat:delAddressURL,uid,addid] block:^(id infor) {
                    NSLog(@"infor = %@",infor);
                    if ([[infor objectForKey:@"code"]integerValue]==200)
                    {
                        // 更新数据
                        [self.addressarr removeObjectAtIndex:indexPath.section];
                        
                        [litab reloadData];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [litab reloadData];
                        });
                        [NSObject wj_showHUDWithTip:@"删除成功"];
                        
                        self.addressstr = @"  ";
                        [[NSNotificationCenter defaultCenter]postNotificationName:@"deladdress" object:self.addressstr];
                        self.mobilestr = @"  ";
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"delphone" object:self.mobilestr];
                        self.namestr = @"请选择地址";
                         [[NSNotificationCenter defaultCenter]postNotificationName:@"delname" object:self.namestr];
                        
                    }
                } errorblock:^(NSError *error) {
                    [NSObject wj_showHUDWithTip:@"请检查网络"];
                    NSLog(@"error = %@",error);
                }];
                
            }];
            
            [alertcontrol addAction:action1];
            [alertcontrol addAction:action2];
            [self presentViewController:alertcontrol animated:YES completion:nil];
        }];
        
        deleteRowAction.backgroundColor = [UIColor redColor];
        
        return @[deleteRowAction];
}

-(void)defaultTabVClick:(UITableViewCell *)cell
{
    NSLog(@"defaultbtnclick");
    NSIndexPath *index = [litab indexPathForCell:cell];
    NSString *uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
    myaddressModel *model=self.addressarr[index.section];
    NSString *addid = model.addid;
    
    [AFManager getReqURL:[NSString stringWithFormat:AddressSetURL,uid,addid] block:^(id infor) {
        NSLog(@"infor = %@",infor);
        if ([[infor objectForKey:@"code"]integerValue]==200)
        {
            [NSObject wj_showHUDWithTip:@"设置成功"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loaddatafromweb];
                [litab reloadData];
            });
            
            self.namestr = [[NSString alloc] init];
            self.namestr = model.addressname;
            self.mobilestr = [[NSString alloc] init];
            self.mobilestr = model.addressmobile;
            self.addressstr = [[NSString alloc] init];
           // self.addressstr = model.address;
            self.addressstr = [NSString stringWithFormat:@"%@%@",model.address,model.area];
            
            NSString *addid = model.addid;
            //观察者方法
            [[NSNotificationCenter defaultCenter]postNotificationName:@"defaultname" object:self.namestr];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"defaultmobile" object:self.mobilestr];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"defaultaddress" object:self.addressstr];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:@"addid" object:addid];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorblock:^(NSError *error) {
        NSLog(@"error = %@",error);
        [NSObject wj_showHUDWithTip:@"请检查网络"];
    }];
    
}

@end
