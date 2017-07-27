//
//  HeardImageClinicData.m
//
//  Created by 壮 李 on 2016/11/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HeardImageClinicData.h"


NSString *const kHeardImageClinicDataAddtime = @"addtime";
NSString *const kHeardImageClinicDataId = @"id";
NSString *const kHeardImageClinicDataPicture = @"picture";
NSString *const kHeardImageClinicDataTitle = @"title";
NSString *const kHeardImageClinicDataTypeid = @"typeid";


@interface HeardImageClinicData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HeardImageClinicData

@synthesize addtime = _addtime;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize picture = _picture;
@synthesize title = _title;
@synthesize typeid = _typeid;


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
            self.addtime = [self objectOrNilForKey:kHeardImageClinicDataAddtime fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kHeardImageClinicDataId fromDictionary:dict];
            self.picture = [self objectOrNilForKey:kHeardImageClinicDataPicture fromDictionary:dict];
            self.title = [self objectOrNilForKey:kHeardImageClinicDataTitle fromDictionary:dict];
            self.typeid = [self objectOrNilForKey:kHeardImageClinicDataTypeid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addtime forKey:kHeardImageClinicDataAddtime];
    [mutableDict setValue:self.dataIdentifier forKey:kHeardImageClinicDataId];
    NSMutableArray *tempArrayForPicture = [NSMutableArray array];
    for (NSObject *subArrayObject in self.picture) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPicture addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPicture addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPicture] forKey:kHeardImageClinicDataPicture];
    [mutableDict setValue:self.title forKey:kHeardImageClinicDataTitle];
    [mutableDict setValue:self.typeid forKey:kHeardImageClinicDataTypeid];

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

    self.addtime = [aDecoder decodeObjectForKey:kHeardImageClinicDataAddtime];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kHeardImageClinicDataId];
    self.picture = [aDecoder decodeObjectForKey:kHeardImageClinicDataPicture];
    self.title = [aDecoder decodeObjectForKey:kHeardImageClinicDataTitle];
    self.typeid = [aDecoder decodeObjectForKey:kHeardImageClinicDataTypeid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addtime forKey:kHeardImageClinicDataAddtime];
    [aCoder encodeObject:_dataIdentifier forKey:kHeardImageClinicDataId];
    [aCoder encodeObject:_picture forKey:kHeardImageClinicDataPicture];
    [aCoder encodeObject:_title forKey:kHeardImageClinicDataTitle];
    [aCoder encodeObject:_typeid forKey:kHeardImageClinicDataTypeid];
}

- (id)copyWithZone:(NSZone *)zone
{
    HeardImageClinicData *copy = [[HeardImageClinicData alloc] init];
    
    if (copy) {

        copy.addtime = [self.addtime copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.picture = [self.picture copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.typeid = [self.typeid copyWithZone:zone];
    }
    
    return copy;
}


@end
