//
//  settleModel.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface settleModel : NSObject
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *area;
@property (nonatomic,strong) NSString *statusstr;


//cell model
@property (nonatomic,strong) NSString *drugshopimageurl;
@property (nonatomic,strong) NSString *drugshopname;
@property (nonatomic,strong) NSString *drugname;
@property (nonatomic,strong) NSString *drugnumber;
@property (nonatomic,strong) NSString *drugprice;
@property (nonatomic,strong) NSString *vipstr;
@property (nonatomic,strong) NSString *reduce;
@property (nonatomic,strong) NSString *discount;


//价格model
//总价
@property (nonatomic,strong) NSString *totalprice;
//优惠减少价格
@property (nonatomic,strong) NSString *preferentialprice;
//实际价格
@property (nonatomic,strong) NSString *actual;
@end
