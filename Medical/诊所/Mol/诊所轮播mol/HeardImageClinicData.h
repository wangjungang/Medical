//
//  HeardImageClinicData.h
//
//  Created by 壮 李 on 2016/11/23
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HeardImageClinicData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *addtime;
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSArray *picture;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *typeid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
