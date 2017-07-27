//
//  FeedBackClassModel.m
//  Medical
//
//  Created by 李壮 on 2016/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "FeedBackClassModel.h"
#import "FeedBackClassDataModel.h"
NSString *const kBaseData = @"data";
NSString *const kBaseCode = @"code";

@interface FeedBackClassModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FeedBackClassModel
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
        NSObject *receivedData = [dict objectForKey:kBaseData];
        NSMutableArray *parsedData = [NSMutableArray array];
        if ([receivedData isKindOfClass:[NSArray class]]) {
            for (NSDictionary *item in (NSArray *)receivedData) {
                if ([item isKindOfClass:[NSDictionary class]]) {
                    [parsedData addObject:[FeedBackClassDataModel modelObjectWithDictionary:item]];
                }
            }
        } else if ([receivedData isKindOfClass:[NSDictionary class]]) {
            [parsedData addObject:[FeedBackClassDataModel modelObjectWithDictionary:(NSDictionary *)receivedData]];
        }
        
        self.data = [NSArray arrayWithArray:parsedData];
        self.code = [[self objectOrNilForKey:kBaseCode fromDictionary:dict] doubleValue];
        
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForData] forKey:kBaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kBaseCode];
    
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
    
    self.data = [aDecoder decodeObjectForKey:kBaseData];
    self.code = [aDecoder decodeDoubleForKey:kBaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_data forKey:kBaseData];
    [aCoder encodeDouble:_code forKey:kBaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeedBackClassModel *copy = [[FeedBackClassModel alloc] init];
    
    if (copy) {
        
        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}
@end
