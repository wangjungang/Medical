//
//  AccountManagerCell.m
//  Medical
//
//  Created by 李壮 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "AccountManagerCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation AccountManagerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
   self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLb =[[UILabel alloc]init];
       
        _titleLb.textColor =[UIColor wjColorFloat:@"7f7f7f"];
        _titleLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
        [self.contentView addSubview:_titleLb];
        
        
        _afterLb =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-F_I6_SIZE(160), self.frame.size.height/2-F_I6_SIZE(8), F_I6_SIZE(130), F_I6_SIZE(16))];
        _afterLb.textAlignment=2;
        _afterLb.textColor =[UIColor wjColorFloat:@"7f7f7f"];
        _afterLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
        [self.contentView addSubview:_afterLb];
        
        _headerImage =[[UIImageView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-F_I6_SIZE(90), F_I6_SIZE(7.5), F_I6_SIZE(55), F_I6_SIZE(55))];
        _headerImage.clipsToBounds=YES;
        _headerImage.layer.cornerRadius=F_I6_SIZE(55.0f/2);
        [self.contentView addSubview:_headerImage];
        
        _manLb= [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(153), self.frame.size.height/2-F_I6_SIZE(8), F_I6_SIZE(16), F_I6_SIZE(16))];
        _manLb.textColor=_titleLb.textColor;
        _manLb.font =[UIFont systemFontOfSize:F_I6_SIZE(16)];
        _manLb.text=@"男";
        [self.contentView addSubview:_manLb];
        
        _womanLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(217),  self.frame.size.height/2-F_I6_SIZE(8), F_I6_SIZE(16), F_I6_SIZE(16))];
        _womanLb.textColor=_manLb.textColor;
        _womanLb.font=[UIFont systemFontOfSize:F_I6_SIZE(16)];
        _womanLb.text=@"女";
        [self.contentView addSubview:_womanLb];
        
        _sexImageLeft=[UIButton buttonWithType:UIButtonTypeCustom];
        _sexImageLeft.frame=CGRectMake(F_I6_SIZE(137),  self.frame.size.height/2-F_I6_SIZE(8), F_I6_SIZE(10.5), F_I6_SIZE(10.5));
        [_sexImageLeft setBackgroundImage:[UIImage imageNamed:@"椭圆2.png"] forState:UIControlStateNormal];
        [_sexImageLeft setBackgroundImage:[UIImage imageNamed:@"组6.png"] forState:UIControlStateSelected];
//        _sexImageLeft.tag=100;
        [self.contentView addSubview:_sexImageLeft];
        
        _sexImageRight =[UIButton buttonWithType:UIButtonTypeCustom];
        _sexImageRight.frame=CGRectMake(F_I6_SIZE(201),self.frame.size.height/2-F_I6_SIZE(8), F_I6_SIZE(10.5), F_I6_SIZE(10.5));
        [_sexImageRight setBackgroundImage:[UIImage imageNamed:@"椭圆2.png"] forState:UIControlStateNormal];
        [_sexImageRight setBackgroundImage:[UIImage imageNamed:@"组6.png"] forState:UIControlStateSelected];
//        _sexImageRight.tag=101;
        [self.contentView addSubview:_sexImageRight];
        _sexImageLeft.selected=YES;
        
        _lineLb =[[UILabel alloc]init];
        
        _lineLb.backgroundColor =Line_Color;
        [self.contentView addSubview:_lineLb];
        
        _leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame=CGRectMake(F_I6_SIZE(137), 0, F_I6_SIZE(30), F_I6_SIZE(40));
        _leftBtn.tag=100;
        [self.contentView addSubview:_leftBtn];
        
        _rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame=CGRectMake(F_I6_SIZE(201), 0, F_I6_SIZE(30), F_I6_SIZE(40));
        _rightBtn.tag=101;
        [self.contentView addSubview:_rightBtn];
        
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    return self;
}
- (void)setCellContent:(NSIndexPath*)indexPath data:(UserInfoData*)data
{
    _sexImageRight.hidden=YES;
    _sexImageLeft.hidden=YES;
    _headerImage.hidden =YES;
    _afterLb.hidden=YES;
    _womanLb.hidden=YES;
    _manLb.hidden=YES;
    
     _titleLb.frame=CGRectMake(F_I6_SIZE(17), F_I6_SIZE(45/2)-F_I6_SIZE(8), F_I6_SIZE(65), F_I6_SIZE(16));
    _lineLb.frame=CGRectMake(0, F_I6_SIZE(45)-1, DEVICE_WIDTH, 1);
    
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section==0)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                _headerImage.hidden=NO;
                _titleLb.text=@"头像";
                _titleLb.frame=CGRectMake(F_I6_SIZE(17), F_I6_SIZE(35)-F_I6_SIZE(8), F_I6_SIZE(65), F_I6_SIZE(16));
                _lineLb.frame=CGRectMake(0, F_I6_SIZE(70)-1, DEVICE_WIDTH, 1);
                [_headerImage sd_setImageWithURL:[NSURL URLWithString:data.headerPic]placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            }
                break;
            case 1:
            {
                _afterLb.hidden=NO;
                _afterLb.text=data.mobile;
                _titleLb.text=@"手机号";
            }
                break;

            case 2:
            {
                _afterLb.hidden=NO;
                _afterLb.text=data.nickName;
                _titleLb.text=@"昵称";
            }
                break;

            case 3:
            {
                _titleLb.text=@"修改密码";
            }
                break;

            default:
                break;
        }
    }
    else
    {
        switch (indexPath.row) {
            case 0:
            {
                _afterLb.hidden = NO;
                _afterLb.text=data.realName;
                _titleLb.text=@"姓名";
            }
                break;
            case 1:
            {
                _manLb.hidden=NO;
                _womanLb.hidden=NO;
                _sexImageLeft.hidden=NO;
                _sexImageRight.hidden=NO;
                _titleLb.text=@"性别";
                if ([data.sex integerValue]==0) {
                    _sexImageLeft.selected=NO;
                    _sexImageRight.selected=YES;
                }else{
                    _sexImageLeft.selected=YES;
                    _sexImageRight.selected=NO;
                }
                self.accessoryType=UITableViewCellAccessoryNone;
            }
                break;

            case 2:
            {
                _titleLb.text=@"出生日期";
                _afterLb.hidden=NO;
                _afterLb.text=data.birthday;
            }
                break;

            default:
                break;
        }
        
    }
}
//- (void)btnClick:(UIButton*)btn
//{
//    btn.selected=YES;
//    if (btn.tag==100) {
//        _sexImageRight.selected=NO;
//    }else{
//        _sexImageLeft.selected=NO;
//    }
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
