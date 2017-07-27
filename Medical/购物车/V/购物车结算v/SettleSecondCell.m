//
//  SettleSecondCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "SettleSecondCell.h"
@interface SettleSecondCell()
@property (nonatomic,strong) UILabel *leftlabel;
@property (nonatomic,strong) UILabel *rightlabel;
@end

@implementation SettleSecondCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftlabel];
        [self.contentView addSubview:self.rightlabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftlabel.frame = CGRectMake(33/2, 30/2*HEIGHT_SCALE, 60*WIDTH_SCALE, 35/2*HEIGHT_SCALE);
    self.rightlabel.frame = CGRectMake(DEVICE_WIDTH-60*WIDTH_SCALE-33/2, 15*HEIGHT_SCALE, 60*WIDTH_SCALE, 35/2*HEIGHT_SCALE);
}

#pragma mark - getters

-(UILabel *)leftlabel
{
    if(!_leftlabel)
    {
        _leftlabel = [[UILabel alloc] init];
        _leftlabel.text = @"支付方式";
        _leftlabel.font = [UIFont systemFontOfSize:13];
    }
    return _leftlabel;
}

-(UILabel *)rightlabel
{
    if(!_rightlabel)
    {
        _rightlabel = [[UILabel alloc] init];
        _rightlabel.text = @"在线支付";
        _rightlabel.font = [UIFont systemFontOfSize:13];
        _rightlabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightlabel;
}

@end
