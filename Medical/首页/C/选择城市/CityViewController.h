//
//  CityViewController.h
//  Zhai
//
//  Created by 周文静 on 16/8/25.
//  Copyright © 2016年 lechuangshidai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CityBlock) (NSString *city);
@interface CityViewController : UIViewController

@property (strong,nonatomic)  CityBlock cityBlock;

-(void)cityBlock:(CityBlock)block;

@end
