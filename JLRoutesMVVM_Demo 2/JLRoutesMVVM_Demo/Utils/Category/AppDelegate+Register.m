//
//  AppDelegate+Register.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "AppDelegate+Register.h"
#import "MainViewController.h"
#import "XHNavViewController.h"
#import "XHTestWebViewController.h"

//runtime
#import <objc/runtime.h>

@implementation AppDelegate (Register)

- (void)xh_rootViewMain
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    MainViewController * mainVC = [[MainViewController alloc] init];
    
    self.window.rootViewController = mainVC;
    
    [self.window makeKeyAndVisible];
}

- (void)configYTKNetworkConfig{
    //服务端接口配置
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = DominUrl;
}

- (void)configUINavigationBar
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:ColorS(COLOR_BLACK_ONE)];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor blackColor],NSForegroundColorAttributeName,
                                                          [UIFont systemFontOfSize:16.0f],NSFontAttributeName,
                                                          nil]];
}

- (void)xh_registerNavgationRouter
{
    // push
    // 路由 /com_xh_navPush/:viewController
    [[JLRoutes globalRoutes] addRoute:XHNavPushRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _handlerSceneWithPresent:NO parameters:parameters];
        });
        return YES;
    }];
    
    // present
    // 路由 /com_xh_navPresent/:viewController
    [[JLRoutes globalRoutes] addRoute:XHNavPresentRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _handlerSceneWithPresent:YES parameters:parameters];
            
        });
        return YES;
    }];
    
    // sb push
    // 路由 /com_xh_navStoryboardPush/:viewController
    [[JLRoutes globalRoutes] addRoute:XHNavStoryBoardPushRoute handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        return YES;
    }];
}

#pragma mark - Schema 匹配
- (void)xh_registerSchemaRouter
{
    // HTTP注册
    [[JLRoutes routesForScheme:XHHTTPRouteSchema] addRoute:@"/somethingHTTP" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        return NO;
    }];
    
    // HTTPS注册
    [[JLRoutes routesForScheme:XHHTTPsRouteSchema] addRoute:@"/somethingHTTPs" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        return NO;
        
    }];
    
    // 自定义 Schema注册  类似MGRoutes那样给每个自定义scheme注册对应的控制器
    [[JLRoutes routesForScheme:XHCustomHandlerRouteSchema] addRoute:@"/test/web" handler:^BOOL(NSDictionary<NSString *,id> * _Nonnull parameters) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIViewController *currentVC = [UIViewController currentViewController];
            XHTestWebViewController * webViewController = [[XHTestWebViewController alloc] init];
            [self paramToViewController:webViewController param:parameters];
            //webViewController.params = parameters;
            [currentVC.navigationController pushViewController:webViewController animated:YES];
        });
        
        return NO;
    }];
}

- (BOOL)openURL:(NSURL *)url
{
    // 默认的路由 跳转等等
    if ([[url scheme] isEqualToString:XHDefaultRouteSchema]) {
        
        return [[JLRoutes globalRoutes] routeURL:url];
    }
    // custom
    else if ([[url scheme] isEqualToString:XHCustomHandlerRouteSchema])
    {
        return [[JLRoutes routesForScheme:XHCustomHandlerRouteSchema] routeURL:url];
    }
    // http
    else if ([[url scheme] isEqualToString:XHHTTPRouteSchema])
    {
        return [[JLRoutes routesForScheme:XHHTTPRouteSchema] routeURL:url];
    }
    // https
    else if ([[url scheme] isEqualToString:XHHTTPsRouteSchema])
    {
        return [[JLRoutes routesForScheme:XHHTTPsRouteSchema] routeURL:url];
    }
    // Web交互请求
    else if ([[url scheme] isEqualToString:XHWebHandlerRouteSchema])
    {
        return [[JLRoutes routesForScheme:XHWebHandlerRouteSchema] routeURL:url];
    }
    // 请求回调
    else if ([[url scheme] isEqualToString:XHComponentsCallBackHandlerRouteSchema])
    {
        return [[JLRoutes routesForScheme:XHComponentsCallBackHandlerRouteSchema] routeURL:url];
    }
    // 未知请求
    else if ([[url scheme] isEqualToString:XHUnknownHandlerRouteSchema])
    {
        return [[JLRoutes routesForScheme:XHUnknownHandlerRouteSchema] routeURL:url];
    }
    return NO;
}

#pragma mark - Private
/// 处理跳转事件
- (void)_handlerSceneWithPresent:(BOOL)isPresent parameters:(NSDictionary *)parameters
{
    // 当前控制器
    NSString *controllerName = [parameters objectForKey:XHControllerNameRouteParam];
    UIViewController *currentVC = [UIViewController currentViewController];
    UIViewController *toVC = [[NSClassFromString(controllerName) alloc] init];
    //toVC.params = parameters;
    [self paramToViewController:toVC param:parameters];
    if (currentVC && currentVC.navigationController) {
        if (isPresent) {
            [currentVC.navigationController presentViewController:toVC animated:YES completion:nil];
        }else
        {
            [currentVC.navigationController pushViewController:toVC animated:YES];
        }
    }
}

- (void)paramToViewController:(UIViewController *)viewController param:(NSDictionary<NSString *,NSString *> *)parameters{
    // runtime将参数传递至需要跳转的控制器
    unsigned int outCount = 0;
    objc_property_t * properties = class_copyPropertyList(viewController.class , &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [NSString stringWithUTF8String:property_getName(property)];
        NSString *param = parameters[key];
        if (param != nil) {
            [viewController setValue:param forKey:key];
        }
    }
}

@end
