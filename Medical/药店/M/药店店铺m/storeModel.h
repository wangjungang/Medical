//
//  storeModel.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface storeModel : NSObject
@property (nonatomic,strong) NSString *drugnamestr;
@property (nonatomic,strong) NSString *drugeffectstr;
@property (nonatomic,strong) NSString *picimageurl;
@property (nonatomic,strong) NSString *oldpricestr;
@property (nonatomic,strong) NSString *newpricestr;
@property (nonatomic,strong) NSString *pid;


@property (nonatomic,strong) NSString *gid;

@property (nonatomic,strong) NSString *yid;
@end
