//
//  HealthTipsData.h
//
//  Created by 婷 张 on 16/11/30
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HealthTipsData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *intro;
    @property(nonatomic,assign)float rowH;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
