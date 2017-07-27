//
//  ListShopIntegralBase.m
//
//  Created by 壮 李 on 2016/11/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ListShopIntegralBase.h"
#import "ListShopIntegralData.h"


NSString *const kListShopIntegralBaseData = @"data";
NSString *const kListShopIntegralBaseCode = @"code";


@interface ListShopIntegralBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ListShopIntegralBase

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
    NSObject *receivedListShopIntegralData = [dict objectForKey:kListShopIntegralBaseData];
    NSMutableArray *parsedListShopIntegralData = [NSMutableArray array];
    if ([receivedListShopIntegralData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedListShopIntegralData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedListShopIntegralData addObject:[ListShopIntegralData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedListShopIntegralData isKindOfClass:[NSDictionary class]]) {
       [parsedListShopIntegralData addObject:[ListShopIntegralData modelObjectWithDictionary:(NSDictionary *)receivedListShopIntegralData]];
    }

    self.data = [NSArray arrayWithArray:parsedListShopIntegralData];
            self.code = [[self objectOrNilForKey:kListShopIntegralBaseCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kListShopIntegralBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kListShopIntegralBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kListShopIntegralBaseData];
    self.code = [aDecoder decodeDoubleForKey:kListShopIntegralBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kListShopIntegralBaseData];
    [aCoder encodeDouble:_code forKey:kListShopIntegralBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    ListShopIntegralBase *copy = [[ListShopIntegralBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
