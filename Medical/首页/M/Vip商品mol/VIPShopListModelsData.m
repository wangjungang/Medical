//
//  VIPShopListModelsData.m
//
//  Created by 婷 张 on 16/12/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VIPShopListModelsData.h"
#import "VIPShopListModelsProducts.h"


NSString *const kVIPShopListModelsDataId = @"id";
NSString *const kVIPShopListModelsDataScale = @"scale";
NSString *const kVIPShopListModelsDataLon = @"lon";
NSString *const kVIPShopListModelsDataPhone = @"phone";
NSString *const kVIPShopListModelsDataTypeid = @"typeid";
NSString *const kVIPShopListModelsDataStar = @"star";
NSString *const kVIPShopListModelsDataAddtime = @"addtime";
NSString *const kVIPShopListModelsDataPicture = @"picture";
NSString *const kVIPShopListModelsDataLat = @"lat";
NSString *const kVIPShopListModelsDataAddress = @"address";
NSString *const kVIPShopListModelsDataProducts = @"products";
NSString *const kVIPShopListModelsDataName = @"name";
NSString *const kVIPShopListModelsDataContent = @"content";


@interface VIPShopListModelsData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VIPShopListModelsData

@synthesize dataIdentifier = _dataIdentifier;
@synthesize scale = _scale;
@synthesize lon = _lon;
@synthesize phone = _phone;
@synthesize typeid = _typeid;
@synthesize star = _star;
@synthesize addtime = _addtime;
@synthesize picture = _picture;
@synthesize lat = _lat;
@synthesize address = _address;
@synthesize products = _products;
@synthesize name = _name;
@synthesize content = _content;


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
            self.dataIdentifier = [self objectOrNilForKey:kVIPShopListModelsDataId fromDictionary:dict];
            self.scale = [self objectOrNilForKey:kVIPShopListModelsDataScale fromDictionary:dict];
            self.lon = [self objectOrNilForKey:kVIPShopListModelsDataLon fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kVIPShopListModelsDataPhone fromDictionary:dict];
            self.typeid = [self objectOrNilForKey:kVIPShopListModelsDataTypeid fromDictionary:dict];
            self.star = [self objectOrNilForKey:kVIPShopListModelsDataStar fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kVIPShopListModelsDataAddtime fromDictionary:dict];
            self.picture = [self objectOrNilForKey:kVIPShopListModelsDataPicture fromDictionary:dict];
            self.lat = [self objectOrNilForKey:kVIPShopListModelsDataLat fromDictionary:dict];
            self.address = [self objectOrNilForKey:kVIPShopListModelsDataAddress fromDictionary:dict];
    NSObject *receivedVIPShopListModelsProducts = [dict objectForKey:kVIPShopListModelsDataProducts];
    NSMutableArray *parsedVIPShopListModelsProducts = [NSMutableArray array];
    if ([receivedVIPShopListModelsProducts isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedVIPShopListModelsProducts) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedVIPShopListModelsProducts addObject:[VIPShopListModelsProducts modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedVIPShopListModelsProducts isKindOfClass:[NSDictionary class]]) {
       [parsedVIPShopListModelsProducts addObject:[VIPShopListModelsProducts modelObjectWithDictionary:(NSDictionary *)receivedVIPShopListModelsProducts]];
    }

    self.products = [NSArray arrayWithArray:parsedVIPShopListModelsProducts];
            self.name = [self objectOrNilForKey:kVIPShopListModelsDataName fromDictionary:dict];
            self.content = [self objectOrNilForKey:kVIPShopListModelsDataContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dataIdentifier forKey:kVIPShopListModelsDataId];
    [mutableDict setValue:self.scale forKey:kVIPShopListModelsDataScale];
    [mutableDict setValue:self.lon forKey:kVIPShopListModelsDataLon];
    [mutableDict setValue:self.phone forKey:kVIPShopListModelsDataPhone];
    [mutableDict setValue:self.typeid forKey:kVIPShopListModelsDataTypeid];
    [mutableDict setValue:self.star forKey:kVIPShopListModelsDataStar];
    [mutableDict setValue:self.addtime forKey:kVIPShopListModelsDataAddtime];
    [mutableDict setValue:self.picture forKey:kVIPShopListModelsDataPicture];
    [mutableDict setValue:self.lat forKey:kVIPShopListModelsDataLat];
    [mutableDict setValue:self.address forKey:kVIPShopListModelsDataAddress];
    NSMutableArray *tempArrayForProducts = [NSMutableArray array];
    for (NSObject *subArrayObject in self.products) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProducts addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProducts addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProducts] forKey:kVIPShopListModelsDataProducts];
    [mutableDict setValue:self.name forKey:kVIPShopListModelsDataName];
    [mutableDict setValue:self.content forKey:kVIPShopListModelsDataContent];

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

    self.dataIdentifier = [aDecoder decodeObjectForKey:kVIPShopListModelsDataId];
    self.scale = [aDecoder decodeObjectForKey:kVIPShopListModelsDataScale];
    self.lon = [aDecoder decodeObjectForKey:kVIPShopListModelsDataLon];
    self.phone = [aDecoder decodeObjectForKey:kVIPShopListModelsDataPhone];
    self.typeid = [aDecoder decodeObjectForKey:kVIPShopListModelsDataTypeid];
    self.star = [aDecoder decodeObjectForKey:kVIPShopListModelsDataStar];
    self.addtime = [aDecoder decodeObjectForKey:kVIPShopListModelsDataAddtime];
    self.picture = [aDecoder decodeObjectForKey:kVIPShopListModelsDataPicture];
    self.lat = [aDecoder decodeObjectForKey:kVIPShopListModelsDataLat];
    self.address = [aDecoder decodeObjectForKey:kVIPShopListModelsDataAddress];
    self.products = [aDecoder decodeObjectForKey:kVIPShopListModelsDataProducts];
    self.name = [aDecoder decodeObjectForKey:kVIPShopListModelsDataName];
    self.content = [aDecoder decodeObjectForKey:kVIPShopListModelsDataContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dataIdentifier forKey:kVIPShopListModelsDataId];
    [aCoder encodeObject:_scale forKey:kVIPShopListModelsDataScale];
    [aCoder encodeObject:_lon forKey:kVIPShopListModelsDataLon];
    [aCoder encodeObject:_phone forKey:kVIPShopListModelsDataPhone];
    [aCoder encodeObject:_typeid forKey:kVIPShopListModelsDataTypeid];
    [aCoder encodeObject:_star forKey:kVIPShopListModelsDataStar];
    [aCoder encodeObject:_addtime forKey:kVIPShopListModelsDataAddtime];
    [aCoder encodeObject:_picture forKey:kVIPShopListModelsDataPicture];
    [aCoder encodeObject:_lat forKey:kVIPShopListModelsDataLat];
    [aCoder encodeObject:_address forKey:kVIPShopListModelsDataAddress];
    [aCoder encodeObject:_products forKey:kVIPShopListModelsDataProducts];
    [aCoder encodeObject:_name forKey:kVIPShopListModelsDataName];
    [aCoder encodeObject:_content forKey:kVIPShopListModelsDataContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    VIPShopListModelsData *copy = [[VIPShopListModelsData alloc] init];
    
    if (copy) {

        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.scale = [self.scale copyWithZone:zone];
        copy.lon = [self.lon copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.typeid = [self.typeid copyWithZone:zone];
        copy.star = [self.star copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.picture = [self.picture copyWithZone:zone];
        copy.lat = [self.lat copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.products = [self.products copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
