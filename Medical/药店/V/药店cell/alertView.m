//
//  alertView.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "alertView.h"

@interface alertView()
@property (nonatomic,strong) UILabel *textlabel;
@end

@implementation alertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.textlabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textlabel.frame = CGRectMake(30*WIDTH_SCALE, 15*HEIGHT_SCALE, 120*WIDTH_SCALE, 30*HEIGHT_SCALE);
}

#pragma mark - getters

-(UILabel *)textlabel
{
    if(!_textlabel)
    {
        _textlabel = [[UILabel alloc] init];
        //_textlabel.backgroundColor = [UIColor redColor];
        _textlabel.adjustsFontSizeToFitWidth = YES;
        _textlabel.textAlignment = NSTextAlignmentCenter;
        _textlabel.text = @"该商家暂停服务";
    }
    return _textlabel;
}


@end
