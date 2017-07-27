//
//  HospitalCell.m
//  Medical
//
//  Created by 张婷 on 16/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "HospitalCell.h"
#import <UIImageView+WebCache.h>
@implementation HospitalCell
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
//        NSLog(@"=====%f",frame.size.width);
        _hospitalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, frame.size.width - 10, frame.size.width - 20 *HEIGHT_SCALE)];
        _hospitalImageView.image = [UIImage imageNamed:@"hospital"];
        [self addSubview:_hospitalImageView];
        
        _hospitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width - 10 *HEIGHT_SCALE, frame.size.width , frame.size.height - frame.size.width)];
        _hospitalLabel.text = @"北京国际中医院";
        _hospitalLabel.textColor = [UIColor wjColorFloat:@"191919"];
        _hospitalLabel.font = [UIFont systemFontOfSize:14 *WIDTH_SCALE];
        _hospitalLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_hospitalLabel];
    }
    return self;
}
-(void)getHospitalListDataSource:(NSMutableArray *)dataArray indexPath:(NSIndexPath *)indexPath
{
    HospitalListData *data = dataArray[indexPath.item];
    [_hospitalImageView sd_setImageWithURL:[NSURL URLWithString:data.picture]];
    _hospitalLabel.text = data.name;
}
@end
