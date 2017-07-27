//
//  oldlabel.m
//  Medical
//
//  Created by 王俊钢 on 2016/11/9.
//  Copyright © 2016年 张婷. All rights reserved.
//

#import "oldlabel.h"

@implementation oldlabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
- (void)drawTextInRect:(CGRect)rect
{
    [super drawTextInRect:rect];
    
    CGSize textSize = [[self text] sizeWithFont:[self font]];
    
//    NSLog(@"______textSize = %@ , ______rect = %@",NSStringFromCGSize(textSize),NSStringFromCGRect(rect));
    
    CGFloat strikeWidth = textSize.width;
    
    CGRect lineRect;
    
    _strikeThroughEnabled = YES;
    
    // 画线居中
    lineRect = CGRectMake(rect.size.width - strikeWidth, rect.size.height/2+2, strikeWidth, 1);
    
    if (self.strikeThroughEnabled)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [self strikeThroughColor].CGColor);
        
        CGContextFillRect(context, lineRect);
    }
}

@end
