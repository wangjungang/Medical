//
//  IntegralbuyshopAddress.h
//
//  Created by 婷 张 on 16/11/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface IntegralbuyshopAddress : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *addressIdentifier;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *savename;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *area;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
