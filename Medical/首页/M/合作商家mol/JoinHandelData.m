//
//  JoinHandelData.m
//
//  Created by 壮 李 on 2016/11/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "JoinHandelData.h"


NSString *const kJoinHandelDataName = @"name";
NSString *const kJoinHandelDataPicture = @"picture";
NSString *const kJoinHandelDataType = @"type";
NSString *const kJoinHandelDataId = @"id";

@interface JoinHandelData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JoinHandelData

@synthesize name = _name;
@synthesize picture = _picture;
@synthesize type = _type;
@synthesize Identifier =_Identifier;

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
            self.name = [self objectOrNilForKey:kJoinHandelDataName fromDictionary:dict];
            self.picture = [self objectOrNilForKey:kJoinHandelDataPicture fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kJoinHandelDataType fromDictionary:dict] doubleValue];
            self.Identifier =[self objectOrNilForKey:kJoinHandelDataId fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.name forKey:kJoinHandelDataName];
    [mutableDict setValue:self.picture forKey:kJoinHandelDataPicture];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kJoinHandelDataType];
    [mutableDict setValue:self.Identifier forKey:kJoinHandelDataId];

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

    self.name = [aDecoder decodeObjectForKey:kJoinHandelDataName];
    self.picture = [aDecoder decodeObjectForKey:kJoinHandelDataPicture];
    self.type = [aDecoder decodeDoubleForKey:kJoinHandelDataType];
    self.Identifier =[aDecoder decodeObjectForKey:kJoinHandelDataId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_name forKey:kJoinHandelDataName];
    [aCoder encodeObject:_picture forKey:kJoinHandelDataPicture];
    [aCoder encodeDouble:_type forKey:kJoinHandelDataType];
    [aCoder encodeObject:_Identifier forKey:kJoinHandelDataId];
}

- (id)copyWithZone:(NSZone *)zone
{
    JoinHandelData *copy = [[JoinHandelData alloc] init];
    
    if (copy) {

        copy.name = [self.name copyWithZone:zone];
        copy.picture = [self.picture copyWithZone:zone];
        copy.type = self.type;
        copy.Identifier =[self.Identifier copyWithZone:zone];
    }
    return copy;
}


@end
