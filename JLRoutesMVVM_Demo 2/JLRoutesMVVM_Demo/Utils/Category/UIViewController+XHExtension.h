//
//  UIViewController+XHExtension.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XHExtension)
/// 参数
@property (nonatomic, strong) NSDictionary *params;

/// 获取当前控制器
+ (UIViewController *)currentViewController;
/// 获取当前导航控制器
+ (UINavigationController *)currentNavigationViewController;

- (void)showWaitingDialog:(NSString *)message;
- (void)showMessageDialog:(NSString *)message;
- (void)hideWaitingDialog:(NSString *)message;
- (void)hideWaitingDialog;

@end
