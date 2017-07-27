//
//  waitthirdCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/11.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell;
-(void)deltypeClick:(UITableViewCell *)cell;
@end

@interface waitthirdCell : UITableViewCell
@property (nonatomic,strong) UIButton *buybtn;
@property (nonatomic,strong) UIButton *delbtn;
@property(assign,nonatomic)id<myTabVdelegate>delegate;

@end
