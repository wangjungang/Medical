//
//  HotListData.m
//
//  Created by 壮 李 on 2016/11/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HotListData.h"


NSString *const kHotListDataDrugName = @"drug_name";
NSString *const kHotListDataYid = @"yid";
NSString *const kHotListDataVipstate = @"vipstate";
NSString *const kHotListDataOldprice = @"oldprice";
NSString *const kHotListDataHotstate = @"hotstate";
NSString *const kHotListDataNowprice = @"nowprice";
NSString *const kHotListDataIntegralstate = @"integralstate";
NSString *const kHotListDataCid = @"cid";
NSString *const kHotListDataPictures = @"pictures";
NSString *const kHotListDataSpecial = @"special";
NSString *const kHotListDataSpecialstate = @"specialstate";
NSString *const kHotListDataPtid = @"ptid";
NSString *const kHotListDataIntegral = @"integral";
NSString *const kHotListDataInfo = @"info";
NSString *const kHotListDataEffect = @"effect";


@interface HotListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HotListData

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
            self.drugName = [self objectOrNilForKey:kHotListDataDrugName fromDictionary:dict];
            self.yid = [self objectOrNilForKey:kHotListDataYid fromDictionary:dict];
            self.vipstate = [self objectOrNilForKey:kHotListDataVipstate fromDictionary:dict];
            self.oldprice = [self objectOrNilForKey:kHotListDataOldprice fromDictionary:dict];
            self.hotstate = [self objectOrNilForKey:kHotListDataHotstate fromDictionary:dict];
            self.nowprice = [self objectOrNilForKey:kHotListDataNowprice fromDictionary:dict];
            self.integralstate = [self objectOrNilForKey:kHotListDataIntegralstate fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kHotListDataCid fromDictionary:dict];
            self.pictures = [self objectOrNilForKey:kHotListDataPictures fromDictionary:dict];
            self.special = [self objectOrNilForKey:kHotListDataSpecial fromDictionary:dict];
            self.specialstate = [self objectOrNilForKey:kHotListDataSpecialstate fromDictionary:dict];
            self.ptid = [self objectOrNilForKey:kHotListDataPtid fromDictionary:dict];
            self.integral = [self objectOrNilForKey:kHotListDataIntegral fromDictionary:dict];
            self.info = [self objectOrNilForKey:kHotListDataInfo fromDictionary:dict];
            self.effect = [self objectOrNilForKey:kHotListDataEffect fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.drugName forKey:kHotListDataDrugName];
    [mutableDict setValue:self.yid forKey:kHotListDataYid];
    [mutableDict setValue:self.vipstate forKey:kHotListDataVipstate];
    [mutableDict setValue:self.oldprice forKey:kHotListDataOldprice];
    [mutableDict setValue:self.hotstate forKey:kHotListDataHotstate];
    [mutableDict setValue:self.nowprice forKey:kHotListDataNowprice];
    [mutableDict setValue:self.integralstate forKey:kHotListDataIntegralstate];
    [mutableDict setValue:self.cid forKey:kHotListDataCid];
    [mutableDict setValue:self.pictures forKey:kHotListDataPictures];
    [mutableDict setValue:self.special forKey:kHotListDataSpecial];
    [mutableDict setValue:self.specialstate forKey:kHotListDataSpecialstate];
    [mutableDict setValue:self.ptid forKey:kHotListDataPtid];
    [mutableDict setValue:self.integral forKey:kHotListDataIntegral];
    [mutableDict setValue:self.info forKey:kHotListDataInfo];
    [mutableDict setValue:self.effect forKey:kHotListDataEffect];

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

    self.drugName = [aDecoder decodeObjectForKey:kHotListDataDrugName];
    self.yid = [aDecoder decodeObjectForKey:kHotListDataYid];
    self.vipstate = [aDecoder decodeObjectForKey:kHotListDataVipstate];
    self.oldprice = [aDecoder decodeObjectForKey:kHotListDataOldprice];
    self.hotstate = [aDecoder decodeObjectForKey:kHotListDataHotstate];
    self.nowprice = [aDecoder decodeObjectForKey:kHotListDataNowprice];
    self.integralstate = [aDecoder decodeObjectForKey:kHotListDataIntegralstate];
    self.cid = [aDecoder decodeObjectForKey:kHotListDataCid];
    self.pictures = [aDecoder decodeObjectForKey:kHotListDataPictures];
    self.special = [aDecoder decodeObjectForKey:kHotListDataSpecial];
    self.specialstate = [aDecoder decodeObjectForKey:kHotListDataSpecialstate];
    self.ptid = [aDecoder decodeObjectForKey:kHotListDataPtid];
    self.integral = [aDecoder decodeObjectForKey:kHotListDataIntegral];
    self.info = [aDecoder decodeObjectForKey:kHotListDataInfo];
    self.effect = [aDecoder decodeObjectForKey:kHotListDataEffect];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_drugName forKey:kHotListDataDrugName];
    [aCoder encodeObject:_yid forKey:kHotListDataYid];
    [aCoder encodeObject:_vipstate forKey:kHotListDataVipstate];
    [aCoder encodeObject:_oldprice forKey:kHotListDataOldprice];
    [aCoder encodeObject:_hotstate forKey:kHotListDataHotstate];
    [aCoder encodeObject:_nowprice forKey:kHotListDataNowprice];
    [aCoder encodeObject:_integralstate forKey:kHotListDataIntegralstate];
    [aCoder encodeObject:_cid forKey:kHotListDataCid];
    [aCoder encodeObject:_pictures forKey:kHotListDataPictures];
    [aCoder encodeObject:_special forKey:kHotListDataSpecial];
    [aCoder encodeObject:_specialstate forKey:kHotListDataSpecialstate];
    [aCoder encodeObject:_ptid forKey:kHotListDataPtid];
    [aCoder encodeObject:_integral forKey:kHotListDataIntegral];
    [aCoder encodeObject:_info forKey:kHotListDataInfo];
    [aCoder encodeObject:_effect forKey:kHotListDataEffect];
}

- (id)copyWithZone:(NSZone *)zone
{
    HotListData *copy = [[HotListData alloc] init];
    
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
