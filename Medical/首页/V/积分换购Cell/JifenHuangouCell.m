//
//  JifenHuangouCell.m
//  Medical
//
//  Created by 张婷 on 16/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "JifenHuangouCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation JifenHuangouCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _jifenImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 10*HEIGHT_SCALE, frame.size.width - 20 *WIDTH_SCALE, 70*HEIGHT_SCALE)];
        [self addSubview:_jifenImageView];

        _signLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 85 *HEIGHT_SCALE, frame.size.width - 20*WIDTH_SCALE , 15 *HEIGHT_SCALE)];
        _signLabel.textColor = [UIColor wjColorFloat:@"01c4c8"];
        _signLabel.font = [UIFont systemFontOfSize:13 *WIDTH_SCALE];
        _signLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_signLabel];
        _effectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 105 *HEIGHT_SCALE, frame.size.width - 20*WIDTH_SCALE , 30 *HEIGHT_SCALE)];
        _effectLabel.text = @"功效：小儿腹泻贴小儿腹泻贴小儿腹泻贴小儿腹泻贴小儿腹泻贴小儿腹泻贴。";
        _effectLabel.textColor = [UIColor wjColorFloat:@"747474"];
        _effectLabel.font = [UIFont systemFontOfSize:11 *WIDTH_SCALE];
        _effectLabel.textAlignment = NSTextAlignmentLeft;
        _effectLabel.numberOfLines = 0;
        [self addSubview:_effectLabel];

        _jifenLabel = [[UILabel alloc] initWithFrame:CGRectMake(10  *WIDTH_SCALE, 135 *HEIGHT_SCALE, frame.size.width - 20*WIDTH_SCALE , 15 *HEIGHT_SCALE)];
        _jifenLabel.textColor = [UIColor wjColorFloat:@"ff0012"];
        _jifenLabel.font = [UIFont systemFontOfSize:11 *WIDTH_SCALE];
        _jifenLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_jifenLabel];

    }
    return self;
}
- (void)setItemContentData:(ListShopIntegralData*)data
{
    [_jifenImageView sd_setImageWithURL:[NSURL URLWithString:data.pictures] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _signLabel.text=data.drugName;
    _effectLabel.text=data.effect;
    _jifenLabel.text=data.integral;
}
@end
