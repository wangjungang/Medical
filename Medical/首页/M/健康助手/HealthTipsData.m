//
//  HealthTipsData.m
//
//  Created by 婷 张 on 16/11/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HealthTipsData.h"


NSString *const kHealthTipsDataIntro = @"intro";


@interface HealthTipsData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HealthTipsData

@synthesize intro = _intro;


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
            self.intro = [self objectOrNilForKey:kHealthTipsDataIntro fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.intro forKey:kHealthTipsDataIntro];

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

    self.intro = [aDecoder decodeObjectForKey:kHealthTipsDataIntro];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_intro forKey:kHealthTipsDataIntro];
}

- (id)copyWithZone:(NSZone *)zone
{
    HealthTipsData *copy = [[HealthTipsData alloc] init];
    
    if (copy) {

        copy.intro = [self.intro copyWithZone:zone];
    }
    
    return copy;
}


@end
