//
//  IntegralbuyshopData.h
//
//  Created by 婷 张 on 16/11/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IntegralbuyshopAddress, IntegralbuyshopYp;

@interface IntegralbuyshopData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) IntegralbuyshopAddress *address;
@property (nonatomic, strong) IntegralbuyshopYp *yp;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
