//
//  IntegralbuyshopData.m
//
//  Created by 婷 张 on 16/11/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "IntegralbuyshopData.h"
#import "IntegralbuyshopAddress.h"
#import "IntegralbuyshopYp.h"


NSString *const kIntegralbuyshopDataAddress = @"address";
NSString *const kIntegralbuyshopDataYp = @"yp";


@interface IntegralbuyshopData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation IntegralbuyshopData

@synthesize address = _address;
@synthesize yp = _yp;


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
            self.address = [IntegralbuyshopAddress modelObjectWithDictionary:[dict objectForKey:kIntegralbuyshopDataAddress]];
            self.yp = [IntegralbuyshopYp modelObjectWithDictionary:[dict objectForKey:kIntegralbuyshopDataYp]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.address dictionaryRepresentation] forKey:kIntegralbuyshopDataAddress];
    [mutableDict setValue:[self.yp dictionaryRepresentation] forKey:kIntegralbuyshopDataYp];

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

    self.address = [aDecoder decodeObjectForKey:kIntegralbuyshopDataAddress];
    self.yp = [aDecoder decodeObjectForKey:kIntegralbuyshopDataYp];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_address forKey:kIntegralbuyshopDataAddress];
    [aCoder encodeObject:_yp forKey:kIntegralbuyshopDataYp];
}

- (id)copyWithZone:(NSZone *)zone
{
    IntegralbuyshopData *copy = [[IntegralbuyshopData alloc] init];
    
    if (copy) {

        copy.address = [self.address copyWithZone:zone];
        copy.yp = [self.yp copyWithZone:zone];
    }
    
    return copy;
}


@end
