//
//  Runtime.m
//  UITableViewDemo
//
//  Created by Gin on 16/11/10.
//  Copyright © 2016年 Gin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UILabel (RuntimeTest)

@property (nonatomic, assign) BOOL forbidSetBackgroundColor;

@property (nonatomic, assign) BOOL shouldIgnoreSetClearBackgroundColorHandle;

@end

@implementation UILabel (RuntimeTest)

+ (void)load {

    SEL originalSelector = @selector(setBackgroundColor:);
    SEL swizzledSelector = @selector(ex_setBackgroundColor:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL success = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)ex_setBackgroundColor:(UIColor *)backgroundColor {
    
    if (self.forbidSetBackgroundColor){
        self.shouldIgnoreSetClearBackgroundColorHandle = YES;
    } else {
        if (backgroundColor == [UIColor clearColor]) {
            if (self.shouldIgnoreSetClearBackgroundColorHandle) {
                self.shouldIgnoreSetClearBackgroundColorHandle = NO;
            } else {
                [self ex_setBackgroundColor:backgroundColor];
            }
        } else {
            [self ex_setBackgroundColor:backgroundColor];
        }
    }
}

- (BOOL)shouldIgnoreSetClearBackgroundColorHandle {
    
    id value = objc_getAssociatedObject(self, _cmd);
    if (value == nil) {
        objc_setAssociatedObject(self, _cmd, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setShouldIgnoreSetClearBackgroundColorHandle:(BOOL)shouldIgnoreSetClearBackgroundColorHandle {
    
    objc_setAssociatedObject(self, @selector(shouldIgnoreSetClearBackgroundColorHandle), @(shouldIgnoreSetClearBackgroundColorHandle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)forbidSetBackgroundColor {
    
    id value = objc_getAssociatedObject(self, _cmd);
    if (value == nil) {
        objc_setAssociatedObject(self, _cmd, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setForbidSetBackgroundColor:(BOOL)forbidSetBackgroundColor {
    
    objc_setAssociatedObject(self, @selector(forbidSetBackgroundColor), @(forbidSetBackgroundColor), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end



@implementation UITableViewCell (RuntimeTest)

+ (void)load {
    
    SEL originalSelector = @selector(setHighlighted:animated:);
    SEL swizzledSelector = @selector(ex_setHighlighted:animated:);
    
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    
    BOOL success = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)ex_setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    if (highlighted == YES) {
        for (UIView *subview in self.contentView.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)subview;
                label.forbidSetBackgroundColor = YES;
            }
        }
    } else {
        for (UIView *subview in self.contentView.subviews) {
            if ([subview isKindOfClass:[UILabel class]]) {
                UILabel *label = (UILabel *)subview;
                label.forbidSetBackgroundColor = NO;
            }
        }
    }
    [self ex_setHighlighted:highlighted animated:animated];
}

@end