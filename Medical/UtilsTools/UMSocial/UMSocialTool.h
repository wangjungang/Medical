//
//  UMSocialTool.h
//  text
//
//  Created by 李壮 on 16/7/23.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UMSocial.h"
@interface UMSocialTool : NSObject

//typedef void(^myBlock)(NSDictionary* CallBack);

/// 初始化UMSocial
+(void) initUMSocial;

/// 分享菜单分享
+(void) shareTest:(id)view uid:(NSString *)uid pic:(UIImage*)image;

/// 登录
+(void) doLogin:(UIViewController*)vc Accounttype:(NSString*)userAccount callBlock: (void(^)(NSDictionary *dict))myBlock;
/// 注销登录
+(void)cancelled:(NSString*)userAccount;
@end
/*
 2.使用，初始化
 3.QQ & WeiXin 配置URL Types
 WeiXin ->  s_weixin_id(url scheme)
 QQ     ->  s_QQ_id转成十六进制(url scheme)
 
 在URL Types中添加QQ的AppID，其格式为：”QQ” ＋ AppId的16进制（如果appId转换的16进制数不够8位则在前面补0，如转换的是：5FB8B52，则最终填入为：QQ05FB8B52 注意：转换后的字母要大写） 转换16进制的方法：
 // 转16进制代码 = 终端中
 echo 'ibase=10;obase=16;1104991628' |bc
*/
