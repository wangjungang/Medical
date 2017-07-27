//
//  HotListData.h
//
//  Created by 壮 李 on 2016/11/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HotListData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *drugName;
@property (nonatomic, strong) NSString *yid;
@property (nonatomic, strong) NSString *vipstate;
@property (nonatomic, strong) NSString *oldprice;
@property (nonatomic, strong) NSString *hotstate;
@property (nonatomic, strong) NSString *nowprice;
@property (nonatomic, strong) NSString *integralstate;
@property (nonatomic, strong) NSString *cid;
@property (nonatomic, strong) NSString *pictures;
@property (nonatomic, strong) NSString *special;
@property (nonatomic, strong) NSString *specialstate;
@property (nonatomic, strong) NSString *ptid;
@property (nonatomic, strong) NSString *integral;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *effect;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
