//
//  FeedBackClassDataModel.m
//  Medical
//
//  Created by 李壮 on 2016/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "FeedBackClassDataModel.h"


@interface FeedBackClassDataModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end
@implementation FeedBackClassDataModel
@synthesize dataIdentifier = _dataIdentifier;
@synthesize typeName = _typename;
//#define kDataId @"id"
//#define kDataTypename @"typename"
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
        self.dataIdentifier = [self objectOrNilForKey:@"id" fromDictionary:dict];
        self.typeName = [self objectOrNilForKey:@"typename" fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dataIdentifier forKey:@"id"];
    [mutableDict setValue:self.typeName forKey:@"typename"];
    
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
    
    self.dataIdentifier = [aDecoder decodeObjectForKey:@"id"];
    self.typeName = [aDecoder decodeObjectForKey:@"typename"];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_dataIdentifier forKey:@"id"];
    [aCoder encodeObject:_typename forKey:@"typename"];
}

- (id)copyWithZone:(NSZone *)zone
{
    FeedBackClassDataModel *copy = [[FeedBackClassDataModel alloc] init];
    
    if (copy) {
        
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.typeName= [self.typeName copyWithZone:zone];
    }
    
    return copy;
}

@end
