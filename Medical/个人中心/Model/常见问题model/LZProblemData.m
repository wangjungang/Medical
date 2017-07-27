//
//  LZProblemData.m
//
//  Created by 壮 李 on 2016/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LZProblemData.h"


NSString *const kLZProblemDataAddtime = @"addtime";
NSString *const kLZProblemDataId = @"id";
NSString *const kLZProblemDataTitle = @"title";
NSString *const kLZProblemDataContent = @"content";


@interface LZProblemData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LZProblemData

@synthesize addtime = _addtime;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize title = _title;
@synthesize content = _content;


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
            self.addtime = [self objectOrNilForKey:kLZProblemDataAddtime fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kLZProblemDataId fromDictionary:dict];
            self.title = [self objectOrNilForKey:kLZProblemDataTitle fromDictionary:dict];
            self.content = [self objectOrNilForKey:kLZProblemDataContent fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addtime forKey:kLZProblemDataAddtime];
    [mutableDict setValue:self.dataIdentifier forKey:kLZProblemDataId];
    [mutableDict setValue:self.title forKey:kLZProblemDataTitle];
    [mutableDict setValue:self.content forKey:kLZProblemDataContent];

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

    self.addtime = [aDecoder decodeObjectForKey:kLZProblemDataAddtime];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kLZProblemDataId];
    self.title = [aDecoder decodeObjectForKey:kLZProblemDataTitle];
    self.content = [aDecoder decodeObjectForKey:kLZProblemDataContent];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addtime forKey:kLZProblemDataAddtime];
    [aCoder encodeObject:_dataIdentifier forKey:kLZProblemDataId];
    [aCoder encodeObject:_title forKey:kLZProblemDataTitle];
    [aCoder encodeObject:_content forKey:kLZProblemDataContent];
}

- (id)copyWithZone:(NSZone *)zone
{
    LZProblemData *copy = [[LZProblemData alloc] init];
    
    if (copy) {

        copy.addtime = [self.addtime copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
    }
    
    return copy;
}


@end
