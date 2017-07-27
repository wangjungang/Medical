//
//  SettleFirstCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "SettleFirstCell.h"
#import "settleModel.h"

@interface SettleFirstCell()
@property (nonatomic,strong) settleModel *smodel;
@end
@implementation SettleFirstCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.addresslabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.addresslabel.frame = CGRectMake(15, 35/2*HEIGHT_SCALE, DEVICE_WIDTH/2, self.frame.size.height-2*(35/2*HEIGHT_SCALE));
    
}

#pragma mark - getters

-(UILabel *)addresslabel
{
    if(!_addresslabel)
    {
        _addresslabel = [[UILabel alloc] init];
        _addresslabel.numberOfLines = 0;
        _addresslabel.font = [UIFont systemFontOfSize:13];
    }
    return _addresslabel;
}

#pragma mark - 数据模型

-(void)setCellDate:(settleModel *)settle
{
    self.smodel = settle;
    self.addresslabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",settle.name,@"  ",settle.phone,@"  ",settle.address];
    [self layoutIfNeeded];
}
@end
