//
//  MyThirdCell.m
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/3.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import "MyThirdCell.h"
@implementation MyThirdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        NSMutableArray *titleArray = [[NSMutableArray alloc] initWithObjects:@"会员专享",@"特价商品",@"积分换购",@"合作商家", nil];
        for (int i = 0; i < 4; i ++)
        {
            int button_w = 25;
            float interval_x = 60;
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            if (i == 3)
            {
                button.frame = CGRectMake((42 + i *(button_w + interval_x + 5))*WIDTH_SCALE, 15 *HEIGHT_SCALE, 20 *WIDTH_SCALE, button_w *WIDTH_SCALE);
            }
            else
            {
                button.frame = CGRectMake((42 + i *(button_w + interval_x + 3))*WIDTH_SCALE, 15 *HEIGHT_SCALE, button_w *WIDTH_SCALE, button_w *WIDTH_SCALE);
                
            }
            
            [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"首页button-%d",i + 7]] forState:UIControlStateNormal];
//            button.backgroundColor = [UIColor redColor];
            
            [self addSubview:button];
            
            
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.center = CGPointMake(button.center.x, 55 *HEIGHT_SCALE);
            titleLabel.bounds = CGRectMake(0, 0, 60 *WIDTH_SCALE, 15 *HEIGHT_SCALE);
            titleLabel.text = titleArray[i];
            titleLabel.font = [UIFont systemFontOfSize:12*WIDTH_SCALE weight:3*WIDTH_SCALE];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = kCOLOR(199, 199, 199, 1);
            [self addSubview:titleLabel];
            
            UIButton *bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
            bigButton.frame = CGRectMake((20 + i *(button_w + interval_x + 3))*WIDTH_SCALE, 5 *HEIGHT_SCALE, 60 *WIDTH_SCALE, 70 *WIDTH_SCALE);;
//            bigButton.backgroundColor = [UIColor redColor];
            [bigButton addTarget:self action:@selector(bigButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            bigButton.tag = 10+i;
            [self addSubview:bigButton];
        }
    }
    return self;
}

-(void)bigButtonClick:(UIButton *)button
{
    [_Delegate myThirdCellButtonClick:button.tag];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
