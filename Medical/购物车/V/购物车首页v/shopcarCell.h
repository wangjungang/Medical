//
//  shipcarCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"
@class shopcarModel;

//创建一个代理
@protocol shopTabVdelegate <NSObject>

-(void)shopTabVClick:(UITableViewCell *)cell;

-(void)shopaddClick:(UITableViewCell *)cell;
-(void)shopdeleteClick:(UITableViewCell *)cell;
@end

@interface shopcarCell : UITableViewCell
@property (nonatomic,strong) UIButton *cellchoosebtn;
@property (nonatomic,strong) UIImageView *drugimage;
@property (nonatomic,strong) UILabel *drugnamelabel;
@property (nonatomic,strong) UILabel *pricelabel;
@property (nonatomic,strong) UIButton *addbtn;
@property (nonatomic,strong) UIButton *deletebtn;
@property (nonatomic,strong) UILabel *numbertext;


@property(assign,nonatomic)BOOL selectState;//选中状态

@property(assign,nonatomic)id<shopTabVdelegate>delegate;

@property (nonatomic,strong) PPNumberButton *numberbtn;
    
-(void)setCellDate:(shopcarModel *)shopm;
@end
