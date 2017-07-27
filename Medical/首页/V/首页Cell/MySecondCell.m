//
//  MySecondCell.m
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/3.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import "MySecondCell.h"
//
//#import "UIImageView+WebCache.h"
@implementation MySecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        for (int i = 0; i < 6; i ++)
        {
            int button_w = 90;
            int interval_x = 33;
            int interval_y = 7;
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake((20  + i %3*(button_w + interval_x)) *WIDTH_SCALE, (8 +i/3*(button_w  + interval_y))*WIDTH_SCALE, button_w *WIDTH_SCALE, button_w *WIDTH_SCALE);
//            button.backgroundColor = [UIColor redColor];
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"首页button-0%d",i+1]] forState:UIControlStateNormal];
            button.tag = i;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
        }
    }
    return self;
}

-(void)buttonClick:(UIButton *)button
{
    [_delegate clickButtonViewWithTag:button.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
