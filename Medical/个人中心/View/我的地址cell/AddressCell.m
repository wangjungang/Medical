//
//  AddressCell.m
//  YeWenOwner
//
//  Created by 李壮 on 16/8/24.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import "AddressCell.h"
#import "myaddressModel.h"

@interface AddressCell()
@property (nonatomic,strong) myaddressModel *myaddmodel;
@property (nonatomic,strong) UIView *lineview;
@end

@implementation AddressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _nameLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(20), DEVICE_WIDTH-F_I6_SIZE(100), F_I6_SIZE(16))];
        _nameLb.textColor =[UIColor wjColorFloat:@"7f7f7f"];
        _nameLb.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
        
        _addressLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(40), DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(16))];
        _addressLb.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
        _addressLb.numberOfLines=0;
        _addressLb.textColor=[UIColor wjColorFloat:@"c0c0c0"];
               self.selectionStyle=UITableViewCellAccessoryNone;
        
        _phoneLb=[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-F_I6_SIZE(130), F_I6_SIZE(20), F_I6_SIZE(120), F_I6_SIZE(16))];
        
        _phoneLb.textColor=[UIColor wjColorFloat:@"7f7f7f"];
        _phoneLb.textAlignment=2;
        _phoneLb.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
        
        [self.contentView addSubview:_phoneLb];
        [self.contentView addSubview:_nameLb];
        [self.contentView addSubview:_addressLb];
        _nameLb.text=@"李壮壮壮壮壮";
        _phoneLb.text=@"15612689070";
        _addressLb.text=@"交付及哦啊接发垃圾分类就爱上了佛山哪里烦恼都是浪费就睡啦放假啦；积分";
        
        //[self.contentView addSubview:self.defalutlb];
        [self.contentView addSubview:self.defaultbtn];
        [self.contentView addSubview:self.lineview];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.defaultbtn.frame = CGRectMake(10, 100-20, 60, 10);
    self.lineview.frame = CGRectMake(0, 70, DEVICE_WIDTH, 1);
}

#pragma mark - getters

-(UIButton *)defaultbtn
{
    if(!_defaultbtn)
    {
        _defaultbtn = [[UIButton alloc] init];
        _defaultbtn.frame = CGRectMake(8, 8, 50, 14);
        _defaultbtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(14)];
        [_defaultbtn addTarget:self action:@selector(defaultbtnclick) forControlEvents:UIControlEventTouchUpInside];
        //_defaultbtn.backgroundColor = [UIColor redColor];
    }
    return _defaultbtn;
}

-(UIView *)lineview
{
    if(!_lineview)
    {
        _lineview = [[UIView alloc] init];
        _lineview.backgroundColor = [UIColor wjColorFloat:@"cccccc"];
    }
    return _lineview;
}

-(void)defaultbtnclick
{
    [self.delegate defaultTabVClick:self];
}

- (void)setCellDataSource:(myaddressModel *)data
{
    self.myaddmodel = data;
    self.nameLb.text = data.addressname;
    self.phoneLb.text = data.addressmobile;
    self.addressLb.text = data.address;
    self.myaddmodel = data;
    
    if ([data.isdefault isEqualToString:@"0"]) {
        [self.defaultbtn setTitle:@"使用" forState:UIControlStateNormal];
        [self.defaultbtn setTitleColor:[UIColor wjColorFloat:@"ffd800"] forState:0];
    }else
    {
        [self.defaultbtn setTitle:@"未使用" forState:UIControlStateNormal];
        [self.defaultbtn setTitleColor:[UIColor wjColorFloat:@"cccccc"] forState:UIControlStateNormal];
    }
    
}

@end
