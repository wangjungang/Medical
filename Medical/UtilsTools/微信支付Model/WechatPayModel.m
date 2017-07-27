//
//  WechatPayModel.m
//  Medical
//
//  Created by 张婷 on 16/12/2.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "WechatPayModel.h"

@implementation WechatPayModel
+(void)WeiXinPay:(NSDictionary *)dic
{
    
    NSString * timeStamp=dic[@"timestamp"];
    PayReq * req=[[PayReq alloc]init];
    req.partnerId=[dic objectForKey:@"partnerid"];
    req.prepayId=[dic objectForKey:@"prepayid"];
    req.nonceStr=[dic objectForKey:@"noncestr"];
    req.timeStamp=[timeStamp intValue];
    req.package=@"Sign=WXPay";
    req.sign=[dic objectForKey:@"sign"];
    [WXApi sendReq:req];
    //日志输出
    NSLog(@"appid=%@\npartnerid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dic objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
}

@end
