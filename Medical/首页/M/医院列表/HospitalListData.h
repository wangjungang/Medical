//
//  HospitalListData.h
//
//  Created by 婷 张 on 16/11/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HospitalListData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *picture;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
