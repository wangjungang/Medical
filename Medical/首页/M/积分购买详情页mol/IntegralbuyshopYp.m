//
//  IntegralbuyshopYp.m
//
//  Created by 婷 张 on 16/11/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "IntegralbuyshopYp.h"


NSString *const kIntegralbuyshopYpYid = @"yid";
NSString *const kIntegralbuyshopYpDrugName = @"drug_name";
NSString *const kIntegralbuyshopYpPicture = @"picture";
NSString *const kIntegralbuyshopYpIntegral = @"integral";
NSString *const kIntegralbuyshopYpName = @"name";


@interface IntegralbuyshopYp ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation IntegralbuyshopYp

@synthesize yid = _yid;
@synthesize drugName = _drugName;
@synthesize picture = _picture;
@synthesize integral = _integral;
@synthesize name = _name;


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
            self.yid = [self objectOrNilForKey:kIntegralbuyshopYpYid fromDictionary:dict];
            self.drugName = [self objectOrNilForKey:kIntegralbuyshopYpDrugName fromDictionary:dict];
            self.picture = [self objectOrNilForKey:kIntegralbuyshopYpPicture fromDictionary:dict];
            self.integral = [self objectOrNilForKey:kIntegralbuyshopYpIntegral fromDictionary:dict];
            self.name = [self objectOrNilForKey:kIntegralbuyshopYpName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.yid forKey:kIntegralbuyshopYpYid];
    [mutableDict setValue:self.drugName forKey:kIntegralbuyshopYpDrugName];
    [mutableDict setValue:self.picture forKey:kIntegralbuyshopYpPicture];
    [mutableDict setValue:self.integral forKey:kIntegralbuyshopYpIntegral];
    [mutableDict setValue:self.name forKey:kIntegralbuyshopYpName];

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

    self.yid = [aDecoder decodeObjectForKey:kIntegralbuyshopYpYid];
    self.drugName = [aDecoder decodeObjectForKey:kIntegralbuyshopYpDrugName];
    self.picture = [aDecoder decodeObjectForKey:kIntegralbuyshopYpPicture];
    self.integral = [aDecoder decodeObjectForKey:kIntegralbuyshopYpIntegral];
    self.name = [aDecoder decodeObjectForKey:kIntegralbuyshopYpName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_yid forKey:kIntegralbuyshopYpYid];
    [aCoder encodeObject:_drugName forKey:kIntegralbuyshopYpDrugName];
    [aCoder encodeObject:_picture forKey:kIntegralbuyshopYpPicture];
    [aCoder encodeObject:_integral forKey:kIntegralbuyshopYpIntegral];
    [aCoder encodeObject:_name forKey:kIntegralbuyshopYpName];
}

- (id)copyWithZone:(NSZone *)zone
{
    IntegralbuyshopYp *copy = [[IntegralbuyshopYp alloc] init];
    
    if (copy) {

        copy.yid = [self.yid copyWithZone:zone];
        copy.drugName = [self.drugName copyWithZone:zone];
        copy.picture = [self.picture copyWithZone:zone];
        copy.integral = [self.integral copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
