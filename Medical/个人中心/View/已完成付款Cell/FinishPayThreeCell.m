//
//  FinishPayThreeCell.m
//  Medical
//
//  Created by 李壮 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "FinishPayThreeCell.h"

@implementation FinishPayThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _goOnBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        _goOnBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(75), F_I6_SIZE(5), F_I6_SIZE(60), F_I6_SIZE(20));
        _goOnBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
        [_goOnBtn setTitle:@"继续购买" forState:0];
        [_goOnBtn setTitleColor:[UIColor whiteColor] forState:0];
        _goOnBtn.clipsToBounds=YES;
        _goOnBtn.layer.cornerRadius=5;
        _goOnBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
        [self.contentView addSubview:_goOnBtn];
        
//        _delegateBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//        _delegateBtn.frame=CGRectMake(DEVICE_WIDTH-F_I6_SIZE(150), F_I6_SIZE(5), F_I6_SIZE(60), F_I6_SIZE(20));
//        _delegateBtn.backgroundColor =[UIColor wjColorFloat:KMedical_Blue];
//        [_delegateBtn setTitle:@"删除订单" forState:0];
//        [_delegateBtn setTitleColor:[UIColor whiteColor] forState:0];
//        _delegateBtn.clipsToBounds=YES;
//        _delegateBtn.layer.cornerRadius=5;
//        _delegateBtn.titleLabel.font =[UIFont systemFontOfSize:F_I6_SIZE(12)];
//        [self.contentView addSubview:_delegateBtn];
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
