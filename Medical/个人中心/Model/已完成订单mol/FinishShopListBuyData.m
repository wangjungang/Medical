//
//  FinishShopListBuyData.m
//
//  Created by 婷 张 on 16/12/6
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FinishShopListBuyData.h"
#import "FinishShopListBuyProduct.h"


NSString *const kFinishShopListBuyDataOrder = @"order";
NSString *const kFinishShopListBuyDataProduct = @"product";


@interface FinishShopListBuyData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FinishShopListBuyData

@synthesize order = _order;
@synthesize product = _product;



+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.order = [self objectOrNilForKey:kFinishShopListBuyDataOrder fromDictionary:dict];
    NSObject *receivedFinishShopListBuyProduct = [dict objectForKey:kFinishShopListBuyDataProduct];
    NSMutableArray *parsedFinishShopListBuyProduct = [NSMutableArray array];
        
    if ([receivedFinishShopListBuyProduct isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFinishShopListBuyProduct) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFinishShopListBuyProduct addObject:[FinishShopListBuyProduct modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFinishShopListBuyProduct isKindOfClass:[NSDictionary class]]) {
       [parsedFinishShopListBuyProduct addObject:[FinishShopListBuyProduct modelObjectWithDictionary:(NSDictionary *)receivedFinishShopListBuyProduct]];
    }

    self.product = [NSArray arrayWithArray:parsedFinishShopListBuyProduct];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.order forKey:kFinishShopListBuyDataOrder];
    NSMutableArray *tempArrayForProduct = [NSMutableArray array];
    for (NSObject *subArrayObject in self.product) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForProduct addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForProduct addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForProduct] forKey:kFinishShopListBuyDataProduct];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    self.order = [aDecoder decodeObjectForKey:kFinishShopListBuyDataOrder];
    self.product = [aDecoder decodeObjectForKey:kFinishShopListBuyDataProduct];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_order forKey:kFinishShopListBuyDataOrder];
    [aCoder encodeObject:_product forKey:kFinishShopListBuyDataProduct];
}

- (id)copyWithZone:(NSZone *)zone
{
    FinishShopListBuyData *copy = [[FinishShopListBuyData alloc] init];
    
    if (copy) {

        copy.order = [self.order copyWithZone:zone];
        copy.product = [self.product copyWithZone:zone];
    }
    
    return copy;
}


@end
