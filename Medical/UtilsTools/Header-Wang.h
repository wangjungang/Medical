//
//  Header-Wang.h
//  Medical
//
//  Created by 李壮 on 2016/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#ifndef Header_Wang_h
#define Header_Wang_h


#endif /* Header_Wang_h */
#import "Model-Wang.h"
#import "AFManager.h"

//地址添加
#define AddressAdd_URL @"http://139.224.43.42/medical/index.php/Admin/Api/addressAdd"
//地址列表展示
#define AddressListURL @"http://139.224.43.42/medical/index.php/Admin/Api/addressList?uid=%@"
//设置默认地址
#define AddressSetURL @"http://139.224.43.42/medical/index.php/Admin/Api/setAddress?uid=%@&id=%@"
//修改地址
#define AddressUpdateURL @"http://139.224.43.42/medical/index.php/Admin/Api/updateAddress"
//删除地址
#define delAddressURL  @"http://139.224.43.42/medical/index.php/Admin/Api/delAddress?uid=%@&id=%@"
//购物车列表
#define shopcarlist @"http://139.224.43.42/medical/index.php/Admin/Apitwo/cartlist?uid=%@"
//购物车添加
#define addcart @"http://139.224.43.42/medical/index.php/Admin/Apitwo/addcart"
//删除购物车
#define delshopcar @"http://139.224.43.42/medical/index.php/Admin/Apitwo/delcart?id=%@&uid=%@"
//添加订单
#define addorder @"http://139.224.43.42/medical/index.php/Admin/Apitwo/addorder"

//药店首页
#define houstlist @"http://139.224.43.42/medical/index.php/Admin/Api/houseList?lon=%f&lat=%f&page=%ld&num=%ld"
//药店分类列表
#define pactegorylist  @"http://139.224.43.42/medical/index.php/Admin/Apitwo/pcategorylist"
//药品列表
#define productlist @"http://139.224.43.42/medical/index.php/Admin/Api/product?yid=%@&type=%@&cid=%@&order=%@"
//未支付订单
#define weizhifuorder  @"http://139.224.43.42/medical/index.php/Admin/Apitwo/weizhifuorder?ouid=%@&num=%@&page=%ld"

//药品详情
#define detial @"http://139.224.43.42/medical/index.php/Admin/Dzxylb/detial?id=%@&lon=%f&lat=%f"

//国医堂列表
#define guoyitang @"http://139.224.43.42/medical/index.php/Admin/AppApi/guoyitang"

//订单列表
#define orderlist @"http://139.224.43.42/medical/index.php/Admin/Apitwo/orderlist?ouid=%@&order=%@"
//购物车number
#define editcart @"http://139.224.43.42/medical/index.php/Admin/Apitwo/editcart"

//国医堂药品详情
#define guoDetial @"http://139.224.43.42/medical/index.php/Admin/Dzxylb/detial?gid=%@"

//订单付款
#define orderbuy @"http://139.224.43.42/medical/index.php/Admin/Apitwo/orderbuy?uid=%@&order=%@"
//立即购买
#define buyorder @"http://139.224.43.42/medical/index.php/Admin/Apitwo/buyorder"

//删除订单
#define delOrder @"http://139.224.43.42/medical/index.php/Admin/AppApi/delOrder?id=%@"

//未付款继续支付
#define nopayorder @"http://139.224.43.42/medical/index.php/Admin/Apitwo/nopayorder?oid=%@"
