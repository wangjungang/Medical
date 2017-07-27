//
//  HospitalListData.m
//
//  Created by 婷 张 on 16/11/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HospitalListData.h"


NSString *const kHospitalListDataAddtime = @"addtime";
NSString *const kHospitalListDataId = @"id";
NSString *const kHospitalListDataPicture = @"picture";
NSString *const kHospitalListDataName = @"name";


@interface HospitalListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HospitalListData

@synthesize addtime = _addtime;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize picture = _picture;
@synthesize name = _name;


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
            self.addtime = [self objectOrNilForKey:kHospitalListDataAddtime fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kHospitalListDataId fromDictionary:dict];
            self.picture = [self objectOrNilForKey:kHospitalListDataPicture fromDictionary:dict];
            self.name = [self objectOrNilForKey:kHospitalListDataName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.addtime forKey:kHospitalListDataAddtime];
    [mutableDict setValue:self.dataIdentifier forKey:kHospitalListDataId];
    [mutableDict setValue:self.picture forKey:kHospitalListDataPicture];
    [mutableDict setValue:self.name forKey:kHospitalListDataName];

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

    self.addtime = [aDecoder decodeObjectForKey:kHospitalListDataAddtime];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kHospitalListDataId];
    self.picture = [aDecoder decodeObjectForKey:kHospitalListDataPicture];
    self.name = [aDecoder decodeObjectForKey:kHospitalListDataName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_addtime forKey:kHospitalListDataAddtime];
    [aCoder encodeObject:_dataIdentifier forKey:kHospitalListDataId];
    [aCoder encodeObject:_picture forKey:kHospitalListDataPicture];
    [aCoder encodeObject:_name forKey:kHospitalListDataName];
}

- (id)copyWithZone:(NSZone *)zone
{
    HospitalListData *copy = [[HospitalListData alloc] init];
    
    if (copy) {

        copy.addtime = [self.addtime copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.picture = [self.picture copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
