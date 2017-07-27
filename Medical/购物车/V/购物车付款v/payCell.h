//
//  payCell.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/10.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
//创建一个代理
@protocol myTabVdelegate <NSObject>

-(void)myTabVClick:(UITableViewCell *)cell;

@end
@interface payCell : UITableViewCell
@property(nonatomic,strong)UILabel *moneyLabel;
@property(nonatomic,strong)UITextField *moneyTF;
@property (nonatomic,strong) UIImageView *itemimage;
@property (nonatomic,strong) UILabel *paynamelabel;
@property (nonatomic,strong) UIButton *pointbtn;

@property (nonatomic,strong) void(^btnClick)();
@property(assign,nonatomic)id<myTabVdelegate>delegate;
@end
