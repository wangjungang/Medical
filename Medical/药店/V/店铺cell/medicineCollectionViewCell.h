//
//  medicineCollectionViewCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "oldlabel.h"
#import "VIPShopListModelsProducts.h"
@class storeModel;

@interface medicineCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *mdeicineimage;
@property (nonatomic,strong) UILabel *efficacylabel;
@property (nonatomic,strong) UILabel *usedlabel;
@property (nonatomic,strong) oldlabel *oldpricelabel;
@property (nonatomic,strong) UILabel *newpricelabel;
@property (nonatomic,strong) UILabel *namelabel;

-(void)setCellDate:(storeModel *)stomodel;
-(void)setCellData:(VIPShopListModelsProducts*)stomodel;
@end
