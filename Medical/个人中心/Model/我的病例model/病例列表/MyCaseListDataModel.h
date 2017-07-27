//
//  MyCaseListDataModel.h
//  Medical
//
//  Created by 李壮 on 2016/11/15.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCaseListDataModel : NSObject<NSCoding, NSCopying>
@property (nonatomic, strong) NSString *disease;
@property (nonatomic, strong) NSString *details;
@property (nonatomic, strong) NSString *bid;
@property (nonatomic, strong) NSString *userName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
@end
