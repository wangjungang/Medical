//
//  FinishPayCell.m
//  Medical
//
//  Created by 李壮 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "FinishPayCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation FinishPayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 
{
   self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _shopImage=[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(5), F_I6_SIZE(25), F_I6_SIZE(20))];
        [self.contentView addSubview:_shopImage];
        _shopName =[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(45), F_I6_SIZE(5), F_I6_SIZE(200), F_I6_SIZE(20))];
        _shopName.font =[UIFont systemFontOfSize:F_I6_SIZE(14)];
        [self.contentView addSubview:_shopName];
        _payStatus =[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-F_I6_SIZE(80), F_I6_SIZE(5), F_I6_SIZE(50), F_I6_SIZE(20))];
        _payStatus.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        _payStatus.textColor =[UIColor wjColorFloat:@"13cace"];
        [self.contentView addSubview:_payStatus];
        _payStatus.text=@"待支付";
    }
    self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    return self;
}
- (void)setCellContent:(FinishShopListBuyProduct*)data
{
    if (data.drugName) {
        [_shopImage sd_setImageWithURL:[NSURL URLWithString:data.picture] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        _shopName.text=data.name;
    }else{
        _shopName.text=data.gname;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
