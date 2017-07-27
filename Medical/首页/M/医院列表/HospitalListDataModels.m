//
//  HospitalListDataModels.m
//
//  Created by 婷 张 on 16/11/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HospitalListDataModels.h"
#import "HospitalListData.h"


NSString *const kHospitalListDataModelsData = @"data";
NSString *const kHospitalListDataModelsCode = @"code";


@interface HospitalListDataModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HospitalListDataModels

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
    NSObject *receivedHospitalListData = [dict objectForKey:kHospitalListDataModelsData];
    NSMutableArray *parsedHospitalListData = [NSMutableArray array];
    if ([receivedHospitalListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHospitalListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHospitalListData addObject:[HospitalListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHospitalListData isKindOfClass:[NSDictionary class]]) {
       [parsedHospitalListData addObject:[HospitalListData modelObjectWithDictionary:(NSDictionary *)receivedHospitalListData]];
    }

    self.data = [NSArray arrayWithArray:parsedHospitalListData];
            self.code = [[self objectOrNilForKey:kHospitalListDataModelsCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForData = [NSMutableArray array];
    for (NSObject *subArrayObject in self.data) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForData addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForData addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kHospitalListDataModelsData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kHospitalListDataModelsCode];

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

    self.data = [aDecoder decodeObjectForKey:kHospitalListDataModelsData];
    self.code = [aDecoder decodeDoubleForKey:kHospitalListDataModelsCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kHospitalListDataModelsData];
    [aCoder encodeDouble:_code forKey:kHospitalListDataModelsCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    HospitalListDataModels *copy = [[HospitalListDataModels alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
