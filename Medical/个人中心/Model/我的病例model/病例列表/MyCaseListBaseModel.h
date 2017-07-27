//
//  MyCaseListBaseModel.h
//  Medical
//
//  Created by 李壮 on 2016/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCaseListBaseModel : NSObject<NSCoding, NSCopying>
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) double code;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
@end
