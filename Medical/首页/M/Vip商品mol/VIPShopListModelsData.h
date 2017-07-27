//
//  VIPShopListModelsData.h
//
//  Created by 婷 张 on 16/12/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VIPShopListModelsData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *scale;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *typeid;
@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
