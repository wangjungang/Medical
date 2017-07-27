//
//  oldlabel.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface oldlabel : UILabel
@property (assign, nonatomic) BOOL strikeThroughEnabled; // 是否画线
@property (strong, nonatomic) UIColor *strikeThroughColor; // 画线颜色
@end
