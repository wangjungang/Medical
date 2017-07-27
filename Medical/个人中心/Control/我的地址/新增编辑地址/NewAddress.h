//
//  NewAddress.h
//  YeWenOwner
//
//  Created by HOSO MAC 1 on 16/8/23.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAddress : UIViewController
@property (nonatomic,assign)NSInteger index;
@property (nonatomic,assign)BOOL isAdd;
@property (nonatomic,strong)id data;

@property (nonatomic,assign)NSString *type;

@property (nonatomic,strong)NSString *cityaddress;
@property (nonatomic,strong)NSString *detailedaddress;
@property (nonatomic,strong)NSString *namestr;
@property (nonatomic,strong)NSString *phonestr;


@property (nonatomic,strong)NSString *addressid;

@end

// 导航栏
#define NAV_H   44
// Tabbar
#define TABBAR_H    49/// 根据iphone6 效果图的尺寸 算出实际设备中尺寸
#define F_I6_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone5 效果图的尺寸 算出实际设备中尺寸
#define F_I5_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/320.f)) * 2 ) ) / 2.f )
