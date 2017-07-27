//
//  pharmarcyPrice.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "pharmarcyPrice.h"

@interface pharmarcyPrice()
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UIImageView *triangleimage;
@end
@implementation pharmarcyPrice

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.titlelabel];
        [self addSubview:self.triangleimage];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titlelabel.frame = CGRectMake((self.frame.size.width/2-20)*WIDTH_SCALE, 12, 30, 15);
    self.triangleimage.frame = CGRectMake((self.frame.size.width/2+22)*WIDTH_SCALE, 15, 8, 10);

}

#pragma mark - getters

-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"价格";
        _titlelabel.adjustsFontSizeToFitWidth = YES;
    }
    return _titlelabel;
}

-(UIImageView *)triangleimage
{
    if(!_triangleimage)
    {
        _triangleimage = [[UIImageView alloc] init];
        _triangleimage.image = [UIImage imageNamed:@"图层18"];
    }
    return _triangleimage;
}
@end
