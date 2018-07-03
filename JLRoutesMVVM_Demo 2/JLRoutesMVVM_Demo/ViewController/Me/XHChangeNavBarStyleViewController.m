//
//  XHChangeNavBarStyleViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/29.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHChangeNavBarStyleViewController.h"

@interface XHChangeNavBarStyleViewController ()

@end

@implementation XHChangeNavBarStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"优化导航栏在转场时的样式"];
    
}

- (void)xh_BindViewModel{
    [super xh_BindViewModel];
    self.viewModel.dataSource = @[@"index0",@"index1",@"index2",@"index3",@"index4",@"index5"];
}

#pragma mark - QMUINavigationControllerDelegate
/// 设置导航栏颜色
- (UIImage *)navigationBarBackgroundImage{
    return [UIImage qmui_imageWithColor:[UIColor orangeColor]];
}
#pragma mark - NavigationBarTransition
- (BOOL)shouldCustomNavigationBarTransitionWhenPushAppearing {return YES;}
- (BOOL)shouldCustomNavigationBarTransitionWhenPushDisappearing {return YES;}
- (BOOL)shouldCustomNavigationBarTransitionWhenPopAppearing {return YES;}
- (BOOL)shouldCustomNavigationBarTransitionWhenPopDisappearing {return YES;}

@end
