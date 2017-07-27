//
//  LZProblemBase.m
//
//  Created by 壮 李 on 2016/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LZProblemBase.h"
#import "LZProblemData.h"


NSString *const kLZProblemBaseData = @"data";
NSString *const kLZProblemBaseCode = @"code";


@interface LZProblemBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LZProblemBase

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
    NSObject *receivedLZProblemData = [dict objectForKey:kLZProblemBaseData];
    NSMutableArray *parsedLZProblemData = [NSMutableArray array];
    if ([receivedLZProblemData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedLZProblemData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedLZProblemData addObject:[LZProblemData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedLZProblemData isKindOfClass:[NSDictionary class]]) {
       [parsedLZProblemData addObject:[LZProblemData modelObjectWithDictionary:(NSDictionary *)receivedLZProblemData]];
    }

    self.data = [NSArray arrayWithArray:parsedLZProblemData];
            self.code = [[self objectOrNilForKey:kLZProblemBaseCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kLZProblemBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kLZProblemBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kLZProblemBaseData];
    self.code = [aDecoder decodeDoubleForKey:kLZProblemBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kLZProblemBaseData];
    [aCoder encodeDouble:_code forKey:kLZProblemBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    LZProblemBase *copy = [[LZProblemBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
