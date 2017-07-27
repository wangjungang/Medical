//
//  MySecondCell.h
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/3.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MySecondCell;
@protocol  MySecondCellDelegate<NSObject>

-(void)clickButtonViewWithTag:(NSInteger)index;

@end
@interface MySecondCell : UITableViewCell
{

    NSMutableArray *_topImageArray;
    NSMutableArray *_topTitleArray;
}
@property(nonatomic,assign)id<MySecondCellDelegate>delegate;
- (void)setCellContent:(NSInteger)num;
- (void)setCellContenticon:(NSArray*)array;
@end
