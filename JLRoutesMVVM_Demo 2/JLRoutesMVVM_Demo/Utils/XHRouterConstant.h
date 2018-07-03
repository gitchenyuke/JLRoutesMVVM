//
//  XHRouterConstant.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import <Foundation/Foundation.h>
// 路由默认控制器参数名
FOUNDATION_EXTERN NSString *const XHControllerNameRouteParam;

#pragma mark - 路由模式 Schema
/**
 模式 Native：AppSchema://url/:param
 */

// 默认路由
FOUNDATION_EXTERN NSString *const XHDefaultRouteSchema;
// 网络跳转路由模式
FOUNDATION_EXTERN NSString *const XHHTTPRouteSchema;
FOUNDATION_EXTERN NSString *const XHHTTPsRouteSchema;
// WEB交互路由跳转模式
FOUNDATION_EXTERN NSString *const XHWebHandlerRouteSchema;
// 自定义路由
FOUNDATION_EXTERN NSString *const XHCustomHandlerRouteSchema;
// 回调通信
FOUNDATION_EXTERN NSString *const XHComponentsCallBackHandlerRouteSchema;
// 未知路由
FOUNDATION_EXTERN NSString *const XHUnknownHandlerRouteSchema;


#pragma mark - 路由表

// 导航栏 Push
FOUNDATION_EXTERN NSString *const XHNavPushRoute;

// 导航栏 Present
FOUNDATION_EXTERN NSString *const XHNavPresentRoute;

// StoryBoard Push
FOUNDATION_EXTERN NSString *const XHNavStoryBoardPushRoute;

// 组件通信回调
FOUNDATION_EXTERN NSString *const XHComponentsCallBackRoute;
