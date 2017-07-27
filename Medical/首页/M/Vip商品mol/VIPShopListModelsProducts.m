//
//  VIPShopListModelsProducts.m
//
//  Created by 婷 张 on 16/12/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VIPShopListModelsProducts.h"


NSString *const kVIPShopListModelsProductsDrugName = @"drug_name";
NSString *const kVIPShopListModelsProductsYid = @"yid";
NSString *const kVIPShopListModelsProductsVipstate = @"vipstate";
NSString *const kVIPShopListModelsProductsOldprice = @"oldprice";
NSString *const kVIPShopListModelsProductsHotstate = @"hotstate";
NSString *const kVIPShopListModelsProductsNowprice = @"nowprice";
NSString *const kVIPShopListModelsProductsIntegralstate = @"integralstate";
NSString *const kVIPShopListModelsProductsCid = @"cid";
NSString *const kVIPShopListModelsProductsPictures = @"pictures";
NSString *const kVIPShopListModelsProductsSpecial = @"special";
NSString *const kVIPShopListModelsProductsSpecialstate = @"specialstate";
NSString *const kVIPShopListModelsProductsPtid = @"ptid";
NSString *const kVIPShopListModelsProductsIntegral = @"integral";
NSString *const kVIPShopListModelsProductsInfo = @"info";
NSString *const kVIPShopListModelsProductsEffect = @"effect";
NSString *const kVIPShopListModelsProductsXiaoliang = @"xiaoliang";


@interface VIPShopListModelsProducts ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VIPShopListModelsProducts

