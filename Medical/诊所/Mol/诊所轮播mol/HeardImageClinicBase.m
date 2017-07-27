//
//  HeardImageClinicBase.m
//
//  Created by 壮 李 on 2016/11/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HeardImageClinicBase.h"
#import "HeardImageClinicData.h"


NSString *const kHeardImageClinicBaseData = @"data";
NSString *const kHeardImageClinicBaseCode = @"code";


@interface HeardImageClinicBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HeardImageClinicBase

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
            self.data = [HeardImageClinicData modelObjectWithDictionary:[dict objectForKey:kHeardImageClinicBaseData]];
            self.code = [[self objectOrNilForKey:kHeardImageClinicBaseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kHeardImageClinicBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kHeardImageClinicBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kHeardImageClinicBaseData];
    self.code = [aDecoder decodeDoubleForKey:kHeardImageClinicBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kHeardImageClinicBaseData];
    [aCoder encodeDouble:_code forKey:kHeardImageClinicBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    HeardImageClinicBase *copy = [[HeardImageClinicBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
