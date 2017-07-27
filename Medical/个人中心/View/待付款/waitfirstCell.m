//
//  waitfirstCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "waitfirstCell.h"
#import "waitpayModel.h"
#import "UIImageView+WebCache.h"
@interface waitfirstCell()
@property (nonatomic,strong) waitpayModel *waitmodel;

@end
@implementation waitfirstCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.pointbtn];
        [self.contentView addSubview:self.shopimage];
        [self.contentView addSubview:self.shoplabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
   // self.pointbtn.frame = CGRectMake(25/2, self.frame.size.height/2-5, 10, 10);
    
     self.pointbtn.frame = CGRectMake(0*WIDTH_SCALE, 0, 40*WIDTH_SCALE, self.frame.size.height-1*HEIGHT_SCALE);
    
     _pointbtn.imageEdgeInsets = UIEdgeInsetsMake(self.frame.size.height/2 *HEIGHT_SCALE-8*HEIGHT_SCALE, 13 *WIDTH_SCALE, self.frame.size.height/2 -8*HEIGHT_SCALE, 13 *WIDTH_SCALE);
    
   // _pointbtn.imageEdgeInsets = UIEdgeInsetsMake(13 *WIDTH_SCALE, self.frame.size.height/2 *HEIGHT_SCALE-8*HEIGHT_SCALE, 13 *WIDTH_SCALE, self.frame.size.height/2 -8*HEIGHT_SCALE);
    
    self.shopimage.frame = CGRectMake(25/2+20, 4, 30, self.frame.size.height-8);
    self.shoplabel.frame = CGRectMake(25/2+60, 4, 120, self.frame.size.height-8);
    
}

#pragma mark - getters

-(UIButton *)pointbtn
{
    if(!_pointbtn)
    {
        _pointbtn = [[UIButton alloc] init];
        [_pointbtn addTarget:self action:@selector(waitpay:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pointbtn;
}

-(UIImageView *)shopimage
{
    if(!_shopimage)
    {
        _shopimage = [[UIImageView alloc] init];
    }
    return _shopimage;
}

-(UILabel *)shoplabel
{
    if(!_shoplabel)
    {
        _shoplabel = [[UILabel alloc] init];
        _shoplabel.font = [UIFont systemFontOfSize:14];
        _shoplabel.textColor = [UIColor wjColorFloat:@"4b4b4b"];
    }
    return _shoplabel;
}

-(void)waitpay:(UIButton *)sender
{
    [self.delegate waitPayClick:self];
}

-(void)setCellDate:(waitpayModel *)wmodel
{
    self.waitmodel = wmodel;
    [self.shopimage sd_setImageWithURL:[NSURL URLWithString:wmodel.shoppicture]];
    self.shoplabel.text = wmodel.shopname;
    if (wmodel.selectState)
    {
        _selectState = YES;
        [_pointbtn setImage:[UIImage imageNamed:@"组19"] forState:normal];
    }else{
        _selectState = NO;
        
        [_pointbtn setImage:[UIImage imageNamed:@"椭圆5"] forState:normal];
    }
}
@end
