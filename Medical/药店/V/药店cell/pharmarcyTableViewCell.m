//
//  pharmarcyTableViewCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "pharmarcyTableViewCell.h"
#import "pharmacyModel.h"
#import "UIImageView+WebCache.h"

@interface pharmarcyTableViewCell()
@property (nonatomic,strong) pharmacyModel *model;

@end

@implementation pharmarcyTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        self.starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(120*WIDTH_SCALE, 75*WIDTH_SCALE, 100*WIDTH_SCALE, 25*WIDTH_SCALE) numberOfStars:5];
        //self.starRateView.scorePercent = 0.9;
        self.starRateView.allowIncompleteStar = YES;
        self.starRateView.hasAnimation = YES;
        
        [self addSubview:self.cellimage];
        [self addSubview:self.cellname_label];
        [self addSubview:self.cellnumber_label];
        [self addSubview:self.celldistance_label];
        [self addSubview:self.starRateView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.cellimage.frame = CGRectMake(15*WIDTH_SCALE, 20*HEIGHT_SCALE, 100*WIDTH_SCALE, 80*HEIGHT_SCALE);
    self.cellname_label.frame = CGRectMake(120*WIDTH_SCALE, 20*HEIGHT_SCALE, 100*WIDTH_SCALE, 30*HEIGHT_SCALE);

    self.cellnumber_label.frame = CGRectMake(120*WIDTH_SCALE, 50*HEIGHT_SCALE, 100*WIDTH_SCALE, 25*HEIGHT_SCALE);
    
    self.celldistance_label.frame = CGRectMake(DEVICE_WIDTH-60, 80*HEIGHT_SCALE, 30*WIDTH_SCALE, 25*HEIGHT_SCALE);
}

#pragma mark - getters

-(UIImageView *)cellimage
{
    if(!_cellimage)
    {
        _cellimage = [[UIImageView alloc] init];
    }
    return _cellimage;
}

-(UILabel *)cellname_label
{
    if(!_cellname_label)
    {
        _cellname_label = [[UILabel alloc] init];
        _cellname_label.adjustsFontSizeToFitWidth = YES;
        //_cellname_label.font = [UIFont fontWithName:@"Arial" size:20];
    }
    return _cellname_label;
}

-(UILabel *)cellnumber_label
{
    if(!_cellnumber_label)
    {
        _cellnumber_label = [[UILabel alloc] init];
        _cellnumber_label.adjustsFontSizeToFitWidth = YES;
        _cellnumber_label.textColor = [UIColor lightGrayColor];
    }
    return _cellnumber_label;
}

-(UILabel *)celldistance_label
{
    if(!_celldistance_label)
    {
        _celldistance_label = [[UILabel alloc] init];
        _celldistance_label.adjustsFontSizeToFitWidth = YES;
        _celldistance_label.textColor = [UIColor redColor];
    }
    return _celldistance_label;
}

#pragma mark - 数据模型

-(void)setCellDate:(pharmacyModel *)pharmacy
{
    self.model = pharmacy;
    [self.cellimage sd_setImageWithURL:[NSURL URLWithString:pharmacy.pharmacyImageurl]];
    self.cellname_label.text = pharmacy.pharmacyName;
    self.cellnumber_label.text = [@"诊所规模:"stringByAppendingFormat:@"%@人", pharmacy.pharamcyNumbar];
    self.celldistance_label.text = [@"" stringByAppendingFormat:@"%@m",pharmacy.pharamcyDistance];
    self.celldistance_label.text = pharmacy.pharamcyDistance;
    self.starRateView.scorePercent = pharmacy.star;
    [self layoutIfNeeded];
}

@end
