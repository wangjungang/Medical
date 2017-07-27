//
//  DuizhengListTitle.m
//
//  Created by 婷 张 on 16/11/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DuizhengListTitle.h"


NSString *const kDuizhengListTitleId = @"id";
NSString *const kDuizhengListTitleClassfition = @"classfition";
NSString *const kDuizhengListTitlePid = @"pid";


@interface DuizhengListTitle ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DuizhengListTitle

@synthesize titleIdentifier = _titleIdentifier;
@synthesize classfition = _classfition;
@synthesize pid = _pid;


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
            self.titleIdentifier = [self objectOrNilForKey:kDuizhengListTitleId fromDictionary:dict];
            self.classfition = [self objectOrNilForKey:kDuizhengListTitleClassfition fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kDuizhengListTitlePid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.titleIdentifier forKey:kDuizhengListTitleId];
    [mutableDict setValue:self.classfition forKey:kDuizhengListTitleClassfition];
    [mutableDict setValue:self.pid forKey:kDuizhengListTitlePid];

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

    self.titleIdentifier = [aDecoder decodeObjectForKey:kDuizhengListTitleId];
    self.classfition = [aDecoder decodeObjectForKey:kDuizhengListTitleClassfition];
    self.pid = [aDecoder decodeObjectForKey:kDuizhengListTitlePid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_titleIdentifier forKey:kDuizhengListTitleId];
    [aCoder encodeObject:_classfition forKey:kDuizhengListTitleClassfition];
    [aCoder encodeObject:_pid forKey:kDuizhengListTitlePid];
}

- (id)copyWithZone:(NSZone *)zone
{
    DuizhengListTitle *copy = [[DuizhengListTitle alloc] init];
    
    if (copy) {

        copy.titleIdentifier = [self.titleIdentifier copyWithZone:zone];
        copy.classfition = [self.classfition copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
    }
    
    return copy;
}


@end
