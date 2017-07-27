//
//  AlipayModels.m
//  Medical
//
//  Created by 张婷 on 16/11/28.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "AlipayModels.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
@implementation AlipayModels
//订单号 商品标题 价格  回调地址
+(void)alipayModelWithOrderid:(NSString *)orderid withName:(NSString *)name withMoney:(NSString *)money withNotify:(NSString *)notify withViewcontroller:(UIViewController *)vc
{
    NSString *appScheme = @"baibuyaolangAlipay";
    NSString *partner = @"2088521241537453";//商户ID
    NSString *seller = @"jiliuwangluo@163.com";
    NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALt8Nvj9ef8EvhEHgKFJHxZeAHH/PkWeblSZKayq1JOblMJHawaj3BUKvG6SjF7bYL9Gag4bXt6cD/BMrpNNh0oQBJHnuwZgRY+w4RMHz9j6rglggWrr7/nBsDCx091aztPDTOFBgV97gP5QlVn1VeEM8t2lREbchFAnxM+Rdkt9AgMBAAECgYAFcmZmdXbF4e1jsUQba3Rrwe9hYHj+rMunyYtcaNokL7DytAB4AOqz8cvnqnpJhzYYWINcRY9MCFyuLowj22zCvVkX54bXDdUim4ul02uu8j7aMPGSzo6QX7+CamtPT4FBhQST8i7NQK8codxg2kQeAQrUDAZwhoJDIQSxPep8AQJBAN7ef6p+HrCYOm+mH0UWvmv+Fmr3mebLcIWeRiYLWmcMlX2QlwsIMbZ+cXTnY3djUfKGTxFa4uqnD+ihtpfqfg0CQQDXWyWEZfhEoF3EsRZOWiFKJJiiNWm994DbR2girWNhZZnu3YE8jsRtTA3Nj3r6DWnWjCQ+mkHvVpO0Z6JOBRcxAkBZ2w1P+Q94lbehwjGDUnst4UC6md+EDOvuA3U264bkW09+U6iCOyiH8ozd3FjfDr1AceQ5FBK/FuI0IdcTguiVAkEAhw8Nl1wP+JIOXIWm9JqH2CTdaJVQ7KdlM6AzydOtyO5cPLbED0OGIvmYintaZ6mz367iKDS79yr31SNNYdrFcQJBAJa0g9PfPVRinopDRdD/25CKtjYVySDyYE+xpeMo/O+btZFgxc0Mnyg5EjNpZjUIbz+rz4Dr+Vuid5yZXnsH0Bc=";
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [NSString stringWithFormat:@"%@",orderid] ;//订单ID（由商家自行制定）
    order.productName = name ; //商品标题
    //     order.productDescription = @"测试" ; //商品描述
    order.amount = [NSString stringWithFormat:@"%@", money];
    order.notifyURL =  notify;//回调地址
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    order.service = @"mobile.securitypay.pay";//固定值
    NSString *orderSpec = [order description];
    
    id <DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        NSLog(@"******%@",orderString);
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //【callback 处理支付结果】
            NSLog(@"reslut = %@",resultDic);
            
            if ([resultDic[@"resultStatus"] isEqualToString:@"4000"]) {
                
                
                
            }
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"chongzhichenggong" object:nil];
//                [vc.navigationController pushViewController:vc animated:YES];
            }
            if ([resultDic[@"resultStatus"] isEqualToString:@"8000"]) {
                
                if ([resultDic[@"resultStatus"] isEqualToString:@"6002"]) {
                    
                }
            }
            
        }];
    }

}
@end
