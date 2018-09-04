//
//  XHEmptyView.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/7/3.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHEmptyView.h"
#import "QMUICommonDefines.h"

@implementation XHEmptyView

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat actionButtonW = 150.f;
    CGFloat actionButtonH = 40.f;
    
    self.actionButtonTitleColor = [UIColor whiteColor];
    
    if (!self.actionButton.hidden) {
        [self.actionButton sizeToFit];
        self.actionButton.backgroundColor = ColorS(COLOR_BLUE_ONE);
        ViewRadius(self.actionButton, 5);
        self.actionButton.frame = CGRectMake(CGRectGetMidX(self.contentView.frame)- actionButtonW/2, CGRectGetMaxY(self.detailTextLabel.frame)+10, actionButtonW, actionButtonH);
    }
}

@end
