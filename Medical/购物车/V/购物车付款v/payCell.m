//
//  payCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "payCell.h"

@implementation payCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        
    
        [self.contentView addSubview:self.itemimage];
        [self.contentView addSubview:self.paynamelabel];
        [self.contentView addSubview:self.pointbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.itemimage.frame = CGRectMake(16*WIDTH_SCALE, (133/4-20)*HEIGHT_SCALE, 40*WIDTH_SCALE, 40*WIDTH_SCALE);
    self.paynamelabel.frame = CGRectMake(70*WIDTH_SCALE, (133/4-15)*HEIGHT_SCALE, 60, 30);
    self.pointbtn.frame = CGRectMake(DEVICE_WIDTH-10-18, (133/4-5)*HEIGHT_SCALE, 10, 10);
}

#pragma mark - getters

-(UIImageView *)itemimage
{
    if(!_itemimage)
    {
        _itemimage = [[UIImageView alloc] init];
        _itemimage.layer.masksToBounds = YES;
        _itemimage.layer.cornerRadius = 5;
       // _itemimage.backgroundColor = [UIColor redColor];
        
    }
    return _itemimage;
}

-(UIButton *)pointbtn
{
    if(!_pointbtn)
    {
        _pointbtn = [[UIButton alloc] init];
        [_pointbtn addTarget:self action:@selector(textAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pointbtn;
}

-(UILabel *)paynamelabel
{
    if(!_paynamelabel)
    {
        _paynamelabel = [[UILabel alloc] init];
        _paynamelabel.textColor = [UIColor wjColorFloat:@"666666"];
        _paynamelabel.font = [UIFont systemFontOfSize:15*WIDTH_SCALE];
        //_paynamelabel.backgroundColor = [UIColor greenColor];
       // _paynamelabel.text = @"支付宝";
    }
    return _paynamelabel;
}

#pragma mark - 实现方法 
-(void)textAction:(UIButton *)sender
{
//    if (self.btnClick) {
//        self.btnClick();
//    }
    [self.delegate myTabVClick:self];

}
@end
