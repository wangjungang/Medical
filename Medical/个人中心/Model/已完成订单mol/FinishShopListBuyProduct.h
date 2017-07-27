//
//  FinishShopListBuyProduct.h
//
//  Created by 婷 张 on 16/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FinishShopListBuyProduct : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *typeid;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *productIdentifier;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *integral;
@property (nonatomic, strong) NSString *gname;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *vipstate;
@property (nonatomic, strong) NSString *pictures;
@property (nonatomic, strong) NSString *gid;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *sprice;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *drugName;
@property (nonatomic, strong) NSString *oid;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, strong) NSString *yid;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *hotstate;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *effect;
@property (nonatomic, strong) NSString *special;
@property (nonatomic, strong) NSString *oldprice;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *specialstate;
@property (nonatomic, strong) NSString *integralstate;
@property (nonatomic, strong) NSString *nowprice;
@property (nonatomic, strong) NSString *xiaoliang;
@property (nonatomic, strong) NSString *ptid;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *scale;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
