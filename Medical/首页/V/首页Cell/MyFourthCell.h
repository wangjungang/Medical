//
//  MyFourthCell.h
//  YeWenOwner
//
//  Created by HOSO Mac2 on 16/8/3.
//  Copyright © 2016年 HOSO Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyFourthCell;
@protocol MyFourthCellDelegate <NSObject>

-(void)myFourthCellClickButtonTag:(NSInteger)index;

@end

@interface MyFourthCell : UITableViewCell<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,assign)id<MyFourthCellDelegate>delegate;
@property(nonatomic,assign)CGFloat height;
@property (nonatomic, strong) NSDictionary *dataDic;
    @property(nonatomic,strong)UILabel *lineLabel;
-(void)createWebViewDatasource:(NSMutableArray *)dataArray indexPathRow:(NSInteger)index;


@end
