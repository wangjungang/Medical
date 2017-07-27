//
//  shopcarView.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "shopcarView.h"
#import "shopcarModel.h"

@interface shopcarView()
@property (nonatomic,strong) UILabel *allchooselabel;
@property (nonatomic,strong) shopcarModel *smodel;
@end

@implementation shopcarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.choosebtn];
        [self addSubview:self.combinedlabel];
        [self addSubview:self.specificpricelabel];
        [self addSubview:self.allchooselabel];
        [self addSubview:self.invoicingbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.choosebtn.frame = CGRectMake(15, self.frame.size.height/2-6, 12, 12);
    self.allchooselabel.frame = CGRectMake(30, self.frame.size.height/2-15, 50, 30);
    self.invoicingbtn.frame = CGRectMake(self.frame.size.width/3*2, 0, self.frame.size.width/3, self.frame.size.height);
    self.combinedlabel.frame = CGRectMake(70, self.frame.size.height/2-30, self.frame.size.width/3, 30);
    self.specificpricelabel.frame = CGRectMake(70, self.frame.size.height/2, self.frame.size.width/3, 30);
}

#pragma mark - getters

-(UIButton *)choosebtn
{
    if(!_choosebtn)
    {
        _choosebtn = [[UIButton alloc] init];
        [_choosebtn setImage:[UIImage imageNamed:@"椭圆5"] forState:UIControlStateNormal];
    }
    return _choosebtn;
}

-(UILabel *)allchooselabel
{
    if(!_allchooselabel)
    {
        _allchooselabel = [[UILabel alloc] init];
        _allchooselabel.text = @"全选";
    }
    return _allchooselabel;
}

-(UILabel *)combinedlabel
{
    if(!_combinedlabel)
    {
        _combinedlabel = [[UILabel alloc] init];
    
        _combinedlabel.adjustsFontSizeToFitWidth = YES;
    }
    return _combinedlabel;
}

-(UILabel *)specificpricelabel
{
    if(!_specificpricelabel)
    {
        _specificpricelabel = [[UILabel alloc] init];
        //_specificpricelabel.text = @"总额¥ 208 享7折 ¥ 180";
        _specificpricelabel.adjustsFontSizeToFitWidth = YES;
    }
    return _specificpricelabel;
}

-(UIButton *)invoicingbtn
{
    if(!_invoicingbtn)
    {
        _invoicingbtn = [[UIButton alloc] init];
        [_invoicingbtn setTitle:@"提交订单" forState:UIControlStateNormal];
        _invoicingbtn.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
    }
    return _invoicingbtn;
}

@end
