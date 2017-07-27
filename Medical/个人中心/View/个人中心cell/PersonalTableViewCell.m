//
//  PersonalTableViewCell.m
//  Medical
//
//  Created by 李壮 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "PersonalTableViewCell.h"

@implementation PersonalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _image =[[UIImageView alloc]initWithFrame:CGRectMake(F_I6_SIZE(27/2), F_I6_SIZE(16.5), F_I6_SIZE(25), F_I6_SIZE(25))];
        _titleLb =[[UILabel alloc]initWithFrame:CGRectMake(_image.frame.origin.x+F_I6_SIZE(20+27/2), F_I6_SIZE(21.5), DEVICE_WIDTH-100, F_I6_SIZE(15))];
        _titleLb.font =[UIFont systemFontOfSize:F_I6_SIZE(15)];
        _titleLb.textColor =[UIColor wjColorFloat:@"999999"];
        [self.contentView addSubview:_image];
        [self.contentView addSubview:_titleLb];
        _imageArry=[[NSArray alloc]initWithObjects:@"图层5.png",@"图层6.png",@"图层7.png",@"图层8.png",@"图层9.png",@"图层10.png", nil];
        _titleArry=[[NSArray alloc]initWithObjects:@"地址管理",@"会员充值",@"常见问题",@"在线客服",@"我的病例",@"意见反馈", nil];
        UILabel*lineLb =[[UILabel alloc]initWithFrame:CGRectMake(0, 57, DEVICE_WIDTH, 1)];
        lineLb.backgroundColor =[UIColor colorWithRed:193.f/255 green:193.f/255 blue:193.f/255 alpha:1];
        [self.contentView addSubview:lineLb];
    }
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    return self;
}
- (void)setCellContentIndexPath:(NSIndexPath*)indexPath
{
    _image.image =[UIImage imageNamed:_imageArry[indexPath.row]];
    _titleLb.text=_titleArry[indexPath.row];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
