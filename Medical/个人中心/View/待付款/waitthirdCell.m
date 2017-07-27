//
//  waitthirdCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "waitthirdCell.h"

@implementation waitthirdCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.buybtn];
        [self.contentView addSubview:self.delbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.buybtn.frame = CGRectMake(DEVICE_WIDTH-60-16,self.frame.size.height/2-10, 60, 20);
    self.delbtn.frame = CGRectMake(DEVICE_WIDTH-60-16-60-16, self.frame.size.height/2-10, 60, 20);
}

-(UIButton *)buybtn
{
    if(!_buybtn)
    {
        _buybtn = [[UIButton alloc] init];
        _buybtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_buybtn setTitle:@"继续购买" forState:UIControlStateNormal];
        [_buybtn setTitleColor:[UIColor redColor] forState:normal];
        [_buybtn setTitleColor:[UIColor wjColorFloat:@"ffffff"] forState:UIControlStateNormal];
        _buybtn.backgroundColor = [UIColor wjColorFloat:@"13cace"];
        _buybtn.layer.masksToBounds = YES;
        _buybtn.layer.cornerRadius = 4;
        [_buybtn addTarget:self action:@selector(buybtnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buybtn;
}

-(UIButton *)delbtn
{
    if(!_delbtn)
    {
        _delbtn = [[UIButton alloc] init];
        _delbtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_delbtn setTitle:@"删除订单" forState:UIControlStateNormal];
        [_delbtn setTitleColor:[UIColor wjColorFloat:@"ffffff"] forState:UIControlStateNormal];
        _delbtn.backgroundColor = [UIColor wjColorFloat:@"13cace"];
        _delbtn.layer.masksToBounds = YES;
        _delbtn.layer.cornerRadius = 4;
        [_delbtn addTarget:self action:@selector(delbtnclick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delbtn;
}


//按钮事件
-(void)buybtnclick:(UIButton *)sender
{
    
    [self.delegate myTabVClick:self];
    
}

-(void)delbtnclick:(UIButton *)sender
{
    [self.delegate deltypeClick:self];
}

@end
