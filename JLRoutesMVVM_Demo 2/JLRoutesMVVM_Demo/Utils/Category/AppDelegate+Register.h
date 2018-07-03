//
//  AppDelegate+Register.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Register)
/// 路由器注册
- (void)xh_registerNavgationRouter;
/// Schema 匹配
- (void)xh_registerSchemaRouter;
/// 设置rootViewController
- (void)xh_rootViewMain;
/// 配置NavigationBar
- (void)configUINavigationBar;
/// 配置YTK域名
- (void)configYTKNetworkConfig;
/// openURL
- (BOOL)openURL:(NSURL *)url;
@end
