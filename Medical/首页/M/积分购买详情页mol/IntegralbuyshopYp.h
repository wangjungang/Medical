//
//  IntegralbuyshopYp.h
//
//  Created by 婷 张 on 16/11/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface IntegralbuyshopYp : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *yid;
@property (nonatomic, strong) NSString *drugName;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *integral;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
