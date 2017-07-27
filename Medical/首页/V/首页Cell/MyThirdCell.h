//
//  MyThirdCell.h
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/3.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MyThirdCellDelegate <NSObject>

-(void)myThirdCellButtonClick:(NSInteger)index;

@end


@interface MyThirdCell : UITableViewCell
@property (nonatomic ,retain)UIImageView *bannerImageView;
@property (nonatomic ,retain)UIImageView *littleImageView;
@property (nonatomic ,retain)UILabel *titleLabel;
@property (nonatomic ,retain)UIButton *shoppingButton;
@property (nonatomic, assign)id<MyThirdCellDelegate>Delegate;
@end
