//
//  UserHeaderBase.h
//
//  Created by 壮 李 on 2016/12/1
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserHeaderUser;

@interface UserHeaderBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) UserHeaderUser *user;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
