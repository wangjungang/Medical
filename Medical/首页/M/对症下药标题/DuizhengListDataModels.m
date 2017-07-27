//
//  DuizhengListDataModels.m
//
//  Created by 婷 张 on 16/11/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DuizhengListDataModels.h"
#import "DuizhengListData.h"


NSString *const kDuizhengListDataModelsData = @"data";
NSString *const kDuizhengListDataModelsCode = @"code";


@interface DuizhengListDataModels ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DuizhengListDataModels

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
    NSObject *receivedDuizhengListData = [dict objectForKey:kDuizhengListDataModelsData];
    NSMutableArray *parsedDuizhengListData = [NSMutableArray array];
    if ([receivedDuizhengListData isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDuizhengListData) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDuizhengListData addObject:[DuizhengListData modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDuizhengListData isKindOfClass:[NSDictionary class]]) {
       [parsedDuizhengListData addObject:[DuizhengListData modelObjectWithDictionary:(NSDictionary *)receivedDuizhengListData]];
    }

    self.data = [NSArray arrayWithArray:parsedDuizhengListData];
            self.code = [[self objectOrNilForKey:kDuizhengListDataModelsCode fromDictionary:dict] doubleValue];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kDuizhengListDataModelsData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kDuizhengListDataModelsCode];

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

    self.data = [aDecoder decodeObjectForKey:kDuizhengListDataModelsData];
    self.code = [aDecoder decodeDoubleForKey:kDuizhengListDataModelsCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kDuizhengListDataModelsData];
    [aCoder encodeDouble:_code forKey:kDuizhengListDataModelsCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    DuizhengListDataModels *copy = [[DuizhengListDataModels alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
