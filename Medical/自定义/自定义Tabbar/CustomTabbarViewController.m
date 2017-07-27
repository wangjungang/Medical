//
//  CustomTabbarViewController.m
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/1.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import "CustomTabbarViewController.h"
#import "CustomNavigation.h"
#import "HomeViewController.h"
#import "MedicalViewController.h"
#import "ClinicViewController.h"
#import "ShopCarViewController.h"
#import "PersonalCenterViewController.h"
#define TABBARBUTTON_WIDTH 20
#define TITLELABELWIDTH 50
#define TITLELABELHEIGHT 10
@interface CustomTabbarViewController ()
{
    NSMutableArray *_norImageArray;
    NSMutableArray *_selImageArray;
    NSMutableArray *_titleArray;
    NSMutableArray *_labelArray;
    UIButton *_selectedButton;
    UIView *_bgView;
    int _hightLightValue;
    
}
//@property (nonatomic,strong)HWAlertView *alertView;
@property (nonatomic,strong)UIView *adView;
@property (nonatomic,strong)UIImageView*adImageView;
@property (nonatomic,strong)NSDictionary *dic;
@property (nonatomic,strong)UIButton *btn;
@property (nonatomic,strong)UIButton *lookBtn;
@end

@implementation CustomTabbarViewController
//
static CustomTabbarViewController *tabbar;
+ (id)instanceTabBar
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabbar=[[CustomTabbarViewController alloc]init];
    });
    return tabbar;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    __autoreleasing NSMutableSet *tags = [NSMutableSet set];
    // Do any additional setup after loading the view.
    self.tabBar.hidden=YES;
    
    //tabbar正常情况下图片数组
    _norImageArray = [[NSMutableArray alloc] initWithObjects:@"tabbar-01.png",@"tabbar-02.png",@"tabbar-03.png",@"tabbar-04.png",@"tabbar-05.png", nil];
    //选种情况下图片数组 注：f-3选中和未选中状态图片一样
    _selImageArray = [[NSMutableArray alloc] initWithObjects:@"tabbar-sel01.png",@"tabbar-sel02.png",@"tabbar-sel03",@"tabbar-sel04.png",@"tabbar-sel05.png", nil];
    _titleArray = [[NSMutableArray alloc] initWithObjects:@"首页",@"诊所",@"药店",@"购物车",@"个人中心", nil];
    
    _labelArray = [[NSMutableArray alloc] init];
    //
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    
    //
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:[[MedicalViewController alloc] init]];
    //
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:[[ClinicViewController alloc] init]];
    //服务到家
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:[ShopCarViewController new]];
    //
    UINavigationController *nav5 = [[UINavigationController alloc] initWithRootViewController:[[PersonalCenterViewController alloc] init]];
    nav1.navigationBar.hidden = YES;
    nav2.navigationBar.hidden = YES;
    nav3.navigationBar.hidden = YES;
    nav4.navigationBar.hidden = YES;
    nav5.navigationBar.hidden = YES;
    self.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
//    _lastBtnTag=10;

//    [self getDataSource];
    [self createMyCustomTabbar];
}
-(void)createMyCustomTabbar
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, DEVICE_HEIGHT - 49, DEVICE_WIDTH, 49 )];
    
    _bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bgView];
    UILabel *lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, 1)];
    lineLabel.backgroundColor = kCOLOR(175, 175, 175, 1);
    [_bgView addSubview:lineLabel];

    for (int i = 0 ; i < 5; i++)
    {
        UIButton *tabbarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        tabbarButton.frame = CGRectMake(WIDTH_SCALE *(20 + i*(55 + 15)), 0, 55*WIDTH_SCALE,49);
        tabbarButton.tag = i + 10;
        [tabbarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0)
        {
            tabbarButton.selected = YES;
            _selectedButton = tabbarButton;
        }
        

        [tabbarButton addTarget:self action:@selector(tabbarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarButton setImage:[UIImage imageNamed:_norImageArray[i]] forState:UIControlStateNormal];
        [tabbarButton setImage:[UIImage imageNamed:_selImageArray[i]] forState:UIControlStateSelected];
        [tabbarButton setTitle:_titleArray[i] forState:UIControlStateNormal];
        [tabbarButton setTitleColor:kCOLOR(175, 174, 175, 1) forState:UIControlStateNormal];
        [tabbarButton setTitleColor:[UIColor wjColorFloat:KMedical_Blue] forState:UIControlStateSelected];
         UIImage *image = [UIImage imageNamed:_norImageArray[i]];
        tabbarButton.imageEdgeInsets = UIEdgeInsetsMake(8, 17 *WIDTH_SCALE, 23, 17*WIDTH_SCALE);
        tabbarButton.titleEdgeInsets = UIEdgeInsetsMake(25, -0.5*image.size.width - 31*WIDTH_SCALE, -7, 0.5*image.size.width -29*WIDTH_SCALE);
        tabbarButton.titleLabel.font = [UIFont systemFontOfSize:10*WIDTH_SCALE];
//        tabbarButton.titleLabel.backgroundColor = [UIColor yellowColor];
        tabbarButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_bgView addSubview:tabbarButton];
    }
}

