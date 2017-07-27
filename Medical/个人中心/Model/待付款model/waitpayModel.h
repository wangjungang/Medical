//
//  waitpayModel.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/23.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface waitpayModel : NSObject
@property (nonatomic,strong) NSString *dingdanid;
@property (nonatomic,strong) NSString *addressid;
@property (nonatomic,strong) NSString *pid;
@property (nonatomic,strong) NSString *sprice;
@property (nonatomic,strong) NSString *number;
@property (nonatomic,strong) NSString *totalprice;
@property (nonatomic,strong) NSString *drugname;
@property (nonatomic,strong) NSString *durgpicture;
@property (nonatomic,strong) NSString *shoppicture;
@property (nonatomic,strong) NSString *effect;
@property (nonatomic,strong) NSString *shopname;

@property (nonatomic,strong) NSString *orderid;
@property(assign,nonatomic) BOOL selectState;//是否选中状态
@end
