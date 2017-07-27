//
//  YuyueOfficeCell.m
//  Medical
//
//  Created by 张婷 on 16/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "YuyueOfficeCell.h"

@implementation YuyueOfficeCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _yuyueNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15*WIDTH_SCALE, 10 *HEIGHT_SCALE, DEVICE_WIDTH - 30*WIDTH_SCALE, 15 *HEIGHT_SCALE)];
        _yuyueNameLabel.textColor = [UIColor wjColorFloat:@"191919"];
        _yuyueNameLabel.textAlignment = NSTextAlignmentLeft;
        _yuyueNameLabel.font = [UIFont systemFontOfSize:14 *WIDTH_SCALE];
        [self addSubview:_yuyueNameLabel];
        _yuyueTopLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(17*WIDTH_SCALE, 35 *HEIGHT_SCALE, DEVICE_WIDTH - 34*WIDTH_SCALE, 1 *HEIGHT_SCALE)];
        _yuyueTopLineLabel.backgroundColor = Line_Color;
        [self addSubview:_yuyueTopLineLabel];
        _yuyueBottomLineLabel = [[UILabel alloc] init];
        _yuyueBottomLineLabel.backgroundColor = Line_Color;
        [self addSubview:_yuyueBottomLineLabel];

        
    }
    return self;
}
-(void)getYuyueOffinceDataSource:(KeshiDetailsData  *)data indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *childArray = [[NSMutableArray alloc] init];
    [childArray addObjectsFromArray:data.child];
//
    for (int i = 0; i < childArray.count; i ++)
    {
        KeshiDetailsChild *child = childArray[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((30 +i%4*(60 + 25)) *WIDTH_SCALE, (35 + 15 + i/4 *(20 + 15))*HEIGHT_SCALE , 60 *WIDTH_SCALE, 20 *HEIGHT_SCALE);
//        button.backgroundColor = [UIColor redColor];
         [button setTitle:child.name forState:UIControlStateNormal];
        [button setTitleColor:[UIColor wjColorFloat:@"191919"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:13 *WIDTH_SCALE];
        button.clipsToBounds = YES;
        button.layer.cornerRadius = 10 *WIDTH_SCALE;
        button.layer.borderColor = kCOLOR(210, 210, 210, 1).CGColor;
        button.layer.borderWidth = 1 *WIDTH_SCALE;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = indexPath.row*1000 +i+10;
        [self addSubview:button];
    }
    _yuyueNameLabel.text = data.name;
    
    data.rowH = (50 +(childArray.count/4 + 1) *(20 + 15))*HEIGHT_SCALE;
    _yuyueBottomLineLabel.frame = CGRectMake(0, data.rowH - 1 *HEIGHT_SCALE, DEVICE_WIDTH, 1 *HEIGHT_SCALE);
}
-(void)buttonClick:(UIButton *)button
{
    [self.delegate yuyueOfficeButtonClick:button.tag];
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
