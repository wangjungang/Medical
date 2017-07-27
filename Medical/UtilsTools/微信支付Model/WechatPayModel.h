//
//  WechatPayModel.h
//  Medical
//
//  Created by 张婷 on 16/12/2.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
@interface WechatPayModel : NSObject<WXApiDelegate>
+(void)WeiXinPay:(NSDictionary *)dic;
@end
