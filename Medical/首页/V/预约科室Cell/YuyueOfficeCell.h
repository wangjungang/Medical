//
//  YuyueOfficeCell.h
//  Medical
//
//  Created by 张婷 on 16/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YuyueOfficeCell;
@protocol YuyueOfficeCellDelegate <NSObject>

-(void)yuyueOfficeButtonClick:(long)index;

@end
@interface YuyueOfficeCell : UITableViewCell
@property(nonatomic,strong)UILabel *yuyueNameLabel;
@property(nonatomic,strong)UILabel *yuyueTopLineLabel;
@property(nonatomic,strong)UILabel *yuyueBottomLineLabel;
@property(nonatomic,assign)id<YuyueOfficeCellDelegate>delegate;
-(void)getYuyueOffinceDataSource:(KeshiDetailsData *)data indexPath:(NSIndexPath *)indexPath;
@end
