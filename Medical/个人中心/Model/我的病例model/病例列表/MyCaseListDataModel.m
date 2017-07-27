//
//  MyCaseListDataModel.m
//  Medical
//
//  Created by 李壮 on 2016/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "MyCaseListDataModel.h"
NSString *const kDataDisease = @"disease";
NSString *const kDataDetails = @"details";
NSString *const kDataBid = @"bid";
NSString *const kDataUserName = @"user_name";
@interface MyCaseListDataModel  ()
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end
@implementation MyCaseListDataModel
@synthesize disease = _disease;
@synthesize details = _details;
@synthesize bid = _bid;
@synthesize userName = _userName;
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
        self.disease = [self objectOrNilForKey:kDataDisease fromDictionary:dict];
        self.details = [self objectOrNilForKey:kDataDetails fromDictionary:dict];
        self.bid = [self objectOrNilForKey:kDataBid fromDictionary:dict];
        self.userName = [self objectOrNilForKey:kDataUserName fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.disease forKey:kDataDisease];
    [mutableDict setValue:self.details forKey:kDataDetails];
    [mutableDict setValue:self.bid forKey:kDataBid];
    [mutableDict setValue:self.userName forKey:kDataUserName];
    
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
    
    self.disease = [aDecoder decodeObjectForKey:kDataDisease];
    self.details = [aDecoder decodeObjectForKey:kDataDetails];
    self.bid = [aDecoder decodeObjectForKey:kDataBid];
    self.userName = [aDecoder decodeObjectForKey:kDataUserName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:_disease forKey:kDataDisease];
    [aCoder encodeObject:_details forKey:kDataDetails];
    [aCoder encodeObject:_bid forKey:kDataBid];
    [aCoder encodeObject:_userName forKey:kDataUserName];
}

- (id)copyWithZone:(NSZone *)zone
{
    MyCaseListDataModel *copy = [[MyCaseListDataModel alloc] init];
    
    if (copy) {
        
        copy.disease = [self.disease copyWithZone:zone];
        copy.details = [self.details copyWithZone:zone];
        copy.bid = [self.bid copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
    }
    
    return copy;
}
@end
