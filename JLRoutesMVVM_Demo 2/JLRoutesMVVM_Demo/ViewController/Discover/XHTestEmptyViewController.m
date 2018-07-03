//
//  XHTestEmptyViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/7/3.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHTestEmptyViewController.h"
#import "XHTestEmptyViewModel.h"

@interface XHTestEmptyViewController ()
@property(nonatomic,strong) XHTestEmptyViewModel * viewModel;
@end

@implementation XHTestEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"EmptyView"];
}

- (void)xh_BindViewModel{
    [super xh_BindViewModel];
    [self.viewModel.requestDataCommand execute:@1];
}

- (XHTestEmptyViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[XHTestEmptyViewModel alloc] init];
    }
    return _viewModel;
}

@end
