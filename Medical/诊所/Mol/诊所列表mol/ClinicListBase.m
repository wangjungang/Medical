//
//  ClinicListBase.m
//
//  Created by 壮 李 on 2016/11/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ClinicListBase.h"
#import "ClinicListData.h"


NSString *const kClinicListBaseData = @"data";
NSString *const kClinicListBaseCode = @"code";


@interface ClinicListBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ClinicListBase

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
    NSObject *receivedClinicListData = [dict objectForKey:kClinicListBaseData];
    NSMutableArray *parsedClinicListData = [NSMutableArray array];
    if ([receivedClinicListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedClinicListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedClinicListData addObject:[ClinicListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedClinicListData isKindOfClass:[NSDictionary class]]) {
       [parsedClinicListData addObject:[ClinicListData modelObjectWithDictionary:(NSDictionary *)receivedClinicListData]];
    }

    self.data = [NSArray arrayWithArray:parsedClinicListData];
            self.code = [[self objectOrNilForKey:kClinicListBaseCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kClinicListBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kClinicListBaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kClinicListBaseData];
    self.code = [aDecoder decodeDoubleForKey:kClinicListBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kClinicListBaseData];
    [aCoder encodeDouble:_code forKey:kClinicListBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    ClinicListBase *copy = [[ClinicListBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
