//
//  HotListShopBase.m
//
//  Created by 壮 李 on 2016/11/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HotListShopBase.h"
#import "HotListData.h"


NSString *const kHotListShopBaseData = @"data";
NSString *const kHotListShopBaseCode = @"code";


@interface HotListShopBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HotListShopBase

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
    NSObject *receivedHotListData = [dict objectForKey:kHotListShopBaseData];
    NSMutableArray *parsedHotListData = [NSMutableArray array];
    if ([receivedHotListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHotListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHotListData addObject:[HotListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHotListData isKindOfClass:[NSDictionary class]]) {
       [parsedHotListData addObject:[HotListData modelObjectWithDictionary:(NSDictionary *)receivedHotListData]];
    }

    self.data = [NSArray arrayWithArray:parsedHotListData];
            self.code = [[self objectOrNilForKey:kHotListShopBaseCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kHotListShopBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kHotListShopBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kHotListShopBaseData];
    self.code = [aDecoder decodeDoubleForKey:kHotListShopBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kHotListShopBaseData];
    [aCoder encodeDouble:_code forKey:kHotListShopBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    HotListShopBase *copy = [[HotListShopBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
