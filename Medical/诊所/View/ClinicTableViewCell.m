//
//  ClinicTableViewCell.m
//  Medical
//
//  Created by 李壮 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "ClinicTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation ClinicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image=[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(20/2), F_I6_SIZE(10), F_I6_SIZE(146/2), F_I6_SIZE(60))];
        
        _nameLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(96), F_I6_SIZE(10), DEVICE_WIDTH-F_I6_SIZE(100), F_I6_SIZE(15))];
        _nameLb.font =[UIFont boldSystemFontOfSize:F_I6_SIZE(15)];
        
        _numLb=[[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(96),F_I6_SIZE(35) ,DEVICE_WIDTH-F_I6_SIZE(100), F_I6_SIZE(12))];
        _numLb.font=[UIFont systemFontOfSize:F_I6_SIZE(12)];
        _numLb.textColor =[UIColor wjColorFloat:@"888888"];
        
        self.starView = [[CWStarRateView alloc] initWithFrame:CGRectMake(F_I6_SIZE(96), F_I6_SIZE(50), F_I6_SIZE(100) ,F_I6_SIZE(25)) numberOfStars:5];
        //self.starRateView.scorePercent = 0.9;
        self.starView.allowIncompleteStar = YES;
        self.starView.hasAnimation = YES;
        
        
        _rangeLb=[[UILabel alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-F_I6_SIZE(110), F_I6_SIZE((167-40)/2), F_I6_SIZE(100), F_I6_SIZE(20))];
        _rangeLb.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        _rangeLb.textAlignment=2;
        _rangeLb.textColor =[UIColor redColor];
        
        [self.contentView addSubview:_nameLb];
        
        [self.contentView addSubview:_starView];
        
        [self.contentView addSubview:_image];
        
        [self.contentView addSubview:_numLb];
        
        [self.contentView addSubview:_rangeLb];
        
 
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    return self;
}
- (void)setCellContent:(ClinicListData*)data
{
    [_image sd_setImageWithURL:[NSURL URLWithString:data.picture] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    _nameLb.text=data.name;
    _numLb.text=data.star;
    _rangeLb.text=data.length;
    self.starView.scorePercent=[data.scale floatValue]/5.0f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
