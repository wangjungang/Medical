//
//  HistoryPayListBase.m
//
//  Created by 壮 李 on 2016/11/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HistoryPayListBase.h"
#import "HistoryPayData.h"


NSString *const kHistoryPayListBaseData = @"data";
NSString *const kHistoryPayListBaseCode = @"code";


@interface HistoryPayListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HistoryPayListBase

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
    NSObject *receivedHistoryPayData = [dict objectForKey:kHistoryPayListBaseData];
    NSMutableArray *parsedHistoryPayData = [NSMutableArray array];
    if ([receivedHistoryPayData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedHistoryPayData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedHistoryPayData addObject:[HistoryPayData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedHistoryPayData isKindOfClass:[NSDictionary class]]) {
       [parsedHistoryPayData addObject:[HistoryPayData modelObjectWithDictionary:(NSDictionary *)receivedHistoryPayData]];
    }

    self.data = [NSArray arrayWithArray:parsedHistoryPayData];
            self.code = [[self objectOrNilForKey:kHistoryPayListBaseCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kHistoryPayListBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kHistoryPayListBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kHistoryPayListBaseData];
    self.code = [aDecoder decodeDoubleForKey:kHistoryPayListBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kHistoryPayListBaseData];
    [aCoder encodeDouble:_code forKey:kHistoryPayListBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    HistoryPayListBase *copy = [[HistoryPayListBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
