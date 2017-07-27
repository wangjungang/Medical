//
//  ListShopIntegralData.m
//
//  Created by 壮 李 on 2016/11/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ListShopIntegralData.h"


NSString *const kListShopIntegralDataDrugName = @"drug_name";
NSString *const kListShopIntegralDataYid = @"yid";
NSString *const kListShopIntegralDataVipstate = @"vipstate";
NSString *const kListShopIntegralDataOldprice = @"oldprice";
NSString *const kListShopIntegralDataHotstate = @"hotstate";
NSString *const kListShopIntegralDataNowprice = @"nowprice";
NSString *const kListShopIntegralDataIntegralstate = @"integralstate";
NSString *const kListShopIntegralDataCid = @"cid";
NSString *const kListShopIntegralDataPictures = @"pictures";
NSString *const kListShopIntegralDataSpecial = @"special";
NSString *const kListShopIntegralDataSpecialstate = @"specialstate";
NSString *const kListShopIntegralDataPtid = @"ptid";
NSString *const kListShopIntegralDataIntegral = @"integral";
NSString *const kListShopIntegralDataInfo = @"info";
NSString *const kListShopIntegralDataEffect = @"effect";


@interface ListShopIntegralData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ListShopIntegralData

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
            self.drugName = [self objectOrNilForKey:kListShopIntegralDataDrugName fromDictionary:dict];
            self.yid = [self objectOrNilForKey:kListShopIntegralDataYid fromDictionary:dict];
            self.vipstate = [self objectOrNilForKey:kListShopIntegralDataVipstate fromDictionary:dict];
            self.oldprice = [self objectOrNilForKey:kListShopIntegralDataOldprice fromDictionary:dict];
            self.hotstate = [self objectOrNilForKey:kListShopIntegralDataHotstate fromDictionary:dict];
            self.nowprice = [self objectOrNilForKey:kListShopIntegralDataNowprice fromDictionary:dict];
            self.integralstate = [self objectOrNilForKey:kListShopIntegralDataIntegralstate fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kListShopIntegralDataCid fromDictionary:dict];
            self.pictures = [self objectOrNilForKey:kListShopIntegralDataPictures fromDictionary:dict];
            self.special = [self objectOrNilForKey:kListShopIntegralDataSpecial fromDictionary:dict];
            self.specialstate = [self objectOrNilForKey:kListShopIntegralDataSpecialstate fromDictionary:dict];
            self.ptid = [self objectOrNilForKey:kListShopIntegralDataPtid fromDictionary:dict];
            self.integral = [self objectOrNilForKey:kListShopIntegralDataIntegral fromDictionary:dict];
            self.info = [self objectOrNilForKey:kListShopIntegralDataInfo fromDictionary:dict];
            self.effect = [self objectOrNilForKey:kListShopIntegralDataEffect fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.drugName forKey:kListShopIntegralDataDrugName];
    [mutableDict setValue:self.yid forKey:kListShopIntegralDataYid];
    [mutableDict setValue:self.vipstate forKey:kListShopIntegralDataVipstate];
    [mutableDict setValue:self.oldprice forKey:kListShopIntegralDataOldprice];
    [mutableDict setValue:self.hotstate forKey:kListShopIntegralDataHotstate];
    [mutableDict setValue:self.nowprice forKey:kListShopIntegralDataNowprice];
    [mutableDict setValue:self.integralstate forKey:kListShopIntegralDataIntegralstate];
    [mutableDict setValue:self.cid forKey:kListShopIntegralDataCid];
    [mutableDict setValue:self.pictures forKey:kListShopIntegralDataPictures];
    [mutableDict setValue:self.special forKey:kListShopIntegralDataSpecial];
    [mutableDict setValue:self.specialstate forKey:kListShopIntegralDataSpecialstate];
    [mutableDict setValue:self.ptid forKey:kListShopIntegralDataPtid];
    [mutableDict setValue:self.integral forKey:kListShopIntegralDataIntegral];
    [mutableDict setValue:self.info forKey:kListShopIntegralDataInfo];
    [mutableDict setValue:self.effect forKey:kListShopIntegralDataEffect];

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

    self.drugName = [aDecoder decodeObjectForKey:kListShopIntegralDataDrugName];
    self.yid = [aDecoder decodeObjectForKey:kListShopIntegralDataYid];
    self.vipstate = [aDecoder decodeObjectForKey:kListShopIntegralDataVipstate];
    self.oldprice = [aDecoder decodeObjectForKey:kListShopIntegralDataOldprice];
    self.hotstate = [aDecoder decodeObjectForKey:kListShopIntegralDataHotstate];
    self.nowprice = [aDecoder decodeObjectForKey:kListShopIntegralDataNowprice];
    self.integralstate = [aDecoder decodeObjectForKey:kListShopIntegralDataIntegralstate];
    self.cid = [aDecoder decodeObjectForKey:kListShopIntegralDataCid];
    self.pictures = [aDecoder decodeObjectForKey:kListShopIntegralDataPictures];
    self.special = [aDecoder decodeObjectForKey:kListShopIntegralDataSpecial];
    self.specialstate = [aDecoder decodeObjectForKey:kListShopIntegralDataSpecialstate];
    self.ptid = [aDecoder decodeObjectForKey:kListShopIntegralDataPtid];
    self.integral = [aDecoder decodeObjectForKey:kListShopIntegralDataIntegral];
    self.info = [aDecoder decodeObjectForKey:kListShopIntegralDataInfo];
    self.effect = [aDecoder decodeObjectForKey:kListShopIntegralDataEffect];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_drugName forKey:kListShopIntegralDataDrugName];
    [aCoder encodeObject:_yid forKey:kListShopIntegralDataYid];
    [aCoder encodeObject:_vipstate forKey:kListShopIntegralDataVipstate];
    [aCoder encodeObject:_oldprice forKey:kListShopIntegralDataOldprice];
    [aCoder encodeObject:_hotstate forKey:kListShopIntegralDataHotstate];
    [aCoder encodeObject:_nowprice forKey:kListShopIntegralDataNowprice];
    [aCoder encodeObject:_integralstate forKey:kListShopIntegralDataIntegralstate];
    [aCoder encodeObject:_cid forKey:kListShopIntegralDataCid];
    [aCoder encodeObject:_pictures forKey:kListShopIntegralDataPictures];
    [aCoder encodeObject:_special forKey:kListShopIntegralDataSpecial];
    [aCoder encodeObject:_specialstate forKey:kListShopIntegralDataSpecialstate];
    [aCoder encodeObject:_ptid forKey:kListShopIntegralDataPtid];
    [aCoder encodeObject:_integral forKey:kListShopIntegralDataIntegral];
    [aCoder encodeObject:_info forKey:kListShopIntegralDataInfo];
    [aCoder encodeObject:_effect forKey:kListShopIntegralDataEffect];
}

- (id)copyWithZone:(NSZone *)zone
{
    ListShopIntegralData *copy = [[ListShopIntegralData alloc] init];
    
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
    }
    
    return copy;
}


@end
