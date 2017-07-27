//
//  Header-Zhuang.h
//  Medical
//
//  Created by 李壮 on 2016/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#ifndef Header_Zhuang_h
#define Header_Zhuang_h

#endif /* Header_Zhuang_h */
#import "Model-Zhuang.h"
#import "AFManager.h"
#define USER_ID [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/UID.plist"]
#define RONG_TOKEN [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/RongIMKit.plist"] 
#define RONG_USER_INFO [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/RongUserInfo.plist"] 
///获取融云token令牌
#define GET_RONG_TOKEN_RUL @"http://139.224.43.42/medical/index.php/Admin/Api/getTokens?uid=%@"
//获取验证码
#define CODE_URL     @"http://139.224.43.42/medical/index.php/Admin/Api/getCode?phone=%@"
//注册
#define REGISTER_URL @"http://139.224.43.42/medical/index.php/Admin/Api/reg"
///登录
#define LOG_IN_URL @"http://139.224.43.42/medical/index.php/Admin/Api/login"
///忘记密码
#define FORGET_PSW_URL @"http://139.224.43.42/medical/index.php/Admin/Api/updatePassword"
///个人中心
//意见反馈分类列表
#define FEED_BACK_CLASS_URL @"http://139.224.43.42/medical/index.php/Admin/Api/feedbackClass"
#define FEED_BACK_ADD_URL @"http://139.224.43.42/medical/index.php/Admin/Api/feedbackAdd"
//病例列表
#define CASE_LIST_URL @"http://139.224.43.42/medical/index.php/Admin/Api/diseaseList?uid=%@"
//编辑病例
#define UPDATE_CASE_URL @"http://139.224.43.42/medical/index.php/Admin/Api/diseaseUpdate"
//删除病例
#define DELEGATE_CASE_URL @"http://139.224.43.42/medical/index.php/Admin/Api/disseaseDel?uid=%@&bid=%@"
//添加病例
#define ADD_CASE_URL @"http://139.224.43.42/medical/index.php/Admin/Api/diseaseAdd"
///已完成历史订单
#define FINISH_HISTORY_LIST_PAY_URL @"http://139.224.43.42/medical/index.php/Admin/Apitwo/yizhifuorder?ouid=%@&page=%ld&num=%@"
//常见问题
#define PROBLEM_URL @"http://139.224.43.42/medical/index.php/Admin/Api/questionList"
#define USER_INFO_RUL @"http://139.224.43.42/medical/index.php/Admin/Api/display?uid=%@"
#define EDIT_PHONE_URL @"http://139.224.43.42/medical/index.php/Admin/Api/updatePhoneIos"
//诊所
///诊所列表
#define GET_CLINIC_LIST_URL @"http://139.224.43.42/medical/index.php/Admin/AppApi/zhensuo?page=%ld&num=%@&lat=%f&lon=%f"
///预约诊所
#define WALK_CLINIC_URL @"http://139.224.43.42/medical/index.php/Admin/Apitwo/addclinic"
///轮播图
#define HEARD_IMAGE_URL @"http://139.224.43.42/medical/index.php/Admin/AppApi/getPicture?typeid=%@"
///诊所详情
#define CLINIC_DETAIL_URL @"http://139.224.43.42/medical/index.php/Admin/H5/details?id=%@"
//首页
///科室详情
#define DEPARTMENT_DETAIL_URL @"http://139.224.43.42/medical/index.php/Admin/H5/office?id=%@"
///合作商家
#define JOIN_HANDS_SHOP_URL @"http://139.224.43.42/medical/index.php/Admin/Api/merchantsList?page=%ld&num=%@"
///药店详情
#define SHOP_DETAIL_URL @"http://139.224.43.42/medical/index.php/Admin/H5/drugstore?id=%@"
///热门药品列表
#define HOT_SHOP_LIST_URL @"http://139.224.43.42/medical/index.php/Admin/Apitwo/hotlist?page=%ld&num=%@"
///商家预约
#define SHOP_ABOUT_URL @"http://139.224.43.42/medical/index.php/Admin/Apitwo/addmerchant"
///积分商品列表
#define INTEGRSL_SHOP_LIST_URL @"http://139.224.43.42/medical/index.php/Admin/Apitwo/integrallist?page=%ld&num=%@"
///积分换购生成订单接口
#define INTEGRSL_SURE_BUY_URL @"http://139.224.43.42/medical/index.php/Admin/Api/IntegralFor?uid=%@&ptid=%@"
///积分购买接口
#define INTEGRAL_BUY_URL @"http://139.224.43.42/medical/index.php/Admin/Api/nowChange"
///互动社区社区图片
#define COMMUNITY_IMAGE_URL @"http://139.224.43.42/medical/index.php/Admin/Api/getPic?id=%@"
///会员商品
#define VIP_SHOP_LIST_URL @"http://139.224.43.42/medical/index.php/Admin/Apitwo/vipslist"
///特价商品
#define BARGAINS_SHOP_URL @"http://139.224.43.42/medical/index.php/Admin/Apitwo/vipslist"
