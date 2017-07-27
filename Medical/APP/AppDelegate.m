//
//  AppDelegate.m
//  Medical
//
//  Created by 张婷 on 16/11/7.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomTabbarViewController.h"
//
#import "LogInViewController.h"
//
#import "UMSocialTool.h"
//
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import "LogInViewController.h"
#import "SCGuideViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    LogInViewController *loginVC = [LogInViewController new];
    if (![[NSFileManager defaultManager]fileExistsAtPath:FIRST_LOADING_PATH])
    {
        self.window.rootViewController = [[SCGuideViewController alloc] initWithViewController:loginVC];
    }else{
        if ([AFManager isLogoIn])
        {
            //        [[RongIMKitTool new]instanceRongCloud];
            CustomTabbarViewController *tabbar = [CustomTabbarViewController instanceTabBar];
            self.window.rootViewController = tabbar;
        }else{
            self.window.rootViewController=[[UINavigationController alloc]initWithRootViewController:loginVC];
        }
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings
        settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge)categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        //这里还是原来的代码
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
    [UMSocialTool initUMSocial];
    [WXApi registerApp:@"wx00a45cbc659d8193"];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
        return [WXApi handleOpenURL:url delegate:self];
    }
    return result;
}
 //IOS9之后必须要在这个方法里面写，否则很可能会出现不回调的情况
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
    {
        NSLog(@"urlscheme:%@",url.scheme);
        if ([url.host isEqualToString:@"safepay"]) {
            
            
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
            
            
        }
        if ([url.host isEqualToString:@"platformapi"]) {
            [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result 2=%@",resultDic);
            }];
        }
        if ([url.scheme isEqualToString:@"wx00a45cbc659d8193"]) {
            NSLog(@"WXApi222:-*-*-*-*-*-*-");
            return [WXApi handleOpenURL:url delegate:self];
            
        }
        
        return YES;
        
    }

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp
{
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:
            {
                strMsg = @"支付结果：成功！";
                [[NSNotificationCenter defaultCenter]postNotificationName:@"chongzhichenggong" object:nil];
            }
                break;
            case WXErrCodeCommon:
            { //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                strMsg = @"支付失败";
            }
                break;
            case WXErrCodeUserCancel:
            { //用户点击取消并返回
                strMsg = @"取消支付";
            }
                break;
            case WXErrCodeSentFail:
            { //发送失败
                strMsg = @"发送失败";
            }
                break;
            case WXErrCodeUnsupport:
            { //微信不支持
                strMsg = @"微信不支持";
            }
                break;
            case WXErrCodeAuthDeny:
            { //授权失败
                strMsg = @"授权失败";
            }
                break;
            default:
                break;
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [UIApplication sharedApplication].applicationIconBadgeNumber=[[RCIMClient sharedRCIMClient]getUnreadCount:@[@(ConversationType_PRIVATE)]];
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}


@end
