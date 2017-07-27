//
//  shopcarModel.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shopcarModel : NSObject
@property (nonatomic,strong) NSString *shopcarimageurl;
@property (nonatomic,strong) NSString *durgname;
@property (nonatomic,strong) NSString *durgnumber;
@property (nonatomic,strong) NSString *durgprice;

@property (nonatomic,strong) NSString *olddrugpirce;
@property (nonatomic,strong) NSString *drugpid;
@property (nonatomic,strong) NSString *shopcarid;
@property (nonatomic,strong) NSString *shopyid;
@property (nonatomic,strong) NSString *newprice;



//view
@property (nonatomic,strong) NSString *zongprice;
@property (nonatomic,strong) NSString *oldzongprice;

@property(assign,nonatomic)BOOL selectState;//是否选中状态
@end
