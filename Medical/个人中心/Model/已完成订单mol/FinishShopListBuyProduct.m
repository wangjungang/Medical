//
//  FinishShopListBuyProduct.m
//
//  Created by 婷 张 on 16/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FinishShopListBuyProduct.h"


NSString *const kFinishShopListBuyProductTypeid = @"typeid";
NSString *const kFinishShopListBuyProductAddtime = @"addtime";
NSString *const kFinishShopListBuyProductLon = @"lon";
NSString *const kFinishShopListBuyProductId = @"id";
NSString *const kFinishShopListBuyProductLevel = @"level";
NSString *const kFinishShopListBuyProductIntegral = @"integral";
NSString *const kFinishShopListBuyProductGname = @"gname";
NSString *const kFinishShopListBuyProductAddress = @"address";
NSString *const kFinishShopListBuyProductVipstate = @"vipstate";
NSString *const kFinishShopListBuyProductPictures = @"pictures";
NSString *const kFinishShopListBuyProductGid = @"gid";
NSString *const kFinishShopListBuyProductPicture = @"picture";
NSString *const kFinishShopListBuyProductNumber = @"number";
NSString *const kFinishShopListBuyProductSprice = @"sprice";
NSString *const kFinishShopListBuyProductInfo = @"info";
NSString *const kFinishShopListBuyProductStar = @"star";
NSString *const kFinishShopListBuyProductName = @"name";
NSString *const kFinishShopListBuyProductDrugName = @"drug_name";
NSString *const kFinishShopListBuyProductOid = @"oid";
NSString *const kFinishShopListBuyProductOrder = @"order";
NSString *const kFinishShopListBuyProductYid = @"yid";
NSString *const kFinishShopListBuyProductCid = @"cid";
NSString *const kFinishShopListBuyProductHotstate = @"hotstate";
NSString *const kFinishShopListBuyProductContent = @"content";
NSString *const kFinishShopListBuyProductEffect = @"effect";
NSString *const kFinishShopListBuyProductSpecial = @"special";
NSString *const kFinishShopListBuyProductOldprice = @"oldprice";
NSString *const kFinishShopListBuyProductLat = @"lat";
NSString *const kFinishShopListBuyProductSpecialstate = @"specialstate";
NSString *const kFinishShopListBuyProductIntegralstate = @"integralstate";
NSString *const kFinishShopListBuyProductNowprice = @"nowprice";
NSString *const kFinishShopListBuyProductXiaoliang = @"xiaoliang";
NSString *const kFinishShopListBuyProductPtid = @"ptid";
NSString *const kFinishShopListBuyProductPhone = @"phone";
NSString *const kFinishShopListBuyProductScale = @"scale";


@interface FinishShopListBuyProduct ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FinishShopListBuyProduct

