//
//  ClinicListData.h
//
//  Created by 壮 李 on 2016/11/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ClinicListData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *star;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *lon;
@property (nonatomic, strong) NSString *lat;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *scale;
@property (nonatomic, strong) NSString *length;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *ltid;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
