//
//  shipcarCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "shopcarCell.h"
#import "shopcarModel.h"
#import "UIImageView+WebCache.h"

@interface shopcarCell()
@property (nonatomic,strong) UILabel *dollarlabel;

@property (nonatomic,strong) shopcarModel *shopmodel;
@end

@implementation shopcarCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.cellchoosebtn];
        [self addSubview:self.drugimage];
        [self addSubview:self.drugnamelabel];
        [self addSubview:self.pricelabel];
        [self addSubview:self.addbtn];
        [self addSubview:self.deletebtn];
        [self addSubview:self.numbertext];
        [self addSubview:self.dollarlabel];
       // [self addSubview:self.numberbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.cellchoosebtn.frame = CGRectMake(0*WIDTH_SCALE, 0, 40*WIDTH_SCALE, self.frame.size.height-1*HEIGHT_SCALE);
    _cellchoosebtn.imageEdgeInsets = UIEdgeInsetsMake(self.frame.size.height/2 *HEIGHT_SCALE-8*HEIGHT_SCALE, 13 *WIDTH_SCALE, self.frame.size.height/2 -8*HEIGHT_SCALE, 13 *WIDTH_SCALE);
    self.drugimage.frame = CGRectMake(40*WIDTH_SCALE, self.frame.size.height/2-30, 100*WIDTH_SCALE, 60*WIDTH_SCALE);
    self.drugnamelabel.frame = CGRectMake(150*WIDTH_SCALE, self.frame.size.height/2-35, self.frame.size.width- 165*WIDTH_SCALE, 30*WIDTH_SCALE);
    self.deletebtn.frame = CGRectMake(150*WIDTH_SCALE, self.frame.size.height/2, 20, 20);
    self.numbertext.frame = CGRectMake(180*WIDTH_SCALE, self.frame.size.height/2+2, 20, 18);
    self.addbtn.frame = CGRectMake(210*WIDTH_SCALE, self.frame.size.height/2, 20, 20);
    
   // self.numberbtn.frame = CGRectMake(150*WIDTH_SCALE, self.frame.size.height/2, 60, 20);
    self.pricelabel.frame = CGRectMake(DEVICE_WIDTH-50, self.frame.size.height/2+5, 30, 20);
    self.dollarlabel.frame = CGRectMake(DEVICE_WIDTH-80, self.frame.size.height/2, 20, 20);
}

#pragma mark - getters

-(UIButton *)cellchoosebtn
{
    if(!_cellchoosebtn)
    {
        _cellchoosebtn = [[UIButton alloc] init];
        [_cellchoosebtn addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
       
//        _cellchoosebtn.backgroundColor = [UIColor redColor];
        
    }
    return _cellchoosebtn;
}

-(UIImageView *)drugimage
{
    if(!_drugimage)
    {
        _drugimage = [[UIImageView alloc] init];
       // _drugimage.image = [UIImage imageNamed:@"组18"];
    }
    return _drugimage;
}

-(UILabel *)drugnamelabel
{
    if(!_drugnamelabel)
    {
        _drugnamelabel = [[UILabel alloc] init];
       // _drugnamelabel.text = @"感康";
//        _drugnamelabel.backgroundColor = [UIColor redColor];

    }
    return _drugnamelabel;
}

-(UILabel *)pricelabel
{
    if(!_pricelabel)
    {
        _pricelabel = [[UILabel alloc] init];
       // _pricelabel.text = @"208";
        _pricelabel.textColor = [UIColor redColor];
        _pricelabel.adjustsFontSizeToFitWidth = YES;
    }
    return _pricelabel;
}

-(UILabel *)dollarlabel
{
    if(!_dollarlabel)
    {
        _dollarlabel = [[UILabel alloc] init];
        _dollarlabel.text = @"¥";
        _dollarlabel.textColor = [UIColor redColor];
        _dollarlabel.textAlignment = NSTextAlignmentCenter;
        _dollarlabel.adjustsFontSizeToFitWidth = YES;
    }
    return _dollarlabel;
}

-(UIButton *)addbtn
{
    if(!_addbtn)
    {
        _addbtn = [[UIButton alloc] init];
        [_addbtn setImage:[UIImage imageNamed:@"加号28"] forState:UIControlStateNormal];
        [_addbtn addTarget:self action:@selector(addbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addbtn;
}

-(UIButton *)deletebtn
{
    if(!_deletebtn)
    {
        _deletebtn = [[UIButton alloc] init];
        [_deletebtn setImage:[UIImage imageNamed:@"图层29"] forState:UIControlStateNormal];
        [_deletebtn addTarget:self action:@selector(deletebtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deletebtn;
}

-(UILabel *)numbertext
{
    if(!_numbertext)
    {
        _numbertext = [[UILabel alloc] init];
        _numbertext.layer.masksToBounds = YES;
        _numbertext.layer.borderWidth = 0.3f;
        _numbertext.layer.borderColor = [UIColor wjColorFloat:@"cccccc"].CGColor;
        _numbertext.textColor = [UIColor wjColorFloat:@"525252"];
        _numbertext.font = [UIFont systemFontOfSize:11];
        _numbertext.textAlignment = NSTextAlignmentCenter;
    }
    return _numbertext;
}
    

    
//按钮事件
-(void)test:(UIButton *)sender
{
    [self.delegate shopTabVClick:self];
}

-(void)addbtnclick:(UIButton *)sender
{
    [self.delegate shopaddClick:self];
}

-(void)deletebtnclick
{
    [self.delegate shopdeleteClick:self];
}

#pragma mark - 数据模型方法

-(void)setCellDate:(shopcarModel *)shopm
{
    self.shopmodel = shopm;
    self.drugnamelabel.text = shopm.durgname;
    self.pricelabel.text = shopm.durgprice;
    self.numbertext.text = shopm.durgnumber;
    [self.drugimage sd_setImageWithURL:[NSURL URLWithString:shopm.shopcarimageurl]];
    
    if (shopm.selectState)
    {
        _selectState = YES;
        [_cellchoosebtn setImage:[UIImage imageNamed:@"组19"] forState:normal];
    }else{
        _selectState = NO;

        [_cellchoosebtn setImage:[UIImage imageNamed:@"椭圆5"] forState:normal];
    }
     _cellchoosebtn.imageEdgeInsets = UIEdgeInsetsMake(self.frame.size.height/2 *HEIGHT_SCALE-8*HEIGHT_SCALE, 13 *WIDTH_SCALE, self.frame.size.height/2 -8*HEIGHT_SCALE, 13 *WIDTH_SCALE);
    [self layoutIfNeeded];
}

@end
