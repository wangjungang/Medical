//
//  HeardImageClinicBase.h
//
//  Created by 壮 李 on 2016/11/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HeardImageClinicData;

@interface HeardImageClinicBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) HeardImageClinicData *data;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
