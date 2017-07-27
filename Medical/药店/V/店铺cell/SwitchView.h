//
//  SwitchView.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/8.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchView : UIView
@property UIButton *button1;
@property UIButton *button2;
@property UIButton *button3;
@property UIButton *button4;
@property UIButton *button5;
@property ( strong) void (^ButtonActionBlock)(int buttonTag);
-(void)swipeAction:(int)tag;
@end
