//
//  SettlelastCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class settleModel;
@interface SettlelastCell : UITableViewCell
@property (nonatomic,strong) UILabel *totalpricelabel;//总价
@property (nonatomic,strong) UILabel *preferentialpricelabel;//优惠价格
@property (nonatomic,strong) UILabel *actuallabel;//实际价格
-(void)setCellDate:(settleModel *)settle;
@end
