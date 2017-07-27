//
//  MyCaseListCell.m
//  Medical
//
//  Created by 李壮 on 2016/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "MyCaseListCell.h"

@implementation MyCaseListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _name = [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(5), F_I6_SIZE(DEVICE_WIDTH-F_I6_SIZE(20)), F_I6_SIZE(20))];
        _name.textColor =[UIColor wjColorFloat:@"7f7f7f"];
        _caseName = [[UILabel alloc]initWithFrame:CGRectMake(F_I6_SIZE(10), F_I6_SIZE(30), DEVICE_WIDTH-F_I6_SIZE(20), F_I6_SIZE(15))];
        _name.font=[UIFont systemFontOfSize:F_I6_SIZE(17)];
        _caseName.textColor =[UIColor wjColorFloat:@"7f7f7f"];
        _caseName.font =[UIFont systemFontOfSize:F_I6_SIZE(15)];
        
        [self.contentView addSubview:_name];
        [self.contentView addSubview:_caseName];
        
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return self;
}
- (void)setCellContent:(MyCaseListDataModel*)data
{
    _name.text=[NSString stringWithFormat:@"姓名：%@",data.userName];
    _caseName.text=[NSString stringWithFormat:@"病症名称：%@",data.disease];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
