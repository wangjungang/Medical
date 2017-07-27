//
//  VIPShopListModelsBase.m
//
//  Created by 婷 张 on 16/12/3
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VIPShopListModelsBase.h"
#import "VIPShopListModelsData.h"


NSString *const kVIPShopListModelsBaseData = @"data";
NSString *const kVIPShopListModelsBaseCode = @"code";


@interface VIPShopListModelsBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VIPShopListModelsBase

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
    NSObject *receivedVIPShopListModelsData = [dict objectForKey:kVIPShopListModelsBaseData];
    NSMutableArray *parsedVIPShopListModelsData = [NSMutableArray array];
    if ([receivedVIPShopListModelsData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedVIPShopListModelsData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedVIPShopListModelsData addObject:[VIPShopListModelsData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedVIPShopListModelsData isKindOfClass:[NSDictionary class]]) {
       [parsedVIPShopListModelsData addObject:[VIPShopListModelsData modelObjectWithDictionary:(NSDictionary *)receivedVIPShopListModelsData]];
    }

    self.data = [NSArray arrayWithArray:parsedVIPShopListModelsData];
            self.code = [[self objectOrNilForKey:kVIPShopListModelsBaseCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kVIPShopListModelsBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kVIPShopListModelsBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kVIPShopListModelsBaseData];
    self.code = [aDecoder decodeDoubleForKey:kVIPShopListModelsBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kVIPShopListModelsBaseData];
    [aCoder encodeDouble:_code forKey:kVIPShopListModelsBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    VIPShopListModelsBase *copy = [[VIPShopListModelsBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
