//
//  IntegralbuyshopAddress.m
//
//  Created by 婷 张 on 16/11/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "IntegralbuyshopAddress.h"


NSString *const kIntegralbuyshopAddressMobile = @"mobile";
NSString *const kIntegralbuyshopAddressAddtime = @"addtime";
NSString *const kIntegralbuyshopAddressUid = @"uid";
NSString *const kIntegralbuyshopAddressId = @"id";
NSString *const kIntegralbuyshopAddressStatus = @"status";
NSString *const kIntegralbuyshopAddressSavename = @"savename";
NSString *const kIntegralbuyshopAddressAddress = @"address";
NSString *const kIntegralbuyshopAddressArea = @"area";


@interface IntegralbuyshopAddress ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation IntegralbuyshopAddress

@synthesize mobile = _mobile;
@synthesize addtime = _addtime;
@synthesize uid = _uid;
@synthesize addressIdentifier = _addressIdentifier;
@synthesize status = _status;
@synthesize savename = _savename;
@synthesize address = _address;
@synthesize area = _area;


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
            self.mobile = [self objectOrNilForKey:kIntegralbuyshopAddressMobile fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kIntegralbuyshopAddressAddtime fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kIntegralbuyshopAddressUid fromDictionary:dict];
            self.addressIdentifier = [self objectOrNilForKey:kIntegralbuyshopAddressId fromDictionary:dict];
            self.status = [self objectOrNilForKey:kIntegralbuyshopAddressStatus fromDictionary:dict];
            self.savename = [self objectOrNilForKey:kIntegralbuyshopAddressSavename fromDictionary:dict];
            self.address = [self objectOrNilForKey:kIntegralbuyshopAddressAddress fromDictionary:dict];
            self.area = [self objectOrNilForKey:kIntegralbuyshopAddressArea fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.mobile forKey:kIntegralbuyshopAddressMobile];
    [mutableDict setValue:self.addtime forKey:kIntegralbuyshopAddressAddtime];
    [mutableDict setValue:self.uid forKey:kIntegralbuyshopAddressUid];
    [mutableDict setValue:self.addressIdentifier forKey:kIntegralbuyshopAddressId];
    [mutableDict setValue:self.status forKey:kIntegralbuyshopAddressStatus];
    [mutableDict setValue:self.savename forKey:kIntegralbuyshopAddressSavename];
    [mutableDict setValue:self.address forKey:kIntegralbuyshopAddressAddress];
    [mutableDict setValue:self.area forKey:kIntegralbuyshopAddressArea];

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

    self.mobile = [aDecoder decodeObjectForKey:kIntegralbuyshopAddressMobile];
    self.addtime = [aDecoder decodeObjectForKey:kIntegralbuyshopAddressAddtime];
    self.uid = [aDecoder decodeObjectForKey:kIntegralbuyshopAddressUid];
    self.addressIdentifier = [aDecoder decodeObjectForKey:kIntegralbuyshopAddressId];
    self.status = [aDecoder decodeObjectForKey:kIntegralbuyshopAddressStatus];
    self.savename = [aDecoder decodeObjectForKey:kIntegralbuyshopAddressSavename];
    self.address = [aDecoder decodeObjectForKey:kIntegralbuyshopAddressAddress];
    self.area = [aDecoder decodeObjectForKey:kIntegralbuyshopAddressArea];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_mobile forKey:kIntegralbuyshopAddressMobile];
    [aCoder encodeObject:_addtime forKey:kIntegralbuyshopAddressAddtime];
    [aCoder encodeObject:_uid forKey:kIntegralbuyshopAddressUid];
    [aCoder encodeObject:_addressIdentifier forKey:kIntegralbuyshopAddressId];
    [aCoder encodeObject:_status forKey:kIntegralbuyshopAddressStatus];
    [aCoder encodeObject:_savename forKey:kIntegralbuyshopAddressSavename];
    [aCoder encodeObject:_address forKey:kIntegralbuyshopAddressAddress];
    [aCoder encodeObject:_area forKey:kIntegralbuyshopAddressArea];
}

- (id)copyWithZone:(NSZone *)zone
{
    IntegralbuyshopAddress *copy = [[IntegralbuyshopAddress alloc] init];
    
    if (copy) {

        copy.mobile = [self.mobile copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.addressIdentifier = [self.addressIdentifier copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.savename = [self.savename copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
    }
    
    return copy;
}


@end
