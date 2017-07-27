//
//  KeshiDetailsData.h
//
//  Created by 婷 张 on 16/11/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KeshiDetailsData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSArray *child;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *info;

@property(nonatomic ,assign) float rowH;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
