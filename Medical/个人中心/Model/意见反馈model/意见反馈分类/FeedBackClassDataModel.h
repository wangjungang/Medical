//
//  FeedBackClassDataModel.h
//  Medical
//
//  Created by 李壮 on 2016/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedBackClassDataModel : NSObject<NSCoding,NSCopying>
@property (nonatomic, strong) NSString *dataIdentifier;
@property (nonatomic, strong) NSString *typeName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
@end
