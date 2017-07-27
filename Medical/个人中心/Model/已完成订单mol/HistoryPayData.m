//
//  HistoryPayData.m
//
//  Created by 壮 李 on 2016/11/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HistoryPayData.h"


NSString *const kHistoryPayDataZtype = @"ztype";
NSString *const kHistoryPayDataOldprice = @"oldprice";
NSString *const kHistoryPayDataVipstate = @"vipstate";
NSString *const kHistoryPayDataOuid = @"ouid";
NSString *const kHistoryPayDataStatus = @"status";
NSString *const kHistoryPayDataSavename = @"savename";
NSString *const kHistoryPayDataOrderAddtime = @"order_addtime";
NSString *const kHistoryPayDataAid = @"aid";
NSString *const kHistoryPayDataInfo = @"info";
NSString *const kHistoryPayDataHotstate = @"hotstate";
NSString *const kHistoryPayDataId = @"id";
NSString *const kHistoryPayDataSprice = @"sprice";
NSString *const kHistoryPayDataCid = @"cid";
NSString *const kHistoryPayDataUid = @"uid";
NSString *const kHistoryPayDataAddtime = @"addtime";
NSString *const kHistoryPayDataMobile = @"mobile";
NSString *const kHistoryPayDataNumber = @"number";
NSString *const kHistoryPayDataEffect = @"effect";
NSString *const kHistoryPayDataArea = @"area";
NSString *const kHistoryPayDataPtid = @"ptid";
NSString *const kHistoryPayDataPictures = @"pictures";
NSString *const kHistoryPayDataPid = @"pid";
NSString *const kHistoryPayDataDrugName = @"drug_name";
NSString *const kHistoryPayDataOrder = @"order";
NSString *const kHistoryPayDataYid = @"yid";
NSString *const kHistoryPayDataNowprice = @"nowprice";
NSString *const kHistoryPayDataAddress = @"address";
NSString *const kHistoryPayDataName=@"name";
NSString *const kHistoryPayDataPicture=@"picture";
NSString *const kHistoryPayDataOid=@"oid";
NSString *const kHistoryPayDataGname=@"gname";
NSString *const kHistoryPayDataGid=@"gid";
@interface HistoryPayData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HistoryPayData

