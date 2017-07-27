//
//  HeaderView.h
//  Medical
//
//  Created by 李壮 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoData.h"
@protocol HeaderViewDelegate <NSObject>

@optional
- (void)getbtnIndex:(NSInteger)btnTag;
@end



@interface HeaderView : UIView
@property (nonatomic,strong)UIButton*notPayBtn,*finishPayBtn,*accountBtn,*accountManagerBtn;
@property (nonatomic,strong)UIImageView*headerImage,*vipIcon,*integralIcon,*backgroundImage;
@property (nonatomic,strong)UILabel*nameLb,*integralLb,*myIndent,*vipLb;
@property (nonatomic,strong)UserInfoData*data;
@property (nonatomic,assign)id<HeaderViewDelegate>delegate;
///设置区头内容
- (void)setViewContent:(UserInfoData*)data;
@end
// 导航栏
#define NAV_H   44
// Tabbar
#define TABBAR_H    49/// 根据iphone6 效果图的尺寸 算出实际设备中尺寸
#define F_I6_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone5 效果图的尺寸 算出实际设备中尺寸
#define F_I5_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/320.f)) * 2 ) ) / 2.f )
