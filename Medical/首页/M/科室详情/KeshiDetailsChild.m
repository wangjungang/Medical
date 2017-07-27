//
//  KeshiDetailsChild.m
//
//  Created by 婷 张 on 16/11/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "KeshiDetailsChild.h"


NSString *const kKeshiDetailsChildPhone = @"phone";
NSString *const kKeshiDetailsChildAddtime = @"addtime";
NSString *const kKeshiDetailsChildPid = @"pid";
NSString *const kKeshiDetailsChildId = @"id";
NSString *const kKeshiDetailsChildBid = @"bid";
NSString *const kKeshiDetailsChildName = @"name";
NSString *const kKeshiDetailsChildInfo = @"info";
NSString *const kKeshiDetailsChildLtid = @"ltid";

@interface KeshiDetailsChild ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation KeshiDetailsChild

@synthesize phone = _phone;
@synthesize addtime = _addtime;
@synthesize pid = _pid;
@synthesize childIdentifier = _childIdentifier;
@synthesize bid = _bid;
@synthesize name = _name;
@synthesize info = _info;
@synthesize ltid = _ltid;

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
            self.phone = [self objectOrNilForKey:kKeshiDetailsChildPhone fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kKeshiDetailsChildAddtime fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kKeshiDetailsChildPid fromDictionary:dict];
            self.childIdentifier = [self objectOrNilForKey:kKeshiDetailsChildId fromDictionary:dict];
            self.bid = [self objectOrNilForKey:kKeshiDetailsChildBid fromDictionary:dict];
            self.name = [self objectOrNilForKey:kKeshiDetailsChildName fromDictionary:dict];
            self.info = [self objectOrNilForKey:kKeshiDetailsChildInfo fromDictionary:dict];
            self.ltid =[self objectOrNilForKey:kKeshiDetailsChildLtid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.phone forKey:kKeshiDetailsChildPhone];
    [mutableDict setValue:self.addtime forKey:kKeshiDetailsChildAddtime];
    [mutableDict setValue:self.pid forKey:kKeshiDetailsChildPid];
    [mutableDict setValue:self.childIdentifier forKey:kKeshiDetailsChildId];
    [mutableDict setValue:self.bid forKey:kKeshiDetailsChildBid];
    [mutableDict setValue:self.name forKey:kKeshiDetailsChildName];
    [mutableDict setValue:self.info forKey:kKeshiDetailsChildInfo];
    [mutableDict setValue:self.ltid forKey:kKeshiDetailsChildLtid];
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

    self.phone = [aDecoder decodeObjectForKey:kKeshiDetailsChildPhone];
    self.addtime = [aDecoder decodeObjectForKey:kKeshiDetailsChildAddtime];
    self.pid = [aDecoder decodeObjectForKey:kKeshiDetailsChildPid];
    self.childIdentifier = [aDecoder decodeObjectForKey:kKeshiDetailsChildId];
    self.bid = [aDecoder decodeObjectForKey:kKeshiDetailsChildBid];
    self.name = [aDecoder decodeObjectForKey:kKeshiDetailsChildName];
    self.info = [aDecoder decodeObjectForKey:kKeshiDetailsChildInfo];
    self.ltid = [aDecoder decodeObjectForKey:kKeshiDetailsChildLtid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_phone forKey:kKeshiDetailsChildPhone];
    [aCoder encodeObject:_addtime forKey:kKeshiDetailsChildAddtime];
    [aCoder encodeObject:_pid forKey:kKeshiDetailsChildPid];
    [aCoder encodeObject:_childIdentifier forKey:kKeshiDetailsChildId];
    [aCoder encodeObject:_bid forKey:kKeshiDetailsChildBid];
    [aCoder encodeObject:_name forKey:kKeshiDetailsChildName];
    [aCoder encodeObject:_info forKey:kKeshiDetailsChildInfo];
    [aCoder encodeObject:_ltid forKey:kKeshiDetailsChildLtid];
}

- (id)copyWithZone:(NSZone *)zone
{
    KeshiDetailsChild *copy = [[KeshiDetailsChild alloc] init];
    
    if (copy) {

        copy.phone = [self.phone copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
        copy.childIdentifier = [self.childIdentifier copyWithZone:zone];
        copy.bid = [self.bid copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.ltid =[ self.ltid copyWithZone:zone];
    }
    return copy;
}


@end