@synthesize ztype = _ztype;
@synthesize oldprice = _oldprice;
@synthesize vipstate = _vipstate;
@synthesize ouid = _ouid;
@synthesize status = _status;
@synthesize savename = _savename;
@synthesize orderAddtime = _orderAddtime;
@synthesize aid = _aid;
@synthesize info = _info;
@synthesize hotstate = _hotstate;
@synthesize dataIdentifier = _dataIdentifier;
@synthesize sprice = _sprice;
@synthesize cid = _cid;
@synthesize uid = _uid;
@synthesize addtime = _addtime;
@synthesize mobile = _mobile;
@synthesize number = _number;
@synthesize effect = _effect;
@synthesize area = _area;
@synthesize ptid = _ptid;
@synthesize pictures = _pictures;
@synthesize pid = _pid;
@synthesize drugName = _drugName;
@synthesize order = _order;
@synthesize yid = _yid;
@synthesize nowprice = _nowprice;
@synthesize address = _address;
@synthesize name =_name;
@synthesize picture =_picture;
@synthesize oid = _oid;
@synthesize gname=_gname;
@synthesize gid  =_gid;
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
            self.ztype = [self objectOrNilForKey:kHistoryPayDataZtype fromDictionary:dict];
            self.oldprice = [self objectOrNilForKey:kHistoryPayDataOldprice fromDictionary:dict];
            self.vipstate = [self objectOrNilForKey:kHistoryPayDataVipstate fromDictionary:dict];
            self.ouid = [self objectOrNilForKey:kHistoryPayDataOuid fromDictionary:dict];
            self.status = [self objectOrNilForKey:kHistoryPayDataStatus fromDictionary:dict];
            self.savename = [self objectOrNilForKey:kHistoryPayDataSavename fromDictionary:dict];
            self.orderAddtime = [self objectOrNilForKey:kHistoryPayDataOrderAddtime fromDictionary:dict];
            self.aid = [self objectOrNilForKey:kHistoryPayDataAid fromDictionary:dict];
            self.info = [self objectOrNilForKey:kHistoryPayDataInfo fromDictionary:dict];
            self.hotstate = [self objectOrNilForKey:kHistoryPayDataHotstate fromDictionary:dict];
            self.dataIdentifier = [self objectOrNilForKey:kHistoryPayDataId fromDictionary:dict];
            self.sprice = [self objectOrNilForKey:kHistoryPayDataSprice fromDictionary:dict];
            self.cid = [self objectOrNilForKey:kHistoryPayDataCid fromDictionary:dict];
            self.uid = [self objectOrNilForKey:kHistoryPayDataUid fromDictionary:dict];
            self.addtime = [self objectOrNilForKey:kHistoryPayDataAddtime fromDictionary:dict];
            self.mobile = [self objectOrNilForKey:kHistoryPayDataMobile fromDictionary:dict];
            self.number = [self objectOrNilForKey:kHistoryPayDataNumber fromDictionary:dict];
            self.effect = [self objectOrNilForKey:kHistoryPayDataEffect fromDictionary:dict];
            self.area = [self objectOrNilForKey:kHistoryPayDataArea fromDictionary:dict];
            self.ptid = [self objectOrNilForKey:kHistoryPayDataPtid fromDictionary:dict];
            self.pictures = [self objectOrNilForKey:kHistoryPayDataPictures fromDictionary:dict];
            self.pid = [self objectOrNilForKey:kHistoryPayDataPid fromDictionary:dict];
            self.drugName = [self objectOrNilForKey:kHistoryPayDataDrugName fromDictionary:dict];
            self.order = [self objectOrNilForKey:kHistoryPayDataOrder fromDictionary:dict];
            self.yid = [self objectOrNilForKey:kHistoryPayDataYid fromDictionary:dict];
            self.nowprice = [self objectOrNilForKey:kHistoryPayDataNowprice fromDictionary:dict];
            self.address = [self objectOrNilForKey:kHistoryPayDataAddress fromDictionary:dict];
        self.name =[self objectOrNilForKey:kHistoryPayDataName fromDictionary:dict];
        self.picture =[self objectOrNilForKey:kHistoryPayDataPicture fromDictionary:dict];
        self.oid=[self objectOrNilForKey:kHistoryPayDataOid fromDictionary:dict];
        self.gname=[self objectOrNilForKey:kHistoryPayDataGname fromDictionary:dict];
        self.gid=[self objectOrNilForKey:kHistoryPayDataGid fromDictionary:dict];
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.ztype forKey:kHistoryPayDataZtype];
    [mutableDict setValue:self.oldprice forKey:kHistoryPayDataOldprice];
    [mutableDict setValue:self.vipstate forKey:kHistoryPayDataVipstate];
    [mutableDict setValue:self.ouid forKey:kHistoryPayDataOuid];
    [mutableDict setValue:self.status forKey:kHistoryPayDataStatus];
    [mutableDict setValue:self.savename forKey:kHistoryPayDataSavename];
    [mutableDict setValue:self.orderAddtime forKey:kHistoryPayDataOrderAddtime];
    [mutableDict setValue:self.aid forKey:kHistoryPayDataAid];
    [mutableDict setValue:self.info forKey:kHistoryPayDataInfo];
    [mutableDict setValue:self.hotstate forKey:kHistoryPayDataHotstate];
    [mutableDict setValue:self.dataIdentifier forKey:kHistoryPayDataId];
    [mutableDict setValue:self.sprice forKey:kHistoryPayDataSprice];
    [mutableDict setValue:self.cid forKey:kHistoryPayDataCid];
    [mutableDict setValue:self.uid forKey:kHistoryPayDataUid];
    [mutableDict setValue:self.addtime forKey:kHistoryPayDataAddtime];
    [mutableDict setValue:self.mobile forKey:kHistoryPayDataMobile];
    [mutableDict setValue:self.number forKey:kHistoryPayDataNumber];
    [mutableDict setValue:self.effect forKey:kHistoryPayDataEffect];
    [mutableDict setValue:self.area forKey:kHistoryPayDataArea];
    [mutableDict setValue:self.ptid forKey:kHistoryPayDataPtid];
    [mutableDict setValue:self.pictures forKey:kHistoryPayDataPictures];
    [mutableDict setValue:self.pid forKey:kHistoryPayDataPid];
    [mutableDict setValue:self.drugName forKey:kHistoryPayDataDrugName];
    [mutableDict setValue:self.order forKey:kHistoryPayDataOrder];
    [mutableDict setValue:self.yid forKey:kHistoryPayDataYid];
    [mutableDict setValue:self.nowprice forKey:kHistoryPayDataNowprice];
    [mutableDict setValue:self.address forKey:kHistoryPayDataAddress];
    [mutableDict setValue:self.name forKey:kHistoryPayDataName];
    [mutableDict setValue:self.name  forKey:kHistoryPayDataPicture];
    [mutableDict setValue:self.oid forKey:kHistoryPayDataOid];
    [mutableDict setValue:self.gname forKey:kHistoryPayDataGname];
    [mutableDict setValue:self.gid forKey:kHistoryPayDataGid];
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

    self.ztype = [aDecoder decodeObjectForKey:kHistoryPayDataZtype];
    self.oldprice = [aDecoder decodeObjectForKey:kHistoryPayDataOldprice];
    self.vipstate = [aDecoder decodeObjectForKey:kHistoryPayDataVipstate];
    self.ouid = [aDecoder decodeObjectForKey:kHistoryPayDataOuid];
    self.status = [aDecoder decodeObjectForKey:kHistoryPayDataStatus];
    self.savename = [aDecoder decodeObjectForKey:kHistoryPayDataSavename];
    self.orderAddtime = [aDecoder decodeObjectForKey:kHistoryPayDataOrderAddtime];
    self.aid = [aDecoder decodeObjectForKey:kHistoryPayDataAid];
    self.info = [aDecoder decodeObjectForKey:kHistoryPayDataInfo];
    self.hotstate = [aDecoder decodeObjectForKey:kHistoryPayDataHotstate];
    self.dataIdentifier = [aDecoder decodeObjectForKey:kHistoryPayDataId];
    self.sprice = [aDecoder decodeObjectForKey:kHistoryPayDataSprice];
    self.cid = [aDecoder decodeObjectForKey:kHistoryPayDataCid];
    self.uid = [aDecoder decodeObjectForKey:kHistoryPayDataUid];
    self.addtime = [aDecoder decodeObjectForKey:kHistoryPayDataAddtime];
    self.mobile = [aDecoder decodeObjectForKey:kHistoryPayDataMobile];
    self.number = [aDecoder decodeObjectForKey:kHistoryPayDataNumber];
    self.effect = [aDecoder decodeObjectForKey:kHistoryPayDataEffect];
    self.area = [aDecoder decodeObjectForKey:kHistoryPayDataArea];
    self.ptid = [aDecoder decodeObjectForKey:kHistoryPayDataPtid];
    self.pictures = [aDecoder decodeObjectForKey:kHistoryPayDataPictures];
    self.pid = [aDecoder decodeObjectForKey:kHistoryPayDataPid];
    self.drugName = [aDecoder decodeObjectForKey:kHistoryPayDataDrugName];
    self.order = [aDecoder decodeObjectForKey:kHistoryPayDataOrder];
    self.yid = [aDecoder decodeObjectForKey:kHistoryPayDataYid];
    self.nowprice = [aDecoder decodeObjectForKey:kHistoryPayDataNowprice];
    self.address = [aDecoder decodeObjectForKey:kHistoryPayDataAddress];
    self.name =[aDecoder decodeObjectForKey:kHistoryPayDataName];
    self.picture =[aDecoder decodeObjectForKey:kHistoryPayDataPicture];
    self.oid=[aDecoder decodeObjectForKey:kHistoryPayDataOid];
    self.gname=[aDecoder decodeObjectForKey:kHistoryPayDataGname];
    self.gid=[aDecoder decodeObjectForKey:kHistoryPayDataGid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_ztype forKey:kHistoryPayDataZtype];
    [aCoder encodeObject:_oldprice forKey:kHistoryPayDataOldprice];
    [aCoder encodeObject:_vipstate forKey:kHistoryPayDataVipstate];
    [aCoder encodeObject:_ouid forKey:kHistoryPayDataOuid];
    [aCoder encodeObject:_status forKey:kHistoryPayDataStatus];
    [aCoder encodeObject:_savename forKey:kHistoryPayDataSavename];
    [aCoder encodeObject:_orderAddtime forKey:kHistoryPayDataOrderAddtime];
    [aCoder encodeObject:_aid forKey:kHistoryPayDataAid];
    [aCoder encodeObject:_info forKey:kHistoryPayDataInfo];
    [aCoder encodeObject:_hotstate forKey:kHistoryPayDataHotstate];
    [aCoder encodeObject:_dataIdentifier forKey:kHistoryPayDataId];
    [aCoder encodeObject:_sprice forKey:kHistoryPayDataSprice];
    [aCoder encodeObject:_cid forKey:kHistoryPayDataCid];
    [aCoder encodeObject:_uid forKey:kHistoryPayDataUid];
    [aCoder encodeObject:_addtime forKey:kHistoryPayDataAddtime];
    [aCoder encodeObject:_mobile forKey:kHistoryPayDataMobile];
    [aCoder encodeObject:_number forKey:kHistoryPayDataNumber];
    [aCoder encodeObject:_effect forKey:kHistoryPayDataEffect];
    [aCoder encodeObject:_area forKey:kHistoryPayDataArea];
    [aCoder encodeObject:_ptid forKey:kHistoryPayDataPtid];
    [aCoder encodeObject:_pictures forKey:kHistoryPayDataPictures];
    [aCoder encodeObject:_pid forKey:kHistoryPayDataPid];
    [aCoder encodeObject:_drugName forKey:kHistoryPayDataDrugName];
    [aCoder encodeObject:_order forKey:kHistoryPayDataOrder];
    [aCoder encodeObject:_yid forKey:kHistoryPayDataYid];
    [aCoder encodeObject:_nowprice forKey:kHistoryPayDataNowprice];
    [aCoder encodeObject:_address forKey:kHistoryPayDataAddress];
    [aCoder encodeObject:_name forKey:kHistoryPayDataName];
    [aCoder encodeObject:_picture forKey:kHistoryPayDataPicture];
    [aCoder encodeObject:_oid forKey:kHistoryPayDataOid];
    [aCoder encodeObject:_gname forKey:kHistoryPayDataGname];
    [aCoder encodeObject:_gid forKey:kHistoryPayDataGid];
}

