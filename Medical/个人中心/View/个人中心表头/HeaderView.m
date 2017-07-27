//
//  HeaderView.m
//  Medical
//
//  Created by 李壮 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "HeaderView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+Extend.h"
#define WIDTH_BTN  DEVICE_WIDTH/3
@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
     self=[super initWithFrame:frame];
    if (self)
    {
        _backgroundImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH,F_I6_SIZE(120))];
        _backgroundImage.image = [UIImage imageNamed:@"666.png"];
        _backgroundImage.userInteractionEnabled=YES;
        [self addSubview:_backgroundImage];
        
        
        //我的订单
        _myIndent =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(120), DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(30))];
        _myIndent.text=@"我的订单";
        _myIndent.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        _myIndent.textColor=[UIColor wjColorFloat:@"999999"];
        [self addSubview:_myIndent];
        
        NSArray*titleArray=@[@"待付款",@"已完成",@"账户余额"];
        NSArray*imageArray=@[@"图层3.png",@"图层4.png",@"组2.png"];
        for (NSInteger i=0; i<3; i++) {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame=CGRectMake(WIDTH_BTN*i, F_I6_SIZE(150), WIDTH_BTN, F_I6_SIZE(50));
            btn.layer.borderColor=[[UIColor colorWithRed:193.f/255 green:193.f/255 blue:193.f/255 alpha:1]CGColor];
            btn.layer.borderWidth=1.0f;
            [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
            [btn setTitle:titleArray[i] forState:0];
            btn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
            [btn setImage:[UIImage imageNamed:imageArray[i]] forState:0];
            [btn setTitleColor:[UIColor wjColorFloat:@"999999"] forState:0];
            btn.tag=100+i;
            [self addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        //头像
        _headerImage =[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(16), F_I6_SIZE(37), F_I6_SIZE(55), F_I6_SIZE(55))];
        _headerImage.clipsToBounds=YES;
        _headerImage.layer.cornerRadius=F_I6_SIZE(55/2);
        [_backgroundImage addSubview:_headerImage];
        
        //名字
        _nameLb=[[UILabel alloc]init];
        _nameLb.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        _nameLb.textColor=[UIColor whiteColor];
        [_backgroundImage addSubview:_nameLb];
        
        _vipIcon=[[UIImageView alloc]init];
        _vipIcon.frame=CGRectMake(F_I6_SIZE(100), F_I6_SIZE(44), F_I6_SIZE(12), F_I6_SIZE(13));
        _vipIcon.image =[UIImage imageNamed:@"图层1.png"];
        [_backgroundImage addSubview:_vipIcon];
        
        _vipLb =[[UILabel alloc]init];
        _vipLb.font=[UIFont boldSystemFontOfSize:F_I5_SIZE(12)];
        _vipLb.textColor=[UIColor wjColorFloat:@"ffd800"];
        [_backgroundImage addSubview:_vipLb];
        
        //积分
        _integralLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(86), F_I6_SIZE(75), F_I6_SIZE(25), F_I6_SIZE(12))];
        _integralLb.text=@"积分";
        _integralLb.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        _integralLb.textColor =[UIColor whiteColor];
        [_backgroundImage addSubview:_integralLb];
        
        _integralIcon=[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(115), F_I6_SIZE(75), F_I6_SIZE(13), F_I6_SIZE(12))];
        _integralIcon.image=[UIImage imageNamed:@"图层2.png"];
        [_backgroundImage addSubview:_integralIcon];
        _myIndent = [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(130), F_I6_SIZE(75), DEVICE_WIDTH-F_I6_SIZE(140), F_I6_SIZE(12))];
        _myIndent.textColor=[UIColor whiteColor];
        _myIndent.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        [_backgroundImage addSubview:_myIndent];
        
        //账户管理btn
        _accountManagerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_accountManagerBtn setTitle:@"账户管理" forState:0];
        _accountManagerBtn.titleLabel.font=[UIFont systemFontOfSize:F_I6_SIZE(15)];
        _accountManagerBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(90), F_I6_SIZE(45), F_I6_SIZE(90), F_I6_SIZE(30));
        _accountManagerBtn.tag=103;
        [_accountManagerBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_accountManagerBtn setBackgroundImage:[UIImage imageNamed:@"555.png"] forState:0];
        [_backgroundImage addSubview:_accountManagerBtn];
        _vipIcon.hidden=YES;
    }
    return self;
}
- (void)setViewContent:(UserInfoData*)data
{
    _data=data;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:data.headerPic]placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _nameLb.text=_data.nickName;
    _myIndent.text=_data.jifen;
    if ([_data.level integerValue]==0)
    {
        _vipIcon.hidden=YES;
    }else
    {
        _vipIcon.hidden=NO;
        _vipLb.text=[NSString stringWithFormat:@"VIP%@",_data.level];
    }
    [self layoutSubviews];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size=[NSString labelAutoCalculateRectWith:_data.nickName FontSize:F_I6_SIZE(13) MaxSize:CGSizeMake(F_I6_SIZE(100), F_I6_SIZE(12))];
    _nameLb.frame=CGRectMake(F_I6_SIZE(80), F_I6_SIZE(44), size.width, size.height);
    _vipIcon.frame=CGRectMake(F_I6_SIZE(85)+size.width, F_I6_SIZE(44), F_I6_SIZE(12), F_I6_SIZE(13));
    _vipLb.frame=CGRectMake(F_I6_SIZE(97)+size.width, F_I6_SIZE(44), F_I6_SIZE(50), F_I6_SIZE(12));
}
//按钮方法
- (void)btnClick:(UIButton*)btn
{
    [_delegate getbtnIndex:btn.tag];
}
@end
