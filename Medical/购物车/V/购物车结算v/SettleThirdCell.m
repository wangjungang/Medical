//
//  SettleThirdCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "SettleThirdCell.h"
#import "settleModel.h"
#import "UIImageView+WebCache.h"
@interface SettleThirdCell()
@property (nonatomic,strong) UIView *lineview1;
@property (nonatomic,strong) UIView *lineview2;

@property (nonatomic,strong) settleModel *smodel;
@end

@implementation SettleThirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.leftimage];
        [self.contentView addSubview:self.hospitalname];
        [self.contentView addSubview:self.druglabel];
        [self.contentView addSubview:self.discountlabel];
        [self.contentView addSubview:self.pricelabel];
        [self.contentView addSubview:self.numberlabel];
        [self.contentView addSubview:self.viplabel];
        [self.contentView addSubview:self.reducelabel];
        
        [self.contentView addSubview:self.lineview1];
        [self.contentView addSubview:self.lineview2];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.leftimage.frame = CGRectMake(27/2*WIDTH_SCALE, (45/2-10)*HEIGHT_SCALE, 20, 20);
    self.hospitalname.frame = CGRectMake(50*WIDTH_SCALE, (45/2-10)*HEIGHT_SCALE, 100, 20);
    self.druglabel.frame = CGRectMake(41*WIDTH_SCALE, self.frame.size.height/3+10, DEVICE_WIDTH/3-41, 20);
    self.numberlabel.frame = CGRectMake(DEVICE_WIDTH/2-10, self.frame.size.height/3+10, 30, 20);
    self.pricelabel.frame = CGRectMake(DEVICE_WIDTH-41*WIDTH_SCALE-(DEVICE_WIDTH/3-41), self.frame.size.height/3+10, DEVICE_WIDTH/3-41, 20);
    
    
    self.viplabel.frame = CGRectMake(41*WIDTH_SCALE, self.frame.size.height/3*2+10, DEVICE_WIDTH/3-41, 20);
    self.reducelabel.frame = CGRectMake(DEVICE_WIDTH/2-10, self.frame.size.height/3*2+10, 30, 20);
    self.discountlabel.frame = CGRectMake(DEVICE_WIDTH-41*WIDTH_SCALE-(DEVICE_WIDTH/3-41), self.frame.size.height/3*2+10, DEVICE_WIDTH/3-41, 20);
    
    self.lineview1.frame = CGRectMake(20, self.frame.size.height/3, DEVICE_WIDTH-40, 1);
    self.lineview2.frame = CGRectMake(20, self.frame.size.height/3*2, DEVICE_WIDTH-40, 1);
}

#pragma mark - getters

-(UIImageView *)leftimage
{
    if(!_leftimage)
    {
        _leftimage = [[UIImageView alloc] init];
        _leftimage.layer.masksToBounds = YES;
        _leftimage.layer.cornerRadius = 10;
        //_leftimage.image = [UIImage imageNamed:@"购物车医院"];
    }
    return _leftimage;
}

-(UILabel *)hospitalname
{
    if(!_hospitalname)
    {
        _hospitalname = [[UILabel alloc] init];
        
        _hospitalname.font = [UIFont systemFontOfSize:13];
    }
    return _hospitalname;
}

-(UILabel *)druglabel
{
    if(!_druglabel)
    {
        _druglabel = [[UILabel alloc] init];
        _druglabel.font = [UIFont systemFontOfSize:13];

    }
    return _druglabel;
}

-(UILabel *)numberlabel
{
    if(!_numberlabel)
    {
        _numberlabel = [[UILabel alloc] init];
        _numberlabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _numberlabel;
}

-(UILabel *)pricelabel
{
    if(!_pricelabel)
    {
        _pricelabel = [[UILabel alloc] init];
        _pricelabel.font = [UIFont systemFontOfSize:13];

        _pricelabel.textAlignment = NSTextAlignmentRight;
    }
    return _pricelabel;
}

-(UILabel *)viplabel
{
    if(!_viplabel)
    {
        _viplabel = [[UILabel alloc] init];
        _viplabel.font = [UIFont systemFontOfSize:13];

    }
    return _viplabel;
}

-(UILabel *)reducelabel
{
    if(!_reducelabel)
    {
        _reducelabel = [[UILabel alloc] init];
        _reducelabel.font = [UIFont systemFontOfSize:13];
   
    }
    return _reducelabel;
}

-(UILabel *)discountlabel
{
    if(!_discountlabel)
    {
        _discountlabel = [[UILabel alloc] init];
        _discountlabel.font = [UIFont systemFontOfSize:13];
       
        _discountlabel.textAlignment = NSTextAlignmentRight;
    }
    return _discountlabel;
}

-(UIView *)lineview1
{
    if(!_lineview1)
    {
        _lineview1 = [[UIView alloc] init];
        _lineview1.backgroundColor = [UIColor wjColorFloat:@"cccccc"];
    }
    return _lineview1;
}

-(UIView *)lineview2
{
    if(!_lineview2)
    {
        _lineview2 = [[UIView alloc] init];
        _lineview2.backgroundColor = [UIColor wjColorFloat:@"cccccc"];
    }
    return _lineview2;
}

#pragma mark - 数据模型方法 

-(void)setCellDate:(settleModel *)settle
{
    self.smodel = settle;
    self.hospitalname.text = settle.drugshopname;
    self.druglabel.text = settle.drugname;
    self.numberlabel.text = settle.drugnumber;
    self.pricelabel.text = settle.drugprice;
    self.viplabel.text = settle.vipstr;
    self.reducelabel.text = settle.reduce;
    self.discountlabel.text = settle.discount;
    [self.leftimage sd_setImageWithURL:[NSURL URLWithString:settle.drugshopimageurl]];
    [self layoutIfNeeded];
}

@end