@synthesize typeid = _typeid;
@synthesize addtime = _addtime;
@synthesize lon = _lon;
@synthesize productIdentifier = _productIdentifier;
@synthesize level = _level;
@synthesize integral = _integral;
@synthesize gname = _gname;
@synthesize address = _address;
@synthesize vipstate = _vipstate;
@synthesize pictures = _pictures;
@synthesize gid = _gid;
@synthesize picture = _picture;
@synthesize number = _number;
@synthesize sprice = _sprice;
@synthesize info = _info;
@synthesize star = _star;
@synthesize name = _name;
@synthesize drugName = _drugName;
@synthesize oid = _oid;
@synthesize order = _order;
@synthesize yid = _yid;
@synthesize cid = _cid;
@synthesize hotstate = _hotstate;
@synthesize content = _content;
@synthesize effect = _effect;
@synthesize special = _special;
@synthesize oldprice = _oldprice;
@synthesize lat = _lat;
@synthesize specialstate = _specialstate;
@synthesize integralstate = _integralstate;
@synthesize nowprice = _nowprice;
@synthesize xiaoliang = _xiaoliang;
@synthesize ptid = _ptid;
@synthesize phone = _phone;
@synthesize scale = _scale;


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
            self.typeid = [self objectOrNilForKey:kFinishShopListBuyProductTypeid fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kFinishShopListBuyProductAddtime fromDictionary:dict];
            self.lon = [self objectOrNilForKey:kFinishShopListBuyProductLon fromDictionary:dict];
            self.productIdentifier = [self objectOrNilForKey:kFinishShopListBuyProductId fromDictionary:dict];
            self.level = [self objectOrNilForKey:kFinishShopListBuyProductLevel fromDictionary:dict];
            self.integral = [self objectOrNilForKey:kFinishShopListBuyProductIntegral fromDictionary:dict];
            self.gname = [self objectOrNilForKey:kFinishShopListBuyProductGname fromDictionary:dict];
            self.address = [self objectOrNilForKey:kFinishShopListBuyProductAddress fromDictionary:dict];
            self.vipstate = [self objectOrNilForKey:kFinishShopListBuyProductVipstate fromDictionary:dict];
            self.pictures = [self objectOrNilForKey:kFinishShopListBuyProductPictures fromDictionary:dict];
            self.gid = [self objectOrNilForKey:kFinishShopListBuyProductGid fromDictionary:dict];
            self.picture = [self objectOrNilForKey:kFinishShopListBuyProductPicture fromDictionary:dict];
            self.number = [self objectOrNilForKey:kFinishShopListBuyProductNumber fromDictionary:dict];
            self.sprice = [self objectOrNilForKey:kFinishShopListBuyProductSprice fromDictionary:dict];
            self.info = [self objectOrNilForKey:kFinishShopListBuyProductInfo fromDictionary:dict];
            self.star = [self objectOrNilForKey:kFinishShopListBuyProductStar fromDictionary:dict];
            self.name = [self objectOrNilForKey:kFinishShopListBuyProductName fromDictionary:dict];
            self.drugName = [self objectOrNilForKey:kFinishShopListBuyProductDrugName fromDictionary:dict];
            self.oid = [self objectOrNilForKey:kFinishShopListBuyProductOid fromDictionary:dict];
            self.order = [self objectOrNilForKey:kFinishShopListBuyProductOrder fromDictionary:dict];
            self.yid = [self objectOrNilForKey:kFinishShopListBuyProductYid fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kFinishShopListBuyProductCid fromDictionary:dict];
            self.hotstate = [self objectOrNilForKey:kFinishShopListBuyProductHotstate fromDictionary:dict];
            self.content = [self objectOrNilForKey:kFinishShopListBuyProductContent fromDictionary:dict];
            self.effect = [self objectOrNilForKey:kFinishShopListBuyProductEffect fromDictionary:dict];
            self.special = [self objectOrNilForKey:kFinishShopListBuyProductSpecial fromDictionary:dict];
            self.oldprice = [self objectOrNilForKey:kFinishShopListBuyProductOldprice fromDictionary:dict];
            self.lat = [self objectOrNilForKey:kFinishShopListBuyProductLat fromDictionary:dict];
            self.specialstate = [self objectOrNilForKey:kFinishShopListBuyProductSpecialstate fromDictionary:dict];
            self.integralstate = [self objectOrNilForKey:kFinishShopListBuyProductIntegralstate fromDictionary:dict];
            self.nowprice = [self objectOrNilForKey:kFinishShopListBuyProductNowprice fromDictionary:dict];
            self.xiaoliang = [self objectOrNilForKey:kFinishShopListBuyProductXiaoliang fromDictionary:dict];
            self.ptid = [self objectOrNilForKey:kFinishShopListBuyProductPtid fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kFinishShopListBuyProductPhone fromDictionary:dict];
            self.scale = [self objectOrNilForKey:kFinishShopListBuyProductScale fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.typeid forKey:kFinishShopListBuyProductTypeid];
    [mutableDict setValue:self.addtime forKey:kFinishShopListBuyProductAddtime];
    [mutableDict setValue:self.lon forKey:kFinishShopListBuyProductLon];
    [mutableDict setValue:self.productIdentifier forKey:kFinishShopListBuyProductId];
    [mutableDict setValue:self.level forKey:kFinishShopListBuyProductLevel];
    [mutableDict setValue:self.integral forKey:kFinishShopListBuyProductIntegral];
    [mutableDict setValue:self.gname forKey:kFinishShopListBuyProductGname];
    [mutableDict setValue:self.address forKey:kFinishShopListBuyProductAddress];
    [mutableDict setValue:self.vipstate forKey:kFinishShopListBuyProductVipstate];
    [mutableDict setValue:self.pictures forKey:kFinishShopListBuyProductPictures];
    [mutableDict setValue:self.gid forKey:kFinishShopListBuyProductGid];
    [mutableDict setValue:self.picture forKey:kFinishShopListBuyProductPicture];
    [mutableDict setValue:self.number forKey:kFinishShopListBuyProductNumber];
    [mutableDict setValue:self.sprice forKey:kFinishShopListBuyProductSprice];
    [mutableDict setValue:self.info forKey:kFinishShopListBuyProductInfo];
    [mutableDict setValue:self.star forKey:kFinishShopListBuyProductStar];
    [mutableDict setValue:self.name forKey:kFinishShopListBuyProductName];
    [mutableDict setValue:self.drugName forKey:kFinishShopListBuyProductDrugName];
    [mutableDict setValue:self.oid forKey:kFinishShopListBuyProductOid];
    [mutableDict setValue:self.order forKey:kFinishShopListBuyProductOrder];
    [mutableDict setValue:self.yid forKey:kFinishShopListBuyProductYid];
    [mutableDict setValue:self.cid forKey:kFinishShopListBuyProductCid];
    [mutableDict setValue:self.hotstate forKey:kFinishShopListBuyProductHotstate];
    [mutableDict setValue:self.content forKey:kFinishShopListBuyProductContent];
    [mutableDict setValue:self.effect forKey:kFinishShopListBuyProductEffect];
    [mutableDict setValue:self.special forKey:kFinishShopListBuyProductSpecial];
    [mutableDict setValue:self.oldprice forKey:kFinishShopListBuyProductOldprice];
    [mutableDict setValue:self.lat forKey:kFinishShopListBuyProductLat];
    [mutableDict setValue:self.specialstate forKey:kFinishShopListBuyProductSpecialstate];
    [mutableDict setValue:self.integralstate forKey:kFinishShopListBuyProductIntegralstate];
    [mutableDict setValue:self.nowprice forKey:kFinishShopListBuyProductNowprice];
    [mutableDict setValue:self.xiaoliang forKey:kFinishShopListBuyProductXiaoliang];
    [mutableDict setValue:self.ptid forKey:kFinishShopListBuyProductPtid];
    [mutableDict setValue:self.phone forKey:kFinishShopListBuyProductPhone];
    [mutableDict setValue:self.scale forKey:kFinishShopListBuyProductScale];

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

    self.typeid = [aDecoder decodeObjectForKey:kFinishShopListBuyProductTypeid];
    self.addtime = [aDecoder decodeObjectForKey:kFinishShopListBuyProductAddtime];
    self.lon = [aDecoder decodeObjectForKey:kFinishShopListBuyProductLon];
    self.productIdentifier = [aDecoder decodeObjectForKey:kFinishShopListBuyProductId];
    self.level = [aDecoder decodeObjectForKey:kFinishShopListBuyProductLevel];
    self.integral = [aDecoder decodeObjectForKey:kFinishShopListBuyProductIntegral];
    self.gname = [aDecoder decodeObjectForKey:kFinishShopListBuyProductGname];
    self.address = [aDecoder decodeObjectForKey:kFinishShopListBuyProductAddress];
    self.vipstate = [aDecoder decodeObjectForKey:kFinishShopListBuyProductVipstate];
    self.pictures = [aDecoder decodeObjectForKey:kFinishShopListBuyProductPictures];
    self.gid = [aDecoder decodeObjectForKey:kFinishShopListBuyProductGid];
    self.picture = [aDecoder decodeObjectForKey:kFinishShopListBuyProductPicture];
    self.number = [aDecoder decodeObjectForKey:kFinishShopListBuyProductNumber];
    self.sprice = [aDecoder decodeObjectForKey:kFinishShopListBuyProductSprice];
    self.info = [aDecoder decodeObjectForKey:kFinishShopListBuyProductInfo];
    self.star = [aDecoder decodeObjectForKey:kFinishShopListBuyProductStar];
    self.name = [aDecoder decodeObjectForKey:kFinishShopListBuyProductName];
    self.drugName = [aDecoder decodeObjectForKey:kFinishShopListBuyProductDrugName];
    self.oid = [aDecoder decodeObjectForKey:kFinishShopListBuyProductOid];
    self.order = [aDecoder decodeObjectForKey:kFinishShopListBuyProductOrder];
    self.yid = [aDecoder decodeObjectForKey:kFinishShopListBuyProductYid];
    self.cid = [aDecoder decodeObjectForKey:kFinishShopListBuyProductCid];
    self.hotstate = [aDecoder decodeObjectForKey:kFinishShopListBuyProductHotstate];
    self.content = [aDecoder decodeObjectForKey:kFinishShopListBuyProductContent];
    self.effect = [aDecoder decodeObjectForKey:kFinishShopListBuyProductEffect];
    self.special = [aDecoder decodeObjectForKey:kFinishShopListBuyProductSpecial];
    self.oldprice = [aDecoder decodeObjectForKey:kFinishShopListBuyProductOldprice];
    self.lat = [aDecoder decodeObjectForKey:kFinishShopListBuyProductLat];
    self.specialstate = [aDecoder decodeObjectForKey:kFinishShopListBuyProductSpecialstate];
    self.integralstate = [aDecoder decodeObjectForKey:kFinishShopListBuyProductIntegralstate];
    self.nowprice = [aDecoder decodeObjectForKey:kFinishShopListBuyProductNowprice];
    self.xiaoliang = [aDecoder decodeObjectForKey:kFinishShopListBuyProductXiaoliang];
    self.ptid = [aDecoder decodeObjectForKey:kFinishShopListBuyProductPtid];
    self.phone = [aDecoder decodeObjectForKey:kFinishShopListBuyProductPhone];
    self.scale = [aDecoder decodeObjectForKey:kFinishShopListBuyProductScale];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_typeid forKey:kFinishShopListBuyProductTypeid];
    [aCoder encodeObject:_addtime forKey:kFinishShopListBuyProductAddtime];
    [aCoder encodeObject:_lon forKey:kFinishShopListBuyProductLon];
    [aCoder encodeObject:_productIdentifier forKey:kFinishShopListBuyProductId];
    [aCoder encodeObject:_level forKey:kFinishShopListBuyProductLevel];
    [aCoder encodeObject:_integral forKey:kFinishShopListBuyProductIntegral];
    [aCoder encodeObject:_gname forKey:kFinishShopListBuyProductGname];
    [aCoder encodeObject:_address forKey:kFinishShopListBuyProductAddress];
    [aCoder encodeObject:_vipstate forKey:kFinishShopListBuyProductVipstate];
    [aCoder encodeObject:_pictures forKey:kFinishShopListBuyProductPictures];
    [aCoder encodeObject:_gid forKey:kFinishShopListBuyProductGid];
    [aCoder encodeObject:_picture forKey:kFinishShopListBuyProductPicture];
    [aCoder encodeObject:_number forKey:kFinishShopListBuyProductNumber];
    [aCoder encodeObject:_sprice forKey:kFinishShopListBuyProductSprice];
    [aCoder encodeObject:_info forKey:kFinishShopListBuyProductInfo];
    [aCoder encodeObject:_star forKey:kFinishShopListBuyProductStar];
    [aCoder encodeObject:_name forKey:kFinishShopListBuyProductName];
    [aCoder encodeObject:_drugName forKey:kFinishShopListBuyProductDrugName];
    [aCoder encodeObject:_oid forKey:kFinishShopListBuyProductOid];
    [aCoder encodeObject:_order forKey:kFinishShopListBuyProductOrder];
    [aCoder encodeObject:_yid forKey:kFinishShopListBuyProductYid];
    [aCoder encodeObject:_cid forKey:kFinishShopListBuyProductCid];
    [aCoder encodeObject:_hotstate forKey:kFinishShopListBuyProductHotstate];
    [aCoder encodeObject:_content forKey:kFinishShopListBuyProductContent];
    [aCoder encodeObject:_effect forKey:kFinishShopListBuyProductEffect];
    [aCoder encodeObject:_special forKey:kFinishShopListBuyProductSpecial];
    [aCoder encodeObject:_oldprice forKey:kFinishShopListBuyProductOldprice];
    [aCoder encodeObject:_lat forKey:kFinishShopListBuyProductLat];
    [aCoder encodeObject:_specialstate forKey:kFinishShopListBuyProductSpecialstate];
    [aCoder encodeObject:_integralstate forKey:kFinishShopListBuyProductIntegralstate];
    [aCoder encodeObject:_nowprice forKey:kFinishShopListBuyProductNowprice];
    [aCoder encodeObject:_xiaoliang forKey:kFinishShopListBuyProductXiaoliang];
    [aCoder encodeObject:_ptid forKey:kFinishShopListBuyProductPtid];
    [aCoder encodeObject:_phone forKey:kFinishShopListBuyProductPhone];
    [aCoder encodeObject:_scale forKey:kFinishShopListBuyProductScale];
}

