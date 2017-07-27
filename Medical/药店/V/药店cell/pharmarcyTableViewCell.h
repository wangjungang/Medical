//
//  pharmarcyTableViewCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWStarRateView.h"
@class pharmacyModel;

@interface pharmarcyTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *cellimage;
@property (nonatomic,strong) UILabel *cellname_label;
@property (nonatomic,strong) UILabel *cellnumber_label;
@property (nonatomic,strong) UILabel *celldistance_label;
@property (strong, nonatomic) CWStarRateView *starRateView;

-(void)setCellDate:(pharmacyModel *)pharmacy;

@end
