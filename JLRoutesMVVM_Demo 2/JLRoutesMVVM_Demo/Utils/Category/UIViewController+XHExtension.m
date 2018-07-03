//
//  UIViewController+XHExtension.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "UIViewController+XHExtension.h"
#import "XHProgressHUD.h"
#import <objc/runtime.h>

static const void *kParamsKey = &kParamsKey;

@implementation UIViewController (XHExtension)

#pragma mark - Getter Setter
- (void)setParams:(NSDictionary *)params
{
    objc_setAssociatedObject(self, kParamsKey, params, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSDictionary *)params
{
    return objc_getAssociatedObject(self, kParamsKey);
}

+ (UIViewController *)currentViewController
{
    UIViewController *rootViewController = self.applicationDelegate.window.rootViewController;
    return [self currentViewControllerFrom:rootViewController];
}

+(UINavigationController *)currentNavigationViewController
{
    UIViewController *currentViewController = [self currentViewController];
    return currentViewController.navigationController;
}
+ (id<UIApplicationDelegate>)applicationDelegate
{
    return [UIApplication sharedApplication].delegate;
}

/** 递归拿到当控制器 */
+ (UIViewController *)currentViewControllerFrom:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)viewController;
        return [self currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } else if ([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tableBarController = (UITabBarController *)viewController;
        return [self currentViewControllerFrom:tableBarController.selectedViewController];
    } else if (viewController.presentedViewController != nil) {
        return [self currentViewControllerFrom:viewController.presentedViewController];
    } else {
        return viewController;
    }
}

#pragma mark - hud
- (void)showWaitingDialog:(NSString *)message
{
    [XHProgressHUD showWithStatus:message];
}
- (void)showMessageDialog:(NSString *)message
{
    [XHProgressHUD showWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [XHProgressHUD dismiss];
    });
}
- (void)hideWaitingDialog:(NSString *)message
{
    [XHProgressHUD dismiss];
    [XHProgressHUD showErrorWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [XHProgressHUD dismiss];
    });
}
- (void)hideWaitingDialog
{
    [XHProgressHUD dismiss];
}

@end
