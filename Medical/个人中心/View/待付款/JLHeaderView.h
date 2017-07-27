//
//  JLHeaderView.h
//  Medical
//
//  Created by 王俊钢 on 2016/12/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JLHeaderView;
@class waitpayModel;
@protocol JLHeaderViewDelegate <NSObject>

@optional
- (void)foldHeaderInSection:(NSInteger)SectionHeader andid:(UIButton *)sender;

@end
@interface JLHeaderView : UITableViewHeaderFooterView
@property (nonatomic,strong) UIButton *choosebtn;
@property (nonatomic,strong) UILabel *orderlabel;
@property(nonatomic, assign) NSInteger section;/**< 选中的section */
@property (nonatomic,strong)id<JLHeaderViewDelegate> delegate;

@property(assign,nonatomic)BOOL selectState;//选中状态

-(void)setCellDate:(waitpayModel *)wmodel;
@end
