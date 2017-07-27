//
//  storeViewController.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "storeViewController.h"
#import "SwitchView.h"
#import "pharmarcySales.h"
#import "pharmarcyPrice.h"
#import "medicineCollectionViewCell.h"
#import "detailsViewController.h"
#import "SDCursorView.h"
#import "ShowViewController.h"
@interface storeViewController ()

@property (nonatomic,strong) SwitchView *switchView;
@property (nonatomic,strong) pharmarcySales *sales;
@property (nonatomic,strong) pharmarcyPrice *prices;
@property (nonatomic, strong) SDCursorView *cursorView;

@property (nonatomic,strong) NSMutableArray *titlearr;
@property (nonatomic,strong) NSMutableArray *idarr;

@end

@implementation storeViewController
static NSString *collection = @"imagecell";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CustomNavigation *customNavView = [[CustomNavigation alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 64)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:customNavView];
    
    
    [self.view addSubview:self.sales];
    [self.view addSubview:self.prices];
    
    
    customNavView.CustomNavLeftBtnClickBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    if ([self.typestr isEqualToString:@"guoyitang"]) {
        [self loaddatadele];
            [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:@"国医堂"];
    }
    if ([self.typestr isEqualToString:@"yaodian"]) {
        [self loaddatafromweb];
            [customNavView customNavLeftBtnImageName:@"back" leftBtnTitle:nil rightBtnImageName:nil rightBtnTitle:nil title:self.shopname];
    }
    
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
}

-(void)loaddatafromweb
{
    [AFManager getReqURL:[NSString stringWithFormat:productlist,self.pharid,@"",@"",@""] block:^(id infor) {
        NSLog(@"info = -------%@",infor);
        
        
        NSArray*dit = [infor objectForKey:@"data"];
        NSLog(@"------------------- = %@",[dit[0]objectForKey:@"classfition"]);
        
        NSArray *product = [dit[0]objectForKey:@"product"];
        NSLog(@"pruduct = --------%@",product);
        self.titlearr = [NSMutableArray array];
        self.idarr = [NSMutableArray array];
        for (int i = 0; i<dit.count; i++) {
            [self.titlearr addObject:[dit[i]objectForKey:@"classfition"]];
            [self.idarr addObject:[dit[i]objectForKey:@"id"]];
        }
        
        NSLog(@"title = %@",self.titlearr);
        
        _cursorView = [[SDCursorView alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), 40)];
        //设置子页面容器的高度
        _cursorView.contentViewHeight = CGRectGetHeight(self.view.bounds)-100;
        //设置控件所在controller
        _cursorView.parentViewController = self;
        _cursorView.titles = self.titlearr;
        
        //设置所有子controller
        NSMutableArray *contrors = [NSMutableArray array];
        for (NSString *title in self.idarr) {
            ShowViewController *controller = [[ShowViewController alloc]init];
            controller.content = title;
            controller.showtypestr = self.typestr;

            controller.shopid = self.pharid;
            [contrors addObject:controller];
        }
        _cursorView.controllers = [contrors copy];
        //设置字体和颜色
        _cursorView.normalColor = [UIColor blackColor];
        _cursorView.selectedColor = [UIColor wjColorFloat:KMedical_Blue];
        _cursorView.selectedFont = [UIFont systemFontOfSize:16];
        _cursorView.normalFont = [UIFont systemFontOfSize:13];
        _cursorView.backgroundColor = [UIColor whiteColor];
        _cursorView.lineView.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
        
        [self.view addSubview:_cursorView];
        
        //属性设置完成后，调用此方法绘制界面
        [_cursorView reloadPages];
        
        
    } errorblock:^(NSError *error) {
        
    }];
}

-(void)loaddatadele
{
    [AFManager getReqURL:guoyitang block:^(id infor) {
        NSLog(@"info = %@",infor);
        
        
        NSArray*dit = [infor objectForKey:@"data"];
       // NSLog(@"------------------- = %@",[dit[0]objectForKey:@"classfition"]);
        
        NSArray *product = [dit[0]objectForKey:@"product"];
        
        NSLog(@"pruduct = --------%@",product);
//        self.titlearr = [NSMutableArray arrayWithObject:@"全部"];
//        self.idarr = [NSMutableArray arrayWithObject:@"quanbu"];
        
        self.titlearr = [NSMutableArray array];
        self.idarr = [NSMutableArray array];

        for (int i = 0; i<dit.count; i++) {
            [self.titlearr addObject:[dit[i]objectForKey:@"classfition"]];
            [self.idarr addObject:[dit[i]objectForKey:@"id"]];
        }
        
        NSLog(@"title = %@",self.titlearr);
        
        _cursorView = [[SDCursorView alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.view.bounds), 40)];
        //设置子页面容器的高度
        _cursorView.contentViewHeight = CGRectGetHeight(self.view.bounds)-100;
        //设置控件所在controller
        _cursorView.parentViewController = self;
        _cursorView.titles = self.titlearr;
        
        //设置所有子controller
        NSMutableArray *contrors = [NSMutableArray array];
        for (NSString *title in self.idarr) {
            ShowViewController *controller = [[ShowViewController alloc]init];
            controller.content = title;
            controller.shopid = self.pharid;
            controller.showtypestr = self.typestr;
            
            [contrors addObject:controller];
        }
        _cursorView.controllers = [contrors copy];
        //设置字体和颜色
        _cursorView.normalColor = [UIColor blackColor];
        _cursorView.selectedColor = [UIColor wjColorFloat:KMedical_Blue];
        _cursorView.selectedFont = [UIFont systemFontOfSize:16];
        _cursorView.normalFont = [UIFont systemFontOfSize:13];
        _cursorView.backgroundColor = [UIColor whiteColor];
        _cursorView.lineView.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
        
        [self.view addSubview:_cursorView];
        
        //属性设置完成后，调用此方法绘制界面
        [_cursorView reloadPages];
        
        
    } errorblock:^(NSError *error) {
        
    }];
}

@end
