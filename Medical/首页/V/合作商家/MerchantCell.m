//
//  MerchantCell.m
//  Medical
//
//  Created by 张婷 on 16/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "MerchantCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation MerchantCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 10 *HEIGHT_SCALE, 300 *WIDTH_SCALE, 15 *HEIGHT_SCALE)];
        _nameLabel.font = [UIFont systemFontOfSize:15 *WIDTH_SCALE];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = [UIColor wjColorFloat:@"191919"];
        [self addSubview:_nameLabel];
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(DEVICE_WIDTH - 10*WIDTH_SCALE - 15*WIDTH_SCALE, 13 *HEIGHT_SCALE, 10 *WIDTH_SCALE, 12*HEIGHT_SCALE);
        [_nextButton setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
        [self addSubview:_nextButton];
        
        _merchantImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 35 *HEIGHT_SCALE, DEVICE_WIDTH, 165 *HEIGHT_SCALE)];
        [self addSubview:_merchantImageView];
    }
    return self;
}
- (void)setCellCongtent:(JoinHandelData*)data
{
    _nameLabel.text=data.name;
    [_merchantImageView sd_setImageWithURL:[NSURL URLWithString:data.picture] placeholderImage:[UIImage imageNamed:@""]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
