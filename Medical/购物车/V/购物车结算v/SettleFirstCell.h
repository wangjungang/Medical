//
//  SettleFirstCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class settleModel;
@interface SettleFirstCell : UITableViewCell
@property (nonatomic,strong) UILabel *addresslabel;
-(void)setCellDate:(settleModel *)settle;
@end
