//
//  XHRouterConstant.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHRouterConstant.h"

NSString *const XHControllerNameRouteParam = @"viewController";

#pragma mark - 路由模式
/// TODO: 不能用 JLRoutesMVVM_Demo 因为有_  具体原因不暂不清楚
NSString *const XHDefaultRouteSchema = @"JLRoutesMVVM";
NSString *const XHHTTPRouteSchema = @"http";
NSString *const XHHTTPsRouteSchema = @"https";
// ----
NSString *const XHComponentsCallBackHandlerRouteSchema = @"AppCallBack";
NSString *const XHWebHandlerRouteSchema = @"web";
NSString *const XHCustomHandlerRouteSchema = @"Custom";
NSString *const XHUnknownHandlerRouteSchema = @"UnKnown";

#pragma mark - 路由表

NSString *const XHNavPushRoute = @"/com_xh_navPush/:viewController";
NSString *const XHNavPresentRoute = @"/com_xh_navPresent/:viewController";
NSString *const XHNavStoryBoardPushRoute = @"/com_xh_navStoryboardPush/:viewController";
NSString *const XHComponentsCallBackRoute = @"/com_xh_callBack/*";

