//
//  FinishPayTwoCell.m
//  Medical
//
//  Created by 李壮 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "FinishPayTwoCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation FinishPayTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _shopImage = [[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(15), F_I6_SIZE(10), F_I6_SIZE(50), F_I6_SIZE(40))];
        [self.contentView addSubview:_shopImage];
        
        _shopTitle =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(75), F_I6_SIZE(30), F_I6_SIZE(200), F_I6_SIZE(12))];
        _shopTitle.textColor=[UIColor wjColorFloat:@"13cace"];
        _shopTitle.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        [self.contentView addSubview:_shopTitle];
        
        _shopClass =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(75), F_I6_SIZE(10), F_I6_SIZE(200), F_I6_SIZE(12))];
        _shopClass.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        [self.contentView addSubview:_shopClass];
        
        _priceLb = [[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-F_I6_SIZE(110), F_I6_SIZE(15), F_I6_SIZE(100), F_I6_SIZE(12))];
        _priceLb.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        _priceLb.textColor =[UIColor wjColorFloat:@"7f7f7f"];
        _priceLb.textAlignment=2;
        [self.contentView addSubview:_priceLb];
        
        _shopNumLb =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-F_I6_SIZE(110), F_I6_SIZE(125/2)-F_I6_SIZE(27), F_I6_SIZE(100), F_I6_SIZE(12))];
        _shopNumLb.textAlignment=2;
        _shopNumLb.textColor =[UIColor wjColorFloat:@"7f7f7f"];
        _shopNumLb.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        [self.contentView addSubview:_shopNumLb];
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    return self;
}
- (void)setCellContent:(FinishShopListBuyProduct*)data;
{
    
    if (data.drugName) {
        _shopTitle.text=data.drugName;
        [_shopImage sd_setImageWithURL:[NSURL URLWithString:data.pictures] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        _shopTitle.text=data.name;
        [_shopImage sd_setImageWithURL:[NSURL URLWithString:data.picture] placeholderImage:[UIImage imageNamed:@""]];
    }
    _shopNumLb.text=[NSString stringWithFormat:@"X%@",data.number];
    _shopClass.text=data.effect;
    _priceLb.text=[NSString stringWithFormat:@"$%@",data.sprice];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
