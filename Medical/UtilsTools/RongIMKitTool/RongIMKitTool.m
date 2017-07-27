//
//  RongIMKitTool.m
//  Medical
//
//  Created by 李壮 on 2016/11/29.
//  Copyright © 2016年 张婷. All rights reserved.
//
#define RONG_APPKEY @"z3v5yqkbzc1l0"

#import "RongIMKitTool.h"
#import "UserHeaderBase.h"
#import "UserHeaderUser.h"

@interface RongIMKitTool ()
@end
@implementation RongIMKitTool
- (void)instanceRongCloud
{
    [[RCIM sharedRCIM]initWithAppKey:RONG_APPKEY];
    [RCIM sharedRCIM].disableMessageNotificaiton=NO;
    [RCIM sharedRCIM].disableMessageAlertSound=NO;
//    [self isGetUserHeader];
    if ([self isGetRongToken])
    {
        [self linkRongSever];
    }
}
-(BOOL)isGetRongToken
{
    if ( ![[NSFileManager defaultManager]fileExistsAtPath:RONG_TOKEN])
    {
        NSString*uid=[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil];
        [AFManager getReqURL:[NSString stringWithFormat:GET_RONG_TOKEN_RUL,uid] block:^(id infor) {
            if ([[infor objectForKey:@"code"]integerValue]==200)
            {
                [[infor objectForKey:@"token"]writeToFile:RONG_TOKEN atomically:YES encoding:NSUTF8StringEncoding error:nil];
                [self linkRongSever];
            }
        } errorblock:^(NSError *error)
        {
            NSLog(@"error");
        }];
    }
     else
    {
        return YES;
    }
    return NO;
}
-(void)linkRongSever
{
    NSString*token=[NSString stringWithContentsOfFile:RONG_TOKEN encoding:NSUTF8StringEncoding error:nil];
    [[RCIM sharedRCIM]connectWithToken:token success:^(NSString *userId)
     {
         [[NSUserDefaults standardUserDefaults]setObject:userId forKey:@"rongUserId"];
         [[NSUserDefaults standardUserDefaults]synchronize];
     } error:^(RCConnectErrorCode status)
     {
         
     } tokenIncorrect:^{
         
     }];
}
- (BOOL)isGetUserHeader
{
    if (![[NSFileManager defaultManager]fileExistsAtPath:RONG_USER_INFO])
    {
        [AFManager getReqURL:[NSString stringWithFormat:@"http://139.224.43.42/medical/index.php/Admin/Api/getShow?uid=%@",[NSString stringWithContentsOfFile:USER_ID encoding:NSUTF8StringEncoding error:nil]] block:^(id infor)
         {
             UserHeaderBase*headerUser=[UserHeaderBase modelObjectWithDictionary:infor];
             [NSKeyedArchiver archiveRootObject:headerUser.user toFile:RONG_USER_INFO];
         } errorblock:^(NSError *error)
         {
             
         }];
    }else
    {
        return YES;
    }
    return NO;
}
@end
