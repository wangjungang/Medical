//
//  FinishShopListBuyBase.m
//
//  Created by 婷 张 on 16/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FinishShopListBuyBase.h"
#import "FinishShopListBuyData.h"


NSString *const kFinishShopListBuyBaseData = @"data";
NSString *const kFinishShopListBuyBaseCode = @"code";


@interface FinishShopListBuyBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FinishShopListBuyBase

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
    NSObject *receivedFinishShopListBuyData = [dict objectForKey:kFinishShopListBuyBaseData];
    NSMutableArray *parsedFinishShopListBuyData = [NSMutableArray array];
    if ([receivedFinishShopListBuyData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFinishShopListBuyData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFinishShopListBuyData addObject:[FinishShopListBuyData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFinishShopListBuyData isKindOfClass:[NSDictionary class]]) {
       [parsedFinishShopListBuyData addObject:[FinishShopListBuyData modelObjectWithDictionary:(NSDictionary *)receivedFinishShopListBuyData]];
    }

    self.data = [NSArray arrayWithArray:parsedFinishShopListBuyData];
            self.code = [[self objectOrNilForKey:kFinishShopListBuyBaseCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kFinishShopListBuyBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kFinishShopListBuyBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kFinishShopListBuyBaseData];
    self.code = [aDecoder decodeDoubleForKey:kFinishShopListBuyBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kFinishShopListBuyBaseData];
    [aCoder encodeDouble:_code forKey:kFinishShopListBuyBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    FinishShopListBuyBase *copy = [[FinishShopListBuyBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
