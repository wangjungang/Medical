//
//  JifenHuangouCell.h
//  Medical
//
//  Created by 张婷 on 16/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListShopIntegralData.h"
@interface JifenHuangouCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *jifenImageView;
@property(nonatomic,strong)UILabel *signLabel, *effectLabel,*jifenLabel;
- (void)setItemContentData:(ListShopIntegralData*)data;
@end
