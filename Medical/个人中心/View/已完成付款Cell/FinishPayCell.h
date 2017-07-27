//
//  FinishPayCell.h
//  Medical
//
//  Created by 李壮 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryPayData.h"
#import "FinishShopListBuyProduct.h"
@interface FinishPayCell : UITableViewCell
@property (nonatomic,strong)UIImageView*shopImage;
@property (nonatomic,strong)UILabel*shopName,*payStatus;
- (void)setCellContent:(FinishShopListBuyProduct*)data;

@end

#define F_I6_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/375.f)) * 2 ) ) / 2.f )
/// 根据iphone5 效果图的尺寸 算出实际设备中尺寸
#define F_I5_SIZE(f)    ( ( (int)( (DEVICE_WIDTH * ((f)/320.f)) * 2 ) ) / 2.f )
