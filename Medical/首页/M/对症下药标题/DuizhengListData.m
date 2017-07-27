//
//  DuizhengListData.m
//
//  Created by 婷 张 on 16/11/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DuizhengListData.h"
#import "DuizhengListTitle.h"


NSString *const kDuizhengListDataId = @"id";
NSString *const kDuizhengListDataTitle = @"title";
NSString *const kDuizhengListDataClassfition = @"classfition";
NSString *const kDuizhengListDataPid = @"pid";


@interface DuizhengListData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DuizhengListData

@synthesize dataIdentifier = _dataIdentifier;
@synthesize title = _title;
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
            self.dataIdentifier = [self objectOrNilForKey:kDuizhengListDataId fromDictionary:dict];
    NSObject *receivedDuizhengListTitle = [dict objectForKey:kDuizhengListDataTitle];
    NSMutableArray *parsedDuizhengListTitle = [NSMutableArray array];
    if ([receivedDuizhengListTitle isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedDuizhengListTitle) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedDuizhengListTitle addObject:[DuizhengListTitle modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedDuizhengListTitle isKindOfClass:[NSDictionary class]]) {
       [parsedDuizhengListTitle addObject:[DuizhengListTitle modelObjectWithDictionary:(NSDictionary *)receivedDuizhengListTitle]];
    }

    self.title = [NSArray arrayWithArray:parsedDuizhengListTitle];
            self.classfition = [self objectOrNilForKey:kDuizhengListDataClassfition fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kDuizhengListDataPid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.dataIdentifier forKey:kDuizhengListDataId];
    NSMutableArray *tempArrayForTitle = [NSMutableArray array];
    for (NSObject *subArrayObject in self.title) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTitle addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTitle addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTitle] forKey:kDuizhengListDataTitle];
    [mutableDict setValue:self.classfition forKey:kDuizhengListDataClassfition];
    [mutableDict setValue:self.pid forKey:kDuizhengListDataPid];

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

    self.dataIdentifier = [aDecoder decodeObjectForKey:kDuizhengListDataId];
    self.title = [aDecoder decodeObjectForKey:kDuizhengListDataTitle];
    self.classfition = [aDecoder decodeObjectForKey:kDuizhengListDataClassfition];
    self.pid = [aDecoder decodeObjectForKey:kDuizhengListDataPid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_dataIdentifier forKey:kDuizhengListDataId];
    [aCoder encodeObject:_title forKey:kDuizhengListDataTitle];
    [aCoder encodeObject:_classfition forKey:kDuizhengListDataClassfition];
    [aCoder encodeObject:_pid forKey:kDuizhengListDataPid];
}

- (id)copyWithZone:(NSZone *)zone
{
    DuizhengListData *copy = [[DuizhengListData alloc] init];
    
    if (copy) {

        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.title = [self.title copyWithZone:zone];
        copy.classfition = [self.classfition copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
    }
    
    return copy;
}


@end
