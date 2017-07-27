//
//  waitsecondCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class waitpayModel;
@interface waitsecondCell : UITableViewCell
@property (nonatomic,strong) UIImageView *drugshopimage;
@property (nonatomic,strong) UILabel *druglabel;
@property (nonatomic,strong) UILabel *drugnamelabel;
@property (nonatomic,strong) UILabel *pricelabel;
@property (nonatomic,strong) UILabel *numberlabel;
-(void)setCellDate:(waitpayModel *)wmodel;
@end
