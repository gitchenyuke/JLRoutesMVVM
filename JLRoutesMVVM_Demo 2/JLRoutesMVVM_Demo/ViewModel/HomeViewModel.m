//
//  HomeViewModel.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/26.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "HomeViewModel.h"
#import "TestEntity.h"

@implementation HomeViewModel

- (void)didSelectIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"HomeDetailViewController"] extraParameters:nil];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            
            break;
        case 1:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"HomeDetailViewController"] extraParameters:@{@"name":@"我是"}];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            
            break;
        case 2:
        {
            TestEntity * testEntity = [[TestEntity alloc] init];
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"HomeDetailViewController"] extraParameters:@{@"object":testEntity}];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            
            break;
        case 3:
        {
            TestEntity * testEntity = [[TestEntity alloc] init];
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPresentRoute parameters:@[@"HomeDetailViewController"] extraParameters:@{@"object":testEntity}];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            
            break;
        case 4:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:@"test/web" parameters:@[] extraParameters:@{@"url":@"http://baidu.com"}];
            XHOpenUrl(JLRGenRoute(XHCustomHandlerRouteSchema, router));
        }
            
            break;
        default:
            break;
    }
}

@end
