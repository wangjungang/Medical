//
//  pharmacyModel.h
//  Medical
//
//  Created by 王俊钢 on 2016/11/14.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface pharmacyModel : NSObject
@property (nonatomic,strong) NSString *pharmacyName;
@property (nonatomic,strong) NSString *pharmacyImageurl;
@property (nonatomic,strong) NSString *pharamcyNumbar;
@property (nonatomic,strong) NSString *pharamcyDistance;
@property (nonatomic,assign) float star;
@property (nonatomic,strong) NSString *pharamcyid;

@end
