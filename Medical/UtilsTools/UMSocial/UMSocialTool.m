//
//  UMSocialTool.m
//  text
//
//  Created by 李壮 on 16/7/23.
//  Copyright © 2016年 李壮. All rights reserved.
//

#import "UMSocialTool.h"
#import <UMSocialQQHandler.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialSinaSSOHandler.h>
#import <SDWebImage/UIImage+GIF.h>
#define s_UMSocialSDK_id        @"583d6a4199f0c768dc0011f3"

#define s_sina_wb_Key           @"1757302752"   // 889693041
#define s_sina_wb_Secret        @"d2ae46b7e3efa322cea86905ad363f72"

#define s_sina_wb_redirectUri   @"http://sns.whalecloud.com/sina2/callback"


#define s_qq_id                 @"1105854184"             //
#define s_qq_Secret             @"7C0EY0vid48acJlz"             //

#define s_weixin_id             @"wx00a45cbc659d8193"
#define s_weixin_Secret         @"06f9f1a777cbcb6842d5c433e98e1acc"

@implementation UMSocialTool
/// 初始化UMSocial
+(void) initUMSocial
{
    [UMSocialData setAppKey:s_UMSocialSDK_id];
    //设置微信 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialWechatHandler setWXAppId:s_weixin_id appSecret:s_weixin_Secret url:@"http://www.umeng.com/social"];
    
    //设置手机QQ的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:s_qq_id appKey:s_qq_Secret url:@"http://www.umeng.com/social"];
//
//    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:s_sina_wb_Key
//                                              secret:s_sina_wb_Secret
//                                         RedirectURL:s_sina_wb_redirectUri];
}
/// 分享菜单分享
+(void) shareTest:(id)view uid:(NSString *)uid pic:(UIImage*)image
{
    [UMSocialData defaultData].extConfig.qqData.url=[NSString stringWithFormat:@"http://139.224.43.42/medical/index.php/Admin/H5/interactionnull?id=%@",uid];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"http://139.224.43.42/medical/index.php/Admin/H5/interactionnull?id=%@",uid];
    [UMSocialData defaultData].extConfig.title = @"百步药郎 - - 生活服务全打通，使用更轻松。";
    [UMSocialSnsService presentSnsIconSheetView:view
                                         appKey:s_UMSocialSDK_id
                                      shareText:@"提供生活消费最后100米服务，互动社区、合作医院、国医堂、积分换购......"
                                     shareImage:image
                                shareToSnsNames:                          @[UMShareToWechatSession,UMShareToQQ,UMShareToWechatTimeline]
                                       delegate:view];
//    ,UMShareToSina,UMShareToQQ,UMShareToQzone
}
/// 登录
#pragma mark-
#pragma mark登录
+(void) doLogin:(UIViewController*)vc Accounttype:(NSString*)userAccount callBlock: (void(^)(NSDictionary *dict))myBlock;
{
//    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:userAccount];
//    
//    snsPlatform.loginClickHandler(vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
//        
//        if (response.responseCode == UMSResponseCodeSuccess) {
//            
////            NSDictionary *dict = [UMSocialAccountManager socialAccountDictionary];
//            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
//                        NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@,\n thirdPlatformUserProfile = %@,\n thirdPlatformResponse = %@ \n, message = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId, response.thirdPlatformUserProfile, response.thirdPlatformResponse, response.message);
//        
//            NSDictionary *dic =[[NSDictionary alloc] initWithObjectsAndKeys:snsAccount.accessToken,@"access_token",[response.thirdPlatformUserProfile objectForKey:@"openid"],@"openid", nil];
//            myBlock(dic);
//        }
//        
//    });
}
+(void)cancelled:(NSString*)userAccount
{
//    [[UMSocialDataService defaultDataService] requestUnOauthWithType:userAccount  completion:^(UMSocialResponseEntity *response){
//        
//    }];
}
@end
