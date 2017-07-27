//
//  Data.h
//
//  Created by 壮 李 on 2016/11/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface UserInfoData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *headerPic;
@property (nonatomic, strong) NSString *jifen;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *money;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
