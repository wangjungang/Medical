//
//  IntegralbuyshopBase.h
//
//  Created by 婷 张 on 16/11/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IntegralbuyshopData;

@interface IntegralbuyshopBase : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) IntegralbuyshopData *data;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
