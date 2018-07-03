//
//  XHNavViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHNavViewController.h"

@interface XHNavViewController ()

@end

@implementation XHNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *backButtonImage = [[UIImage imageNamed:@"nav_back2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationBar.backIndicatorImage = backButtonImage;
    self.navigationBar.backIndicatorTransitionMaskImage = backButtonImage;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
