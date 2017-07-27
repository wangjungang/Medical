//
//  Header-Ting.h
//  Medical
//
//  Created by 李壮 on 2016/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#ifndef Header_Ting_h
#define Header_Ting_h


#endif /* Header_Ting_h */

#import "Model-Ting.h"
//个人信息修改POST
#define Update_PersonalInfo_URL @"http://139.224.43.42/medical/index.php/Admin/Api/userUpdate"
//密码修改
#define Update_Password_URL @"http://139.224.43.42/medical/index.php/Admin/Api/userPassUpdate"
//上传图片POST
#define Post_Image_URL @"http://139.224.43.42/medical/index.php/Admin/Api/UploadsIos"

//医院列表GET
#define Hospital_List_URL @"http://139.224.43.42/medical/index.php/Admin/AppApi/BusinessList?page=%ld&num=%@"
//科室分类
#define Medical_Office_URL @"http://139.224.43.42/medical/index.php/Admin/AppApi/departmentList?bid=%@"
//科室详情
#define Keshi_HTML5_Details_URL @"http://139.224.43.42/medical/index.php/Admin/H5/office?id=%@"
//医院详情GET
#define Hospital_Details_URL @"http://139.224.43.42/medical/index.php/Admin/H5/hospiatl?id=%@"

//对症下药
#define Duizheng_HTML_URL @"http://139.224.43.42/medical/index.php/Dzxylb/index"

//对症下药分类列表
#define Duizheng_FenleiList_URL @"http://139.224.43.42/medical/index.php/Admin/Api/typeList"

//健康小贴士
#define Health_Tips_URL @"http://139.224.43.42/medical/index.php/Admin/Apitwo/knowledgelist"

//支付宝支付
#define Alipay_URL @"http://139.224.43.42/medical/index.php/Admin/Api/alipay?uid=%@&money=%@"

//搜索
#define Search_URL @"http://139.224.43.42/medical/index.php/Admin/Api/search?type=%@&keywords=%@&page=%@&num=%@&uid=%@&lon=%f&lat=%f"
