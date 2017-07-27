//
//  VIPShopListModelsProducts.h
//
//  Created by 婷 张 on 16/12/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VIPShopListModelsProducts : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *drugName;
@property (nonatomic, strong) NSString *yid;
@property (nonatomic, strong) NSString *vipstate;
@property (nonatomic, strong) NSString *oldprice;
@property (nonatomic, strong) NSString *hotstate;
@property (nonatomic, strong) NSString *nowprice;
@property (nonatomic, strong) NSString *integralstate;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *pictures;
@property (nonatomic, strong) NSString *special;
@property (nonatomic, strong) NSString *specialstate;
@property (nonatomic, strong) NSString *ptid;
@property (nonatomic, strong) NSString *integral;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *effect;
@property (nonatomic, strong) NSString *xiaoliang;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
