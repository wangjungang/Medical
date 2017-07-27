//
//  medicineCollectionViewCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "medicineCollectionViewCell.h"
#import "storeModel.h"
#import "UIImageView+WebCache.h"
@interface medicineCollectionViewCell()
@property (nonatomic,strong) storeModel *smodel;
@end

@implementation medicineCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.newpricelabel];
        [self addSubview:self.oldpricelabel];
        [self addSubview:self.efficacylabel];
        [self addSubview:self.usedlabel];
        [self addSubview:self.mdeicineimage];
        [self addSubview:self.namelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.mdeicineimage.frame = CGRectMake(10, 10, self.frame.size.width-20, self.frame.size.height/2-5);
    self.namelabel.frame = CGRectMake(10, self.frame.size.height/2+5, 40, 25);
    self.efficacylabel.frame = CGRectMake(10, self.frame.size.height/2+30, self.frame.size.width-20, 15);
    self.usedlabel.frame = CGRectMake(10, self.frame.size.height/2+45, self.frame.size.width-20, 15);
    self.oldpricelabel.frame = CGRectMake(self.frame.size.width/3, self.frame.size.height-30, self.frame.size.width/3-10, 20);
    self.newpricelabel.frame = CGRectMake(self.frame.size.width/3*2, self.frame.size.height-30, self.frame.size.width/3-10, 20);
}

#pragma mark - getters

-(UIImageView *)mdeicineimage
{
    if(!_mdeicineimage)
    {
        _mdeicineimage = [[UIImageView alloc]init];
       // _mdeicineimage.backgroundColor = [UIColor greenColor];
    }
    return _mdeicineimage;
}

-(UILabel *)efficacylabel
{
    if(!_efficacylabel)
    {
        _efficacylabel = [[UILabel alloc] init];
        //_efficacylabel.backgroundColor = [UIColor greenColor];
        _efficacylabel.text = @"功效：12345678";
        //_efficacylabel.adjustsFontSizeToFitWidth = YES;
        _efficacylabel.font = [UIFont systemFontOfSize:13];
    }
    return _efficacylabel;
}

-(UILabel *)usedlabel
{
    if(!_usedlabel)
    {
        _usedlabel = [[UILabel alloc] init];
        _usedlabel.text = @"用于者";
        _usedlabel.adjustsFontSizeToFitWidth = YES;
        _usedlabel.font = [UIFont systemFontOfSize:13];
        //_usedlabel.backgroundColor = [UIColor redColor];
    }
    return _usedlabel;
}

-(oldlabel *)oldpricelabel
{
    if(!_oldpricelabel)
    {
        _oldpricelabel = [[oldlabel alloc] init];
        //_oldpricelabel.backgroundColor = [UIColor redColor];
        _oldpricelabel.adjustsFontSizeToFitWidth = YES;
        _oldpricelabel.text = @"市价：$18";
        
        //1.获取图形上下文
        CGContextRef ctx=UIGraphicsGetCurrentContext();
        //2.绘图（画线）
        //设置起点
        CGContextMoveToPoint(ctx, 20, 20);
        //设置终点
        CGContextAddLineToPoint(ctx, 200, 300);
        //渲染
        CGContextStrokePath(ctx);
        
    }
    return _oldpricelabel;
}

-(UILabel *)newpricelabel
{
    if(!_newpricelabel)
    {
        _newpricelabel = [[UILabel alloc] init];
        _newpricelabel.adjustsFontSizeToFitWidth = YES;
        _newpricelabel.textColor = [UIColor redColor];
        _newpricelabel.text = @"现价：$16";
    }
    return _newpricelabel;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.text = @"感康";
        _namelabel.adjustsFontSizeToFitWidth = YES;
        _namelabel.textColor = [UIColor wjColorFloat:KMedical_Blue];
    }
    return _namelabel;
}

-(void)setCellDate:(storeModel *)stomodel
{
    self.smodel = stomodel;
    [self.mdeicineimage sd_setImageWithURL:[NSURL URLWithString:stomodel.picimageurl]];
    self.efficacylabel.text = stomodel.drugeffectstr;
    self.namelabel.text = stomodel.drugnamestr;
    self.oldpricelabel.text = [NSString stringWithFormat:@"%@%@",@"原价: ¥",stomodel.oldpricestr];
    self.newpricelabel.text = [NSString stringWithFormat:@"%@%@",@"现价: ¥",stomodel.newpricestr];
}
-(void)setCellData:(VIPShopListModelsProducts*)stomodel;
{
    
    [self.mdeicineimage sd_setImageWithURL:[NSURL URLWithString:stomodel.pictures]];
    self.efficacylabel.text = stomodel.effect;
    self.namelabel.text = stomodel.drugName;
    self.oldpricelabel.text = [NSString stringWithFormat:@"%@%@",@"原价: ¥",stomodel.oldprice];
    self.newpricelabel.text = [NSString stringWithFormat:@"%@%@",@"现价: ¥",stomodel.nowprice];
}
@end


