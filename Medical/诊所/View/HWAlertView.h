//
//  HWAlertView.h
//  YeWenOwner
//
//  Created by 李壮 on 16/8/22.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatePickView.h"
@class HWAlertView;

@protocol HWAlertViewDelegate <NSObject>

/**
 *  HWAlertView代理方法，选项按钮点击事件
 *
 *  @param alertView HWAlertView
 *  @param tag       选项按钮tag值，左0右1
 */
- (void)alertView:(HWAlertView *)alertView didSelectOptionButtonWithTag:(NSInteger)tag TFContents:(NSMutableArray*)contents;

@end

@interface HWAlertView : UIWindow

@property (nonatomic, weak) id<HWAlertViewDelegate> delegate;
@property (nonatomic,strong)UITextView *phoneTF,*nameTF,*addressTF,*timeTF;
@property (nonatomic,strong)UIButton *cancleBtn,*sureBtn;
@property (nonatomic,strong)UIImageView *imageView;
@property (nonatomic,strong)DatePickView*datePick;

- (void)show;
- (void)dismiss;
- (void)chaneBtnTitel:(NSString*)title btnFrame:(CGRect)rect enabled:(BOOL)edit;
///初始化方法
- (id)initWithFrame:(CGRect)frame backImageFrame:(CGRect)imageRect imageName:(NSString*)imageName alertTitle:(NSString*)title;
///设置tf数量frame
- (void)setTFNum:(NSInteger)numtf x:(CGFloat)x y:(CGFloat)y height:(CGFloat)height width:(CGFloat)width interval:(CGFloat)interval;
///设置lb数量frame
- (void)setLbNum:(NSInteger)numlb x:(CGFloat)x y:(CGFloat)y height:(CGFloat)height width:(CGFloat)width interval:(CGFloat)interval lbtitleAry:(NSArray*)titles;
@end
// 屏幕宽度
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
// 屏幕高度
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
// 导航栏
#define NAV_H   44
// Tabbar
#define TABBAR_H    49/// 根据iphone6 效果图的尺寸 算出实际设备中尺寸
#define F_I6_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone5 效果图的尺寸 算出实际设备中尺寸
#define F_I5_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/320.f)) * 2 ) ) / 2.f )