- (id)copyWithZone:(NSZone *)zone
{
    HistoryPayData *copy = [[HistoryPayData alloc] init];
    
    if (copy) {

        copy.ztype = [self.ztype copyWithZone:zone];
        copy.oldprice = [self.oldprice copyWithZone:zone];
        copy.vipstate = [self.vipstate copyWithZone:zone];
        copy.ouid = [self.ouid copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.savename = [self.savename copyWithZone:zone];
        copy.orderAddtime = [self.orderAddtime copyWithZone:zone];
        copy.aid = [self.aid copyWithZone:zone];
        copy.info = [self.info copyWithZone:zone];
        copy.hotstate = [self.hotstate copyWithZone:zone];
        copy.dataIdentifier = [self.dataIdentifier copyWithZone:zone];
        copy.sprice = [self.sprice copyWithZone:zone];
        copy.cid = [self.cid copyWithZone:zone];
        copy.uid = [self.uid copyWithZone:zone];
        copy.addtime = [self.addtime copyWithZone:zone];
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.number = [self.number copyWithZone:zone];
        copy.effect = [self.effect copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.ptid = [self.ptid copyWithZone:zone];
        copy.pictures = [self.pictures copyWithZone:zone];
        copy.pid = [self.pid copyWithZone:zone];
        copy.drugName = [self.drugName copyWithZone:zone];
        copy.order = [self.order copyWithZone:zone];
        copy.yid = [self.yid copyWithZone:zone];
        copy.nowprice = [self.nowprice copyWithZone:zone];
        copy.address = [self.address copyWithZone:zone];
        copy.name =[self.name copyWithZone:zone];
        copy.picture =[self.picture copyWithZone:zone];
        copy.oid=[self.oid copyWithZone:zone];
        copy.gname=[self.gname copyWithZone:zone];
        copy.gid=[self.gid copyWithZone:zone];
    }
    
    return copy;
}


@end
