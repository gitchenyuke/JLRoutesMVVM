//
//  UILabel+XHExtension.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "UILabel+XHExtension.h"

@implementation UILabel (XHExtension)
- (UILabel *)initWithTextColor:(UIColor *)color TextFont:(CGFloat)font{
    self = [super init];
    if (self) {
        [self setTextColor:color];
        [self setFont:[UIFont systemFontOfSize:font]];
    }
    return self;
}
@end
