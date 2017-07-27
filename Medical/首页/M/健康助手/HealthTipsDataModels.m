//
//  HealthTipsDataModels.m
//
//  Created by 婷 张 on 16/11/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HealthTipsDataModels.h"
#import "HealthTipsData.h"


NSString *const kHealthTipsDataModelsData = @"data";
NSString *const kHealthTipsDataModelsCode = @"code";


@interface HealthTipsDataModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HealthTipsDataModels

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
    NSObject *receivedHealthTipsData = [dict objectForKey:kHealthTipsDataModelsData];
    NSMutableArray *parsedHealthTipsData = [NSMutableArray array];
    if ([receivedHealthTipsData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHealthTipsData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHealthTipsData addObject:[HealthTipsData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHealthTipsData isKindOfClass:[NSDictionary class]]) {
       [parsedHealthTipsData addObject:[HealthTipsData modelObjectWithDictionary:(NSDictionary *)receivedHealthTipsData]];
    }

    self.data = [NSArray arrayWithArray:parsedHealthTipsData];
            self.code = [[self objectOrNilForKey:kHealthTipsDataModelsCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kHealthTipsDataModelsData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kHealthTipsDataModelsCode];

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

    self.data = [aDecoder decodeObjectForKey:kHealthTipsDataModelsData];
    self.code = [aDecoder decodeDoubleForKey:kHealthTipsDataModelsCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kHealthTipsDataModelsData];
    [aCoder encodeDouble:_code forKey:kHealthTipsDataModelsCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    HealthTipsDataModels *copy = [[HealthTipsDataModels alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
