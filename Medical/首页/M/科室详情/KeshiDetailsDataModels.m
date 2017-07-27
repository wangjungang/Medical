//
//  KeshiDetailsDataModels.m
//
//  Created by 婷 张 on 16/11/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "KeshiDetailsDataModels.h"
#import "KeshiDetailsData.h"


NSString *const kKeshiDetailsDataModelsData = @"data";
NSString *const kKeshiDetailsDataModelsCode = @"code";


@interface KeshiDetailsDataModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KeshiDetailsDataModels

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
    NSObject *receivedKeshiDetailsData = [dict objectForKey:kKeshiDetailsDataModelsData];
    NSMutableArray *parsedKeshiDetailsData = [NSMutableArray array];
    if ([receivedKeshiDetailsData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedKeshiDetailsData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedKeshiDetailsData addObject:[KeshiDetailsData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedKeshiDetailsData isKindOfClass:[NSDictionary class]]) {
       [parsedKeshiDetailsData addObject:[KeshiDetailsData modelObjectWithDictionary:(NSDictionary *)receivedKeshiDetailsData]];
    }

    self.data = [NSArray arrayWithArray:parsedKeshiDetailsData];
            self.code = [[self objectOrNilForKey:kKeshiDetailsDataModelsCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kKeshiDetailsDataModelsData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kKeshiDetailsDataModelsCode];

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

    self.data = [aDecoder decodeObjectForKey:kKeshiDetailsDataModelsData];
    self.code = [aDecoder decodeDoubleForKey:kKeshiDetailsDataModelsCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kKeshiDetailsDataModelsData];
    [aCoder encodeDouble:_code forKey:kKeshiDetailsDataModelsCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    KeshiDetailsDataModels *copy = [[KeshiDetailsDataModels alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
