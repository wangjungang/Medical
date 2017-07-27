//
//  DuizhengListTitle.h
//
//  Created by 婷 张 on 16/11/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DuizhengListTitle : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *titleIdentifier;
@property (nonatomic, strong) NSString *classfition;
@property (nonatomic, strong) NSString *pid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
