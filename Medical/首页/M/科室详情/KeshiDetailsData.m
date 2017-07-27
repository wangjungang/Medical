//
//  KeshiDetailsData.m
//
//  Created by 婷 张 on 16/11/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "KeshiDetailsData.h"
#import "KeshiDetailsChild.h"


NSString *const kKeshiDetailsDataPhone = @"phone";
NSString *const kKeshiDetailsDataAddtime = @"addtime";
NSString *const kKeshiDetailsDataPid = @"pid";
NSString *const kKeshiDetailsDataId = @"id";
NSString *const kKeshiDetailsDataChild = @"child";
NSString *const kKeshiDetailsDataBid = @"bid";
NSString *const kKeshiDetailsDataName = @"name";
NSString *const kKeshiDetailsDataInfo = @"info";

@interface KeshiDetailsData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KeshiDetailsData

@synthesize phone = _phone;
@synthesize addtime = _addtime;
@synthesize pid = _pid;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize child = _child;
@synthesize bid = _bid;
@synthesize name = _name;
@synthesize info = _info;

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
            self.phone = [self objectOrNilForKey:kKeshiDetailsDataPhone fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kKeshiDetailsDataAddtime fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kKeshiDetailsDataPid fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kKeshiDetailsDataId fromDictionary:dict];
    NSObject *receivedKeshiDetailsChild = [dict objectForKey:kKeshiDetailsDataChild];
    NSMutableArray *parsedKeshiDetailsChild = [NSMutableArray array];
    if ([receivedKeshiDetailsChild isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedKeshiDetailsChild) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedKeshiDetailsChild addObject:[KeshiDetailsChild modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedKeshiDetailsChild isKindOfClass:[NSDictionary class]]) {
       [parsedKeshiDetailsChild addObject:[KeshiDetailsChild modelObjectWithDictionary:(NSDictionary *)receivedKeshiDetailsChild]];
    }

    self.child = [NSArray arrayWithArray:parsedKeshiDetailsChild];
            self.bid = [self objectOrNilForKey:kKeshiDetailsDataBid fromDictionary:dict];
            self.name = [self objectOrNilForKey:kKeshiDetailsDataName fromDictionary:dict];
            self.info = [self objectOrNilForKey:kKeshiDetailsDataInfo fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.phone forKey:kKeshiDetailsDataPhone];
    [mutableDict setValue:self.addtime forKey:kKeshiDetailsDataAddtime];
    [mutableDict setValue:self.pid forKey:kKeshiDetailsDataPid];
    [mutableDict setValue:self.dataIdentifier forKey:kKeshiDetailsDataId];
    NSMutableArray *tempArrayForChild = [NSMutableArray array];
    for (NSObject *subArrayObject in self.child) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForChild addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForChild addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChild] forKey:kKeshiDetailsDataChild];
    [mutableDict setValue:self.bid forKey:kKeshiDetailsDataBid];
    [mutableDict setValue:self.name forKey:kKeshiDetailsDataName];
    [mutableDict setValue:self.info forKey:kKeshiDetailsDataInfo];
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

    self.phone = [aDecoder decodeObjectForKey:kKeshiDetailsDataPhone];
    self.addtime = [aDecoder decodeObjectForKey:kKeshiDetailsDataAddtime];
    self.pid = [aDecoder decodeObjectForKey:kKeshiDetailsDataPid];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kKeshiDetailsDataId];
    self.child = [aDecoder decodeObjectForKey:kKeshiDetailsDataChild];
    self.bid = [aDecoder decodeObjectForKey:kKeshiDetailsDataBid];
    self.name = [aDecoder decodeObjectForKey:kKeshiDetailsDataName];
    self.info = [aDecoder decodeObjectForKey:kKeshiDetailsDataInfo];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_phone forKey:kKeshiDetailsDataPhone];
    [aCoder encodeObject:_addtime forKey:kKeshiDetailsDataAddtime];
    [aCoder encodeObject:_pid forKey:kKeshiDetailsDataPid];
    [aCoder encodeObject:_dataIdentifier forKey:kKeshiDetailsDataId];
    [aCoder encodeObject:_child forKey:kKeshiDetailsDataChild];
    [aCoder encodeObject:_bid forKey:kKeshiDetailsDataBid];
    [aCoder encodeObject:_name forKey:kKeshiDetailsDataName];
    [aCoder encodeObject:_info forKey:kKeshiDetailsDataInfo];
}

- (id)copyWithZone:(NSZone *)zone
{
    KeshiDetailsData *copy = [[KeshiDetailsData alloc] init];
    
    if (copy) {

        copy.phone = [self.phone copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.child = [self.child copyWithZone:zone];
        copy.bid = [self.bid copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
    }
    
    return copy;
}


@end
