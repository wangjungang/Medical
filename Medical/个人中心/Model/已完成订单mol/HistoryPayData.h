//
//  HistoryPayData.h
//
//  Created by 壮 李 on 2016/11/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HistoryPayData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *ztype;
@property (nonatomic, strong) NSString *oldprice;
@property (nonatomic, strong) NSString *vipstate;
@property (nonatomic, strong) NSString *ouid;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *savename;
@property (nonatomic, strong) NSString *orderAddtime;
@property (nonatomic, strong) NSString *aid;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *hotstate;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *sprice;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *effect;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *ptid;
@property (nonatomic, strong) NSString *pictures;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *drugName;
@property (nonatomic, strong) NSString *order;
@property (nonatomic, strong) NSString *yid;
@property (nonatomic, strong) NSString *nowprice;
@property (nonatomic, strong) NSString *address;
@property (nonatomic,strong)  NSString *name;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *oid;
@property (nonatomic, strong) NSString *gname;
@property (nonatomic, strong) NSString *gid;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
