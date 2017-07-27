//
//  detailsViewController.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface detailsViewController : UIViewController
@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *newprice;
@property (nonatomic,strong) NSString *drugnamestr;
@property (nonatomic,assign) BOOL      isIntegral;

@property (nonatomic,strong) NSString *xiangqingtype;

@property (nonatomic,strong) NSString *oyid;
@end
