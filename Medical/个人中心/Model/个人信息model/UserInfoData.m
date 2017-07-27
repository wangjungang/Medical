//
//  Data.m
//
//  Created by 壮 李 on 2016/11/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserInfoData.h"


NSString *const kDataNickName = @"nick_name";
NSString *const kDataMobile = @"mobile";
NSString *const kDataLevel = @"level";
NSString *const kDataBirthday = @"birthday";
NSString *const kDataRealName = @"real_name";
NSString *const kDataHeaderPic = @"header_pic";
NSString *const kDataJifen = @"jifen";
NSString *const kDataSex = @"sex";
NSString *const kDataMoney = @"money";


@interface UserInfoData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserInfoData

@synthesize nickName = _nickName;
@synthesize mobile = _mobile;
@synthesize level = _level;
@synthesize birthday = _birthday;
@synthesize realName = _realName;
@synthesize headerPic = _headerPic;
@synthesize jifen = _jifen;
@synthesize sex = _sex;
@synthesize money = _money;


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
            self.nickName = [self objectOrNilForKey:kDataNickName fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kDataMobile fromDictionary:dict];
            self.level = [self objectOrNilForKey:kDataLevel fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kDataBirthday fromDictionary:dict];
            self.realName = [self objectOrNilForKey:kDataRealName fromDictionary:dict];
            self.headerPic = [self objectOrNilForKey:kDataHeaderPic fromDictionary:dict];
            self.jifen = [self objectOrNilForKey:kDataJifen fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kDataSex fromDictionary:dict];
            self.money = [self objectOrNilForKey:kDataMoney fromDictionary:dict];

    }
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.nickName forKey:kDataNickName];
    [mutableDict setValue:self.mobile forKey:kDataMobile];
    [mutableDict setValue:self.level forKey:kDataLevel];
    [mutableDict setValue:self.birthday forKey:kDataBirthday];
    [mutableDict setValue:self.realName forKey:kDataRealName];
    [mutableDict setValue:self.headerPic forKey:kDataHeaderPic];
    [mutableDict setValue:self.jifen forKey:kDataJifen];
    [mutableDict setValue:self.sex forKey:kDataSex];
    [mutableDict setValue:self.money forKey:kDataMoney];

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

    self.nickName = [aDecoder decodeObjectForKey:kDataNickName];
    self.mobile = [aDecoder decodeObjectForKey:kDataMobile];
    self.level = [aDecoder decodeObjectForKey:kDataLevel];
    self.birthday = [aDecoder decodeObjectForKey:kDataBirthday];
    self.realName = [aDecoder decodeObjectForKey:kDataRealName];
    self.headerPic = [aDecoder decodeObjectForKey:kDataHeaderPic];
    self.jifen = [aDecoder decodeObjectForKey:kDataJifen];
    self.sex = [aDecoder decodeObjectForKey:kDataSex];
    self.money = [aDecoder decodeObjectForKey:kDataMoney];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_nickName forKey:kDataNickName];
    [aCoder encodeObject:_mobile forKey:kDataMobile];
    [aCoder encodeObject:_level forKey:kDataLevel];
    [aCoder encodeObject:_birthday forKey:kDataBirthday];
    [aCoder encodeObject:_realName forKey:kDataRealName];
    [aCoder encodeObject:_headerPic forKey:kDataHeaderPic];
    [aCoder encodeObject:_jifen forKey:kDataJifen];
    [aCoder encodeObject:_sex forKey:kDataSex];
    [aCoder encodeObject:_money forKey:kDataMoney];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserInfoData *copy = [[UserInfoData alloc] init];
    
    if (copy) {

        copy.nickName = [self.nickName copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.level = [self.level copyWithZone:zone];
        copy.birthday = [self.birthday copyWithZone:zone];
        copy.realName = [self.realName copyWithZone:zone];
        copy.headerPic = [self.headerPic copyWithZone:zone];
        copy.jifen = [self.jifen copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.money = [self.money copyWithZone:zone];
    }
    
    return copy;
}


@end
