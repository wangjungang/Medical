//
//  ClinicListData.m
//
//  Created by 壮 李 on 2016/11/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ClinicListData.h"


NSString *const kClinicListDataStar = @"star";
NSString *const kClinicListDataAddtime = @"addtime";
NSString *const kClinicListDataContent = @"content";
NSString *const kClinicListDataId = @"id";
NSString *const kClinicListDataPicture = @"picture";
NSString *const kClinicListDataLon = @"lon";
NSString *const kClinicListDataLat = @"lat";
NSString *const kClinicListDataName = @"name";
NSString *const kClinicListDataScale = @"scale";
NSString *const kClinicListDataLength= @"length";
NSString *const kClinicListDataPhone =@"phone";
NSString *const kClinicListDataLtid =@"ltid";
@interface ClinicListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ClinicListData

@synthesize star = _star;
@synthesize addtime = _addtime;
@synthesize content = _content;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize picture = _picture;
@synthesize lon = _lon;
@synthesize lat = _lat;
@synthesize name = _name;
@synthesize scale = _scale;
@synthesize phone =_phone;
@synthesize length =_length;
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
            self.star = [self objectOrNilForKey:kClinicListDataStar fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kClinicListDataAddtime fromDictionary:dict];
            self.content = [self objectOrNilForKey:kClinicListDataContent fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kClinicListDataId fromDictionary:dict];
            self.picture = [self objectOrNilForKey:kClinicListDataPicture fromDictionary:dict];
            self.lon = [self objectOrNilForKey:kClinicListDataLon fromDictionary:dict];
            self.lat = [self objectOrNilForKey:kClinicListDataLat fromDictionary:dict];
            self.name = [self objectOrNilForKey:kClinicListDataName fromDictionary:dict];
            self.scale = [self objectOrNilForKey:kClinicListDataScale fromDictionary:dict];
            self.length =[self objectOrNilForKey:kClinicListDataLength fromDictionary:dict];
            self.phone =[self objectOrNilForKey:kClinicListDataPhone fromDictionary:dict];
            self.ltid =[self objectOrNilForKey:kClinicListDataLtid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.star forKey:kClinicListDataStar];
    [mutableDict setValue:self.addtime forKey:kClinicListDataAddtime];
    [mutableDict setValue:self.content forKey:kClinicListDataContent];
    [mutableDict setValue:self.dataIdentifier forKey:kClinicListDataId];
    [mutableDict setValue:self.picture forKey:kClinicListDataPicture];
    [mutableDict setValue:self.lon forKey:kClinicListDataLon];
    [mutableDict setValue:self.lat forKey:kClinicListDataLat];
    [mutableDict setValue:self.name forKey:kClinicListDataName];
    [mutableDict setValue:self.scale forKey:kClinicListDataScale];
    [mutableDict setValue:self.length forKey:kClinicListDataLength];
    [mutableDict setValue:self.phone forKey:kClinicListDataPhone];
    [mutableDict setValue:self.ltid forKey:kClinicListDataLtid];
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

    self.star = [aDecoder decodeObjectForKey:kClinicListDataStar];
    self.addtime = [aDecoder decodeObjectForKey:kClinicListDataAddtime];
    self.content = [aDecoder decodeObjectForKey:kClinicListDataContent];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kClinicListDataId];
    self.picture = [aDecoder decodeObjectForKey:kClinicListDataPicture];
    self.lon = [aDecoder decodeObjectForKey:kClinicListDataLon];
    self.lat = [aDecoder decodeObjectForKey:kClinicListDataLat];
    self.name = [aDecoder decodeObjectForKey:kClinicListDataName];
    self.scale = [aDecoder decodeObjectForKey:kClinicListDataScale];
    self.length =[aDecoder decodeObjectForKey:kClinicListDataLength];
    self.phone =[aDecoder decodeObjectForKey:kClinicListDataPhone];
    self.ltid =[aDecoder decodeObjectForKey:kClinicListDataLtid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_star forKey:kClinicListDataStar];
    [aCoder encodeObject:_addtime forKey:kClinicListDataAddtime];
    [aCoder encodeObject:_content forKey:kClinicListDataContent];
    [aCoder encodeObject:_dataIdentifier forKey:kClinicListDataId];
    [aCoder encodeObject:_picture forKey:kClinicListDataPicture];
    [aCoder encodeObject:_lon forKey:kClinicListDataLon];
    [aCoder encodeObject:_lat forKey:kClinicListDataLat];
    [aCoder encodeObject:_name forKey:kClinicListDataName];
    [aCoder encodeObject:_scale forKey:kClinicListDataScale];
    [aCoder encodeObject:_length forKey:kClinicListDataLength];
    [aCoder encodeObject:_phone forKey:kClinicListDataPhone];
    [aCoder encodeObject:_ltid forKey:kClinicListDataLtid];
}

- (id)copyWithZone:(NSZone *)zone
{
    ClinicListData *copy = [[ClinicListData alloc] init];
    
    if (copy) {

        copy.star = [self.star copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.picture = [self.picture copyWithZone:zone];
        copy.lon = [self.lon copyWithZone:zone];
        copy.lat = [self.lat copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.scale = [self.scale copyWithZone:zone];
        copy.length =[self.length copyWithZone:zone];
        copy.ltid =[self.ltid copyWithZone:zone];
    }
    
    return copy;
}


@end
