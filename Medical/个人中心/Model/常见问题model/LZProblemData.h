//
//  LZProblemData.h
//
//  Created by 壮 李 on 2016/11/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LZProblemData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
