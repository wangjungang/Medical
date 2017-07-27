//
//  UserHeaderUser.m
//
//  Created by 壮 李 on 2016/12/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserHeaderUser.h"


NSString *const kUserHeaderUserNickName = @"nick_name";
NSString *const kUserHeaderUserHeaderPic = @"header_pic";
NSString *const kUserHeaderUserUid = @"uid";


@interface UserHeaderUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserHeaderUser

@synthesize nickName = _nickName;
@synthesize headerPic = _headerPic;
@synthesize uid = _uid;


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
            self.nickName = [self objectOrNilForKey:kUserHeaderUserNickName fromDictionary:dict];
            self.headerPic = [self objectOrNilForKey:kUserHeaderUserHeaderPic fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kUserHeaderUserUid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kUserHeaderUserNickName];
    [mutableDict setValue:self.headerPic forKey:kUserHeaderUserHeaderPic];
    [mutableDict setValue:self.uid forKey:kUserHeaderUserUid];

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

    self.nickName = [aDecoder decodeObjectForKey:kUserHeaderUserNickName];
    self.headerPic = [aDecoder decodeObjectForKey:kUserHeaderUserHeaderPic];
    self.uid = [aDecoder decodeObjectForKey:kUserHeaderUserUid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kUserHeaderUserNickName];
    [aCoder encodeObject:_headerPic forKey:kUserHeaderUserHeaderPic];
    [aCoder encodeObject:_uid forKey:kUserHeaderUserUid];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserHeaderUser *copy = [[UserHeaderUser alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.headerPic = [self.headerPic copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
    }
    
    return copy;
}


@end
