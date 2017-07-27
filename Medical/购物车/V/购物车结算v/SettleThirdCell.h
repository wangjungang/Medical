//
//  SettleThirdCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class settleModel;

@interface SettleThirdCell : UITableViewCell
@property (nonatomic,strong) UIImageView *leftimage;
@property (nonatomic,strong) UILabel *hospitalname;

@property (nonatomic,strong) UILabel *druglabel;
@property (nonatomic,strong) UILabel *numberlabel;
@property (nonatomic,strong) UILabel *pricelabel;

@property (nonatomic,strong) UILabel *viplabel;
@property (nonatomic,strong) UILabel *discountlabel;
@property (nonatomic,strong) UILabel *reducelabel;

-(void)setCellDate:(settleModel *)settle;
@end
