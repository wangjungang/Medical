//
//  JoinHandelShopBase.m
//
//  Created by 壮 李 on 2016/11/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "JoinHandelShopBase.h"
#import "JoinHandelData.h"


NSString *const kJoinHandelShopBaseData = @"data";
NSString *const kJoinHandelShopBaseCode = @"code";


@interface JoinHandelShopBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JoinHandelShopBase

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
    NSObject *receivedJoinHandelData = [dict objectForKey:kJoinHandelShopBaseData];
    NSMutableArray *parsedJoinHandelData = [NSMutableArray array];
    if ([receivedJoinHandelData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedJoinHandelData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedJoinHandelData addObject:[JoinHandelData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedJoinHandelData isKindOfClass:[NSDictionary class]]) {
       [parsedJoinHandelData addObject:[JoinHandelData modelObjectWithDictionary:(NSDictionary *)receivedJoinHandelData]];
    }

    self.data = [NSArray arrayWithArray:parsedJoinHandelData];
            self.code = [[self objectOrNilForKey:kJoinHandelShopBaseCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kJoinHandelShopBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kJoinHandelShopBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kJoinHandelShopBaseData];
    self.code = [aDecoder decodeDoubleForKey:kJoinHandelShopBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kJoinHandelShopBaseData];
    [aCoder encodeDouble:_code forKey:kJoinHandelShopBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    JoinHandelShopBase *copy = [[JoinHandelShopBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}

@end
