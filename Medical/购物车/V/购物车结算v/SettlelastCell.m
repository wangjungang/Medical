//
//  SettlelastCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "SettlelastCell.h"
#import "settleModel.h"
@interface SettlelastCell()
@property (nonatomic,strong) settleModel *smodel;
@end

@implementation SettlelastCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.totalpricelabel];
//        [self.contentView addSubview:self.preferentialpricelabel];
//        [self.contentView addSubview:self.actuallabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.totalpricelabel.frame = CGRectMake(15, 8, DEVICE_WIDTH/4, 30);
    self.preferentialpricelabel.frame = CGRectMake(25+DEVICE_WIDTH/3, 8, DEVICE_WIDTH/3, 30);
    self.actuallabel.frame = CGRectMake(DEVICE_WIDTH/4*3-20, 8, DEVICE_WIDTH/4, 30);
}

#pragma mark - getters

-(UILabel *)totalpricelabel
{
    if(!_totalpricelabel)
    {
        _totalpricelabel = [[UILabel alloc] init];
        _totalpricelabel.font = [UIFont systemFontOfSize:14];
        _totalpricelabel.textColor =  [UIColor wjColorFloat:@"ff7200"];
       // _totalpricelabel.text = @"总价¥16.5";
    }
    return _totalpricelabel;
}

-(UILabel *)preferentialpricelabel
{
    if(!_preferentialpricelabel)
    {
        _preferentialpricelabel = [[UILabel alloc] init];
        _preferentialpricelabel.font = [UIFont systemFontOfSize:14];
        _preferentialpricelabel.textColor = [UIColor wjColorFloat:@"ff7200"];
       // _preferentialpricelabel.text = @"以优惠$1.5";
    }
    return _preferentialpricelabel;
}

-(UILabel *)actuallabel
{
    if(!_actuallabel)
    {
        _actuallabel = [[UILabel alloc] init];
        _actuallabel.font = [UIFont systemFontOfSize:14];
        _actuallabel.textColor = [UIColor wjColorFloat:KMedical_Blue];
       // _actuallabel.text = @"实付¥15";
        _actuallabel.textAlignment = NSTextAlignmentRight;
    }
    return _actuallabel;
}

#pragma mark - 数据模型方法

-(void)setCellDate:(settleModel *)settle
{
    self.smodel = settle;
    self.totalpricelabel.text = [NSString stringWithFormat:@"%@%@",@"总价¥",settle.totalprice];
    self.preferentialpricelabel.text = [NSString stringWithFormat:@"%@%@",@"已优惠¥",settle.preferentialprice];
    self.actuallabel.text = [NSString stringWithFormat:@"%@%@",@"实付¥",settle.actual];
    [self layoutIfNeeded];
}

@end
