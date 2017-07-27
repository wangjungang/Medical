//
//  AlipayModels.h
//  Medical
//
//  Created by 张婷 on 16/11/28.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlipayModels : NSString
+(void)alipayModelWithOrderid:(NSString *)orderid withName:(NSString *)name withMoney:(NSString *)money withNotify:(NSString *)notify withViewcontroller:(UIViewController *)vc;
@end
