//
//  settleView.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "settleView.h"

@implementation settleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.settlebtn];
        [self addSubview:self.pricelabel];
        [self addSubview:self.infolabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.settlebtn.frame = CGRectMake(DEVICE_WIDTH/3*2, 0, DEVICE_WIDTH/3, self.frame.size.height);
    self.pricelabel.frame = CGRectMake(20, self.frame.size.height/2-10, 40, 20);
    self.infolabel.frame = CGRectMake(55, self.frame.size.height/2-10, 120, 20);
}

#pragma mark - getters

-(UIButton *)settlebtn
{
    if(!_settlebtn)
    {
        _settlebtn = [[UIButton alloc] init];
        _settlebtn.backgroundColor = [UIColor wjColorFloat:KMedical_Blue];
        [_settlebtn setTitle:@"支付" forState:UIControlStateNormal];
        [_settlebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _settlebtn;
}

-(UILabel *)pricelabel
{
    if(!_pricelabel)
    {
        _pricelabel = [[UILabel alloc] init];
//        _pricelabel.text = @"¥15";
        _pricelabel.adjustsFontSizeToFitWidth = YES;
        _pricelabel.textColor = [UIColor wjColorFloat:KMedical_Blue];
    }
    return _pricelabel;
}

-(UILabel *)infolabel
{
    if(!_infolabel)
    {
        _infolabel = [[UILabel alloc] init];
//        _infolabel.text = @"(已优惠¥15)";
        _infolabel.textColor = [UIColor redColor];
        //_infolabel.backgroundColor = [UIColor redColor];
        _infolabel.adjustsFontSizeToFitWidth = YES;
    }
    return _infolabel;
}

@end
