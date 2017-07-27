//
//  DuizhengXiayaoRightCell.m
//  Medical
//
//  Created by 张婷 on 16/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "DuizhengXiayaoRightCell.h"

@implementation DuizhengXiayaoRightCell
-(void)getDuizhengRightDataSource:(NSMutableArray *)dataArray
{
    for (int i = 0; i <dataArray.count; i ++)
    {
        CGRect frame = CGRectMake(i%2*(DEVICE_WIDTH -115*WIDTH_SCALE)/2 + 5 *WIDTH_SCALE, i/2*155 *HEIGHT_SCALE, (DEVICE_WIDTH -115*WIDTH_SCALE)/2 -5 *WIDTH_SCALE, 158 *HEIGHT_SCALE);
        UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 10*HEIGHT_SCALE, frame.size.width - 20 *WIDTH_SCALE, 70*HEIGHT_SCALE)];
        rightImageView.image = [UIImage imageNamed:@"placeholder"];
        [self addSubview:rightImageView];
        
        UILabel *rightSignLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 85 *HEIGHT_SCALE, frame.size.width - 20*WIDTH_SCALE , 15 *HEIGHT_SCALE)];
        rightSignLabel.text = @"小儿腹泻贴";
        rightSignLabel.textColor = [UIColor wjColorFloat:@"01c4c8"];
        rightSignLabel.font = [UIFont systemFontOfSize:13 *WIDTH_SCALE];
        rightSignLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:rightSignLabel];
        UILabel *rightEffectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 *WIDTH_SCALE, 105 *HEIGHT_SCALE, frame.size.width - 20*WIDTH_SCALE , 30 *HEIGHT_SCALE)];
        rightEffectLabel.text = @"功效：小儿腹泻贴小儿腹泻贴小儿腹泻贴小儿腹泻贴小儿腹泻贴小儿腹泻贴。";
        rightEffectLabel.textColor = [UIColor wjColorFloat:@"747474"];
        rightEffectLabel.font = [UIFont systemFontOfSize:10 *WIDTH_SCALE];
        rightEffectLabel.textAlignment = NSTextAlignmentLeft;
        rightEffectLabel.numberOfLines = 2;
        [self addSubview:rightEffectLabel];
        
        UILabel *shjiajiaLabel = [[UILabel alloc] initWithFrame:CGRectMake(10  *WIDTH_SCALE, 135 *HEIGHT_SCALE, frame.size.width/2 - 8*WIDTH_SCALE , 15 *HEIGHT_SCALE)];
        shjiajiaLabel.text = @"市价¥200";
        shjiajiaLabel.textColor = [UIColor wjColorFloat:@"747474"];
        shjiajiaLabel.font = [UIFont systemFontOfSize:10 *WIDTH_SCALE];
        shjiajiaLabel.textAlignment = NSTextAlignmentLeft;
//        shjiajiaLabel.backgroundColor = [UIColor redColor];
        [self addSubview:shjiajiaLabel];
        UILabel *xianjiaLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/2 + 2 *WIDTH_SCALE, 135 *HEIGHT_SCALE, frame.size.width/2 - 12*WIDTH_SCALE , 15 *HEIGHT_SCALE)];
        xianjiaLabel.text = @"现价¥200";
        xianjiaLabel.textColor = [UIColor wjColorFloat:@"ff0012"];
        xianjiaLabel.font = [UIFont systemFontOfSize:10 *WIDTH_SCALE];
        xianjiaLabel.textAlignment = NSTextAlignmentRight;
//        xianjiaLabel.backgroundColor = [UIColor purpleColor];
        [self addSubview:xianjiaLabel];
        
        
    }
}

@end
