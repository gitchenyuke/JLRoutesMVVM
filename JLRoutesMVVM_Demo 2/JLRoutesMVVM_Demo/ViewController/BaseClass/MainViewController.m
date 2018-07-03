//
//  MainViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "MainViewController.h"
#import "XHNavViewController.h"
#import "HomeViewController.h"
#import "MessgaeViewController.h"
#import "DiscoverViewController.h"
#import "MeViewController.h"

@interface MainViewController ()
{
    XHNavViewController *navHomeViewController;
    XHNavViewController *navMessgaeViewController;
    XHNavViewController *navDiscoverViewController;
    XHNavViewController *navMeViewController;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViewControllers];
}


- (void)initViewControllers {
    navHomeViewController = [[XHNavViewController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    navMessgaeViewController = [[XHNavViewController alloc] initWithRootViewController:[[MessgaeViewController alloc] init]];
    navDiscoverViewController = [[XHNavViewController alloc] initWithRootViewController:[[DiscoverViewController alloc] init]];
    navMeViewController = [[XHNavViewController alloc] initWithRootViewController:[[MeViewController alloc] init]];
    
    [navHomeViewController.tabBarItem setTitle:@"JLRoutes"];
    [navHomeViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_home_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navHomeViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_home_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [navMessgaeViewController.tabBarItem setTitle:@"List"];
    [navMessgaeViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_store_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navMessgaeViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_store_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [navDiscoverViewController.tabBarItem setTitle:@"Button"];
    [navDiscoverViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_discover_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navDiscoverViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_discover_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [navMeViewController.tabBarItem setTitle:@"Transition"];
    [navMeViewController.tabBarItem setImage:[[UIImage imageNamed:@"tab_me_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [navMeViewController.tabBarItem setSelectedImage:[[UIImage imageNamed:@"tab_me_checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    self.viewControllers = @[navHomeViewController,navMessgaeViewController,navDiscoverViewController,navMeViewController];
}

@end
