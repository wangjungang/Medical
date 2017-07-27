//
//  FinishShopListBuyData.h
//
//  Created by 婷 张 on 16/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FinishShopListBuyData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *order;
@property (nonatomic, strong) NSArray *product;



+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
