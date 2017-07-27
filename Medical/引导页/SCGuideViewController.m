//
//  SCGuideViewController.m
//  SCGuide
//
//  Created by show class on 15/11/30.
//  Copyright © 2015年 show class. All rights reserved.
//

#import "SCGuideViewController.h"
#import "CALayer+Transition.h"
#import "UIView+Uitls.h"

@interface SCGuideViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *pageScroll;
@property (nonatomic, strong) UIViewController *con;
@property (nonatomic, strong) UIPageControl *page;
@end

@implementation SCGuideViewController

- (id)initWithViewController:(UINavigationController *)controller
{
    if (self = [super init]) {
        _con = controller;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray *imageNameArray = [NSArray arrayWithObjects:@"01引导页", @"02引导页", @"03引导页", nil];
    
    _pageScroll = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _pageScroll.bounces = NO;
    _pageScroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _pageScroll.showsHorizontalScrollIndicator = NO;
    _pageScroll.delegate = self;
    _pageScroll.pagingEnabled = YES;
    _pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * imageNameArray.count, self.view.frame.size.height);
    [self.view addSubview:_pageScroll];
    _page = [[UIPageControl alloc]initWithFrame:CGRectMake(DEVICE_WIDTH/2-50, DEVICE_HEIGHT-25, 100, 20)];
    _page.numberOfPages=imageNameArray.count;
    _page.pageIndicatorTintColor = Line_Color;
    _page.currentPageIndicatorTintColor = [UIColor wjColorFloat:KMedical_Blue];
    [_page setEnabled:NO];
    NSString *imageName = nil;
    for (int i = 0; i < imageNameArray.count; i++) {
        imageName = [imageNameArray objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT);
        imageView.origin = CGPointMake(i * imageView.width, 0);
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.userInteractionEnabled = YES;
        [self.pageScroll addSubview:imageView];
        
        UIButton *enterBtn = nil;
        if (i == imageNameArray.count - 1) {
            
            enterBtn = [[UIButton alloc] initWithFrame:(CGRect){
                .origin = {.x = (self.view.width - 120) / 2, .y = self.view.height - 70},
                .size = {.width = 120 , .height = 30}
            }];
            
            [enterBtn setBackgroundImage:[UIImage imageNamed:@"立即体验.png"] forState:UIControlStateNormal];
            [enterBtn setBackgroundImage:[UIImage imageNamed:@"立即体验.png"] forState:UIControlStateHighlighted];
            [enterBtn addTarget:self action:@selector(enter) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:enterBtn];
        }
        
    }
    [_pageScroll setContentOffset:CGPointMake(0.f, 0.f)];
    [self.view addSubview:_page];}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _page.currentPage=scrollView.contentOffset.x/DEVICE_WIDTH;
}
- (BOOL)prefersStatusBarHidden
{
    return YES; // 返回NO表示要显示，返回YES将hiden
}

- (void)enter
{
    [self transition:TransitionAnimTypePageCurl];
}


- (void)transition:(TransitionAnimType)type
{
    [UIApplication sharedApplication].delegate.window.rootViewController = _con;
    [[UIApplication sharedApplication].delegate.window.layer transitionWithAnimType:type subType:TransitionSubtypesFromRight curve:TransitionCurveLinear duration:0.6f];
}

@end