@synthesize drugName = _drugName;
@synthesize yid = _yid;
@synthesize vipstate = _vipstate;
@synthesize oldprice = _oldprice;
@synthesize hotstate = _hotstate;
@synthesize nowprice = _nowprice;
@synthesize integralstate = _integralstate;
@synthesize cid = _cid;
@synthesize pictures = _pictures;
@synthesize special = _special;
@synthesize specialstate = _specialstate;
@synthesize ptid = _ptid;
@synthesize integral = _integral;
@synthesize info = _info;
@synthesize effect = _effect;
@synthesize xiaoliang = _xiaoliang;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.drugName = [self objectOrNilForKey:kVIPShopListModelsProductsDrugName fromDictionary:dict];
            self.yid = [self objectOrNilForKey:kVIPShopListModelsProductsYid fromDictionary:dict];
            self.vipstate = [self objectOrNilForKey:kVIPShopListModelsProductsVipstate fromDictionary:dict];
            self.oldprice = [self objectOrNilForKey:kVIPShopListModelsProductsOldprice fromDictionary:dict];
            self.hotstate = [self objectOrNilForKey:kVIPShopListModelsProductsHotstate fromDictionary:dict];
            self.nowprice = [self objectOrNilForKey:kVIPShopListModelsProductsNowprice fromDictionary:dict];
            self.integralstate = [self objectOrNilForKey:kVIPShopListModelsProductsIntegralstate fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kVIPShopListModelsProductsCid fromDictionary:dict];
            self.pictures = [self objectOrNilForKey:kVIPShopListModelsProductsPictures fromDictionary:dict];
            self.special = [self objectOrNilForKey:kVIPShopListModelsProductsSpecial fromDictionary:dict];
            self.specialstate = [self objectOrNilForKey:kVIPShopListModelsProductsSpecialstate fromDictionary:dict];
            self.ptid = [self objectOrNilForKey:kVIPShopListModelsProductsPtid fromDictionary:dict];
            self.integral = [self objectOrNilForKey:kVIPShopListModelsProductsIntegral fromDictionary:dict];
            self.info = [self objectOrNilForKey:kVIPShopListModelsProductsInfo fromDictionary:dict];
            self.effect = [self objectOrNilForKey:kVIPShopListModelsProductsEffect fromDictionary:dict];
            self.xiaoliang = [self objectOrNilForKey:kVIPShopListModelsProductsXiaoliang fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.drugName forKey:kVIPShopListModelsProductsDrugName];
    [mutableDict setValue:self.yid forKey:kVIPShopListModelsProductsYid];
    [mutableDict setValue:self.vipstate forKey:kVIPShopListModelsProductsVipstate];
    [mutableDict setValue:self.oldprice forKey:kVIPShopListModelsProductsOldprice];
    [mutableDict setValue:self.hotstate forKey:kVIPShopListModelsProductsHotstate];
    [mutableDict setValue:self.nowprice forKey:kVIPShopListModelsProductsNowprice];
    [mutableDict setValue:self.integralstate forKey:kVIPShopListModelsProductsIntegralstate];
    [mutableDict setValue:self.cid forKey:kVIPShopListModelsProductsCid];
    [mutableDict setValue:self.pictures forKey:kVIPShopListModelsProductsPictures];
    [mutableDict setValue:self.special forKey:kVIPShopListModelsProductsSpecial];
    [mutableDict setValue:self.specialstate forKey:kVIPShopListModelsProductsSpecialstate];
    [mutableDict setValue:self.ptid forKey:kVIPShopListModelsProductsPtid];
    [mutableDict setValue:self.integral forKey:kVIPShopListModelsProductsIntegral];
    [mutableDict setValue:self.info forKey:kVIPShopListModelsProductsInfo];
    [mutableDict setValue:self.effect forKey:kVIPShopListModelsProductsEffect];
    [mutableDict setValue:self.xiaoliang forKey:kVIPShopListModelsProductsXiaoliang];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.drugName = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsDrugName];
    self.yid = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsYid];
    self.vipstate = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsVipstate];
    self.oldprice = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsOldprice];
    self.hotstate = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsHotstate];
    self.nowprice = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsNowprice];
    self.integralstate = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsIntegralstate];
    self.cid = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsCid];
    self.pictures = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsPictures];
    self.special = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsSpecial];
    self.specialstate = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsSpecialstate];
    self.ptid = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsPtid];
    self.integral = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsIntegral];
    self.info = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsInfo];
    self.effect = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsEffect];
    self.xiaoliang = [aDecoder decodeObjectForKey:kVIPShopListModelsProductsXiaoliang];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_drugName forKey:kVIPShopListModelsProductsDrugName];
    [aCoder encodeObject:_yid forKey:kVIPShopListModelsProductsYid];
    [aCoder encodeObject:_vipstate forKey:kVIPShopListModelsProductsVipstate];
    [aCoder encodeObject:_oldprice forKey:kVIPShopListModelsProductsOldprice];
    [aCoder encodeObject:_hotstate forKey:kVIPShopListModelsProductsHotstate];
    [aCoder encodeObject:_nowprice forKey:kVIPShopListModelsProductsNowprice];
    [aCoder encodeObject:_integralstate forKey:kVIPShopListModelsProductsIntegralstate];
    [aCoder encodeObject:_cid forKey:kVIPShopListModelsProductsCid];
    [aCoder encodeObject:_pictures forKey:kVIPShopListModelsProductsPictures];
    [aCoder encodeObject:_special forKey:kVIPShopListModelsProductsSpecial];
    [aCoder encodeObject:_specialstate forKey:kVIPShopListModelsProductsSpecialstate];
    [aCoder encodeObject:_ptid forKey:kVIPShopListModelsProductsPtid];
    [aCoder encodeObject:_integral forKey:kVIPShopListModelsProductsIntegral];
    [aCoder encodeObject:_info forKey:kVIPShopListModelsProductsInfo];
    [aCoder encodeObject:_effect forKey:kVIPShopListModelsProductsEffect];
    [aCoder encodeObject:_xiaoliang forKey:kVIPShopListModelsProductsXiaoliang];
}

- (id)copyWithZone:(NSZone *)zone
{
    VIPShopListModelsProducts *copy = [[VIPShopListModelsProducts alloc] init];
    
    if (copy) {

        copy.drugName = [self.drugName copyWithZone:zone];
        copy.yid = [self.yid copyWithZone:zone];
        copy.vipstate = [self.vipstate copyWithZone:zone];
        copy.oldprice = [self.oldprice copyWithZone:zone];
        copy.hotstate = [self.hotstate copyWithZone:zone];
        copy.nowprice = [self.nowprice copyWithZone:zone];
        copy.integralstate = [self.integralstate copyWithZone:zone];
        copy.cid = [self.cid copyWithZone:zone];
        copy.pictures = [self.pictures copyWithZone:zone];
        copy.special = [self.special copyWithZone:zone];
        copy.specialstate = [self.specialstate copyWithZone:zone];
        copy.ptid = [self.ptid copyWithZone:zone];
        copy.integral = [self.integral copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.effect = [self.effect copyWithZone:zone];
        copy.xiaoliang = [self.xiaoliang copyWithZone:zone];
    }
    
    return copy;
}


@end
