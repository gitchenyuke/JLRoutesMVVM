//
//  XHButtonTypeViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHButtonTypeViewController.h"

@interface XHButtonTypeViewController ()

@end

@implementation XHButtonTypeViewController

- (void)xh_InitSubviews{
    [super xh_InitSubviews];
    [self.view addSubview:self.button];
    self.button.center = self.view.center;
}

@end
