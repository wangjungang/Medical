//
//  waitfirstCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class waitpayModel;

@protocol waitPaydelegate <NSObject>

-(void)waitPayClick:(UITableViewCell *)cell;

@end

@interface waitfirstCell : UITableViewCell
@property (nonatomic,strong) UIButton *pointbtn;
@property (nonatomic,strong) UILabel *shoplabel;
@property (nonatomic,strong) UIImageView *shopimage;

@property(assign,nonatomic)id<waitPaydelegate>delegate;

@property(assign,nonatomic)BOOL selectState;//选中状态
-(void)setCellDate:(waitpayModel *)wmodel;

@end
