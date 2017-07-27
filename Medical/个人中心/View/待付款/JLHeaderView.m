//
//  JLHeaderView.m
//  Medical
//
//  Created by 王俊钢 on 2016/12/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "JLHeaderView.h"
#import "waitpayModel.h"
@interface JLHeaderView()
@property (nonatomic,strong) waitpayModel *waitmodel;
@end
@implementation JLHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.choosebtn];
       // [self addSubview:self.orderlabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.choosebtn.frame = CGRectMake(10, 7, 15, 15);
    self.orderlabel.frame = CGRectMake(30, 5, 300, 20);
}

#pragma mark - getters


-(UIButton *)choosebtn
{
    if(!_choosebtn)
    {
        _choosebtn = [[UIButton alloc] init];
        //_choosebtn.backgroundColor = [UIColor redColor];
        [_choosebtn addTarget:self action:@selector(choosebtnclick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _choosebtn;
}

-(UILabel *)orderlabel
{
    if(!_orderlabel)
    {
        _orderlabel = [[UILabel alloc] init];
        //_orderlabel.backgroundColor = [UIColor greenColor];
    }
    return _orderlabel;
}


-(void)choosebtnclick
{
    //[self.delegate foldHeaderInSection:_section];
    [self.delegate foldHeaderInSection:_section andid:self.choosebtn];
}

-(void)setCellDate:(waitpayModel *)wmodel
{
    self.waitmodel = wmodel;
    self.orderlabel.text = wmodel.orderid;
//    if (wmodel.selectState)
//    {
//        _selectState = YES;
//        [_choosebtn setImage:[UIImage imageNamed:@"组19"] forState:normal];
//    }else{
//        _selectState = NO;
//        
//        [_choosebtn setImage:[UIImage imageNamed:@"椭圆5"] forState:normal];
//    }
}
@end
