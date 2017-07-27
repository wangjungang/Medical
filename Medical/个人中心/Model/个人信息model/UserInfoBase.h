//
//  base.h
//
//  Created by 壮 李 on 2016/11/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserInfoData;

@interface UserInfoBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) UserInfoData *data;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
