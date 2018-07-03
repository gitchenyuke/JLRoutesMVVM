//
//  XHButtonViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHButtonViewController.h"
#import "XHButtonTypeViewController.h"

@interface XHButtonViewController ()

@end

@implementation XHButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Button"];
}

- (void)xh_BindViewModel{
    [super xh_BindViewModel];
    
    self.viewModel.dataSource = @[@"QMUIButton",@"QMUILiknButton",@"QMUIGhostButton",@"QMUIFillButton"];
}

@end
