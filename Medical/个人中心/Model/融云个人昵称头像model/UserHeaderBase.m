//
//  UserHeaderBase.m
//
//  Created by 壮 李 on 2016/12/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserHeaderBase.h"
#import "UserHeaderUser.h"


NSString *const kUserHeaderBaseUser = @"user";


@interface UserHeaderBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserHeaderBase

@synthesize user = _user;


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
            self.user = [UserHeaderUser modelObjectWithDictionary:[dict objectForKey:kUserHeaderBaseUser]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kUserHeaderBaseUser];

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

    self.user = [aDecoder decodeObjectForKey:kUserHeaderBaseUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_user forKey:kUserHeaderBaseUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserHeaderBase *copy = [[UserHeaderBase alloc] init];
    
    if (copy) {

        copy.user = [self.user copyWithZone:zone];
    }
    
    return copy;
}


@end