- (id)copyWithZone:(NSZone *)zone
{
    FinishShopListBuyProduct *copy = [[FinishShopListBuyProduct alloc] init];
    
    if (copy) {

        copy.typeid = [self.typeid copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.lon = [self.lon copyWithZone:zone];
        copy.productIdentifier = [self.productIdentifier copyWithZone:zone];
        copy.level = [self.level copyWithZone:zone];
        copy.integral = [self.integral copyWithZone:zone];
        copy.gname = [self.gname copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.vipstate = [self.vipstate copyWithZone:zone];
        copy.pictures = [self.pictures copyWithZone:zone];
        copy.gid = [self.gid copyWithZone:zone];
        copy.picture = [self.picture copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.sprice = [self.sprice copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.star = [self.star copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.drugName = [self.drugName copyWithZone:zone];
        copy.oid = [self.oid copyWithZone:zone];
        copy.order = [self.order copyWithZone:zone];
        copy.yid = [self.yid copyWithZone:zone];
        copy.cid = [self.cid copyWithZone:zone];
        copy.hotstate = [self.hotstate copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.effect = [self.effect copyWithZone:zone];
        copy.special = [self.special copyWithZone:zone];
        copy.oldprice = [self.oldprice copyWithZone:zone];
        copy.lat = [self.lat copyWithZone:zone];
        copy.specialstate = [self.specialstate copyWithZone:zone];
        copy.integralstate = [self.integralstate copyWithZone:zone];
        copy.nowprice = [self.nowprice copyWithZone:zone];
        copy.xiaoliang = [self.xiaoliang copyWithZone:zone];
        copy.ptid = [self.ptid copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.scale = [self.scale copyWithZone:zone];
    }
    
    return copy;
}


@end