-(void)tabbarButtonClick:(UIButton *)button
{
//    if (_lastBtnTag==button.tag)
//    {
//        return;
//    }
//    _lastBtnTag = button.tag;
    _selectedButton.selected = NO;
   
    button.selected = YES;

    self.selectedIndex = button.tag - 10;
    _selectedButton = button;
}
-(void)showTabbar
{
    _bgView.hidden = NO;
}
-(void)hideTabbar
{
    _bgView.hidden = YES;
}

-(void)jumpClinicViewController
{
//    _lastBtnTag=11;
    _selectedButton.selected = NO;
    UIButton *button = (UIButton*)[_bgView viewWithTag:11];
    button.selected = YES;
    self.selectedIndex = button.tag - 10;
    _selectedButton = button;
//    [button setImage:[UIImage imageNamed:_selImageArray[1]] forState:UIControlStateSelected];
//    [button setTitleColor:[UIColor wjColorFloat:KMedical_Blue] forState:UIControlStateSelected];
}
-(void)jumpMedicalViewController
{
//    _lastBtnTag=12;
    _selectedButton.selected = NO;
    UIButton *button = (UIButton*)[_bgView viewWithTag:12];
    button.selected = YES;
    self.selectedIndex = button.tag - 10;
    _selectedButton = button;
}
/*
#pragma mark -
#pragma mark 广告
- (void)getDataSource
{
    [AFManager getReqURL:[NSString stringWithFormat:@"http://yewen.yhoso.com/ajax_ad/getAd?ticket=%@",TICKET] block:^(id infor)
    {
        if ([[infor objectForKey:@"status"] integerValue]==200)
        {
            _dic=[infor objectForKey:@"data"];
            if ([_dic objectForKey:@"image"])
            {
                self.adView =[[UIView alloc]initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
                [self.view addSubview:self.adView];
                [self.view bringSubviewToFront:self.adView];
                self.adImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height)];
                self.adImageView.userInteractionEnabled=YES;
                [self.adImageView sd_setImageWithURL:[NSURL URLWithString:[_dic objectForKey:@"image"]]];
                [_adView addSubview:self.adImageView];
                [self performSelector:@selector(removeAdImageView) withObject:nil afterDelay:5];
                UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
                [self.adImageView addGestureRecognizer:tap];
                
                _btn=[UIButton buttonWithType:UIButtonTypeSystem];
                _btn.frame=CGRectMake(DEVICE_WIDTH-100, DEVICE_HEIGHT-30, 100, 30);
                [_btn setTitle:@"5 秒后跳过》" forState:0];
                [_btn setTitleColor:[UIColor whiteColor] forState:0];
                [self. adImageView addSubview:_btn];
                [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
                [self startCoundown];
                
                
                _lookBtn= [UIButton buttonWithType:UIButtonTypeSystem];
                [_lookBtn setTitle:@"点击查看" forState:0];
                [_lookBtn setTitleColor:[UIColor whiteColor] forState:0];
                [_lookBtn addTarget:self action:@selector(lookUrl) forControlEvents:UIControlEventTouchUpInside];
                _lookBtn.frame=CGRectMake(DEVICE_WIDTH-100, 30, 100, 30);
                [self.adImageView addSubview:_lookBtn];
            }
        }
    } errorblock:^(NSError *error) {
        
    }];
}
- (void)lookUrl
{
    AdvertisementVC*vc=[AdvertisementVC new];
    vc.url=[_dic objectForKey:@"url"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)btnClick
{
     [self removeAdImageView];
}
static NSInteger showtime=5;
// GCD倒计时
- (void)startCoundown
{
    __block NSInteger timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self removeAdImageView];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                _btn.titleLabel.text=[NSString stringWithFormat:@"%ld 秒后跳过》",(long)timeout];
                [_btn setTitle:[NSString stringWithFormat:@"%ld 秒后跳过》",(long)timeout] forState:UIControlStateNormal];
            });  
            timeout--;  
        }  
    });  
    dispatch_resume(_timer);  
}
- (void)removeAdImageView
{
    [UIView animateWithDuration:0.3f animations:^{
        
//        self.adImageView.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
        
        self.adImageView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self.adImageView removeFromSuperview];
        [self.adView removeFromSuperview];
    }];
}
- (void)tap:(UITapGestureRecognizer*)tap
{
    AdvertisementVC*vc=[AdvertisementVC new];
    vc.url=[_dic objectForKey:@"url"];
    [self.navigationController pushViewController:vc animated:YES];
}
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
