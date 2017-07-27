//
//  HospitalCell.h
//  Medical
//
//  Created by 张婷 on 16/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HospitalCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *hospitalImageView;
@property(nonatomic,strong)UILabel *hospitalLabel;
-(void)getHospitalListDataSource:(NSMutableArray *)dataArray indexPath:(NSIndexPath *)indexPath;
@end
