//
//  AddressCell.h
//  YeWenOwner
//
//  Created by 李壮 on 16/8/24.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myaddressModel;

//创建一个代理
@protocol defaultTabVdelegate <NSObject>
-(void)defaultTabVClick:(UITableViewCell *)cell;
@end

@interface AddressCell : UITableViewCell
@property (nonatomic,strong)UILabel *nameLb,*addressLb,*phoneLb;
@property (nonatomic,strong)UILabel *defalutlb;
@property (nonatomic,strong)UIButton *defaultbtn;
- (void)setCellDataSource:(myaddressModel *)data;
@property(assign,nonatomic)id<defaultTabVdelegate>delegate;
@end

// 导航栏
#define NAV_H   44
// Tabbar
#define TABBAR_H    49/// 根据iphone6 效果图的尺寸 算出实际设备中尺寸
#define F_I6_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone5 效果图的尺寸 算出实际设备中尺寸
#define F_I5_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/320.f)) * 2 ) ) / 2.f )
