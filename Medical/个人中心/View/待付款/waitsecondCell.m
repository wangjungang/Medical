//
//  waitsecondCell.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "waitsecondCell.h"
#import "waitpayModel.h"
#import "UIImageView+WebCache.h"
@interface waitsecondCell()
@property (nonatomic,strong) waitpayModel *waitmodel;
@end
@implementation waitsecondCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.drugshopimage];
        [self.contentView addSubview:self.druglabel];
        [self.contentView addSubview:self.drugnamelabel];
        [self.contentView addSubview:self.numberlabel];
        [self.contentView addSubview:self.pricelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.drugshopimage.frame = CGRectMake(35, 10, 60, self.frame.size.height-20);
    self.druglabel.frame = CGRectMake(105, 10, 50, 20);
    self.drugnamelabel.frame = CGRectMake(105, self.frame.size.height/2, 50, 20);
    self.pricelabel.frame = CGRectMake(DEVICE_WIDTH-45, 10, 30, 20);
    self.numberlabel.frame = CGRectMake(DEVICE_WIDTH-85, self.frame.size.height/2, 70, 20);
}

#pragma mark - getters

-(UIImageView *)drugshopimage
{
    if(!_drugshopimage)
    {
        _drugshopimage = [[UIImageView alloc] init];
    }
    return _drugshopimage;
}

-(UILabel *)druglabel
{
    if(!_druglabel)
    {
        _druglabel = [[UILabel alloc] init];
        _druglabel.textColor = [UIColor wjColorFloat:@"cccccc"];
        _druglabel.font = [UIFont systemFontOfSize:13];
        
    }
    return _druglabel;
}

-(UILabel *)drugnamelabel
{
    if(!_drugnamelabel)
    {
        _drugnamelabel = [[UILabel alloc] init];
        _drugnamelabel.textColor = [UIColor wjColorFloat:@"a6e5e7"];
        _drugnamelabel.font = [UIFont systemFontOfSize:12];
        
    }
    return _drugnamelabel;
}

-(UILabel *)pricelabel
{
    if(!_pricelabel)
    {
        _pricelabel = [[UILabel alloc] init];
        _pricelabel.textAlignment = NSTextAlignmentRight;
        _pricelabel.textColor = [UIColor wjColorFloat:@"888888"];
    }
    return _pricelabel;
}

-(UILabel *)numberlabel
{
    if(!_numberlabel)
    {
        _numberlabel = [[UILabel alloc] init];
        _numberlabel.textColor = [UIColor wjColorFloat:@"888888"];
        _numberlabel.textAlignment = NSTextAlignmentRight;
    }
    return _numberlabel;
}

-(void)setCellDate:(waitpayModel *)wmodel;
{
    self.waitmodel = wmodel;
    [self.drugshopimage sd_setImageWithURL:[NSURL URLWithString:wmodel.durgpicture]];
    self.pricelabel.text = wmodel.totalprice;
//    self.numberlabel.text = wmodel.number;
    self.numberlabel.text = [NSString stringWithFormat:@"%@%@",@"x ",wmodel.number];
    self.drugnamelabel.text = wmodel.drugname;
    self.druglabel.text = wmodel.effect;
}

@end
