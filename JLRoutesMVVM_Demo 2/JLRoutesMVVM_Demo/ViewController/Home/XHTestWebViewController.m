//
//  XHTestWebViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/26.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHTestWebViewController.h"
#import "XHTestWebViewModel.h"
#import "NewEntity.h"

@interface XHTestWebViewController ()
@property(nonatomic,strong) XHTestWebViewModel * viewModel;
@end

@implementation XHTestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRequest:self.url];
}

- (XHTestWebViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[XHTestWebViewModel alloc] init];
    }
    return _viewModel;
}

@end
