//
//  KeshiDetailsChild.h
//
//  Created by 婷 张 on 16/11/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface KeshiDetailsChild : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *pid;
@property (nonatomic, strong) NSString *childIdentifier;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *info;
@property (nonatomic, strong) NSString *ltid;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
