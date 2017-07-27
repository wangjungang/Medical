//
//  base.m
//
//  Created by 壮 李 on 2016/11/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserInfoBase.h"
#import "UserInfoData.h"


NSString *const kbaseData = @"data";
NSString *const kbaseCode = @"code";


@interface UserInfoBase ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserInfoBase

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
            self.data = [UserInfoData modelObjectWithDictionary:[dict objectForKey:kbaseData][0]];
            self.code = [[self objectOrNilForKey:kbaseCode fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.data dictionaryRepresentation] forKey:kbaseData];
    [mutableDict setValue:[NSNumber numberWithDouble:self.code] forKey:kbaseCode];

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

    self.data = [aDecoder decodeObjectForKey:kbaseData];
    self.code = [aDecoder decodeDoubleForKey:kbaseCode];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_data forKey:kbaseData];
    [aCoder encodeDouble:_code forKey:kbaseCode];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserInfoBase *copy = [[UserInfoBase alloc] init];
    
    if (copy) {

        copy.data = [self.data copyWithZone:zone];
        copy.code = self.code;
    }
    
    return copy;
}


@end
