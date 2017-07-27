//
//  ProtocolDelegate.h
//  Medical
//
//  Created by 王俊钢 on 2016/12/5.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ProtocolDelegate <NSObject>

// 必须实现的方法
@required
- (void)error;

// 可选实现的方法
@optional
- (void)other;
- (void)other2;
- (void)other3;

@end
