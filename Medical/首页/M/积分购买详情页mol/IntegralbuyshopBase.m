//
//  IntegralbuyshopBase.m
//
//  Created by 婷 张 on 16/11/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "IntegralbuyshopBase.h"
#import "IntegralbuyshopData.h"


NSString *const kIntegralbuyshopBaseData = @"data";
NSString *const kIntegralbuyshopBaseCode = @"code";


@interface IntegralbuyshopBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation IntegralbuyshopBase

@synthesize data = _data;
@synthesize code = _code;


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
            self.data = [IntegralbuyshopData modelObjectWithDictionary:[dict objectForKey:kIntegralbuyshopBaseData]];
            self.code = [[self objectOrNilForKey:kIntegralbuyshopBaseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kIntegralbuyshopBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kIntegralbuyshopBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kIntegralbuyshopBaseData];
    self.code = [aDecoder decodeDoubleForKey:kIntegralbuyshopBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kIntegralbuyshopBaseData];
    [aCoder encodeDouble:_code forKey:kIntegralbuyshopBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    IntegralbuyshopBase *copy = [[IntegralbuyshopBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
