//
//  MerchantCell.h
//  Medical
//
//  Created by 张婷 on 16/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JoinHandelData.h"
@interface MerchantCell : UITableViewCell
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *nextButton;
@property(nonatomic,strong)UIImageView *merchantImageView;
- (void)setCellCongtent:(JoinHandelData*)data;
@end
