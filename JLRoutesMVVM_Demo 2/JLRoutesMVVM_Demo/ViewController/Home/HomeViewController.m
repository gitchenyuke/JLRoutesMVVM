//
//  HomeViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "HomeViewController.h"
#import "TestEntity.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"JLRoutes"];
}

- (void)xh_BindViewModel{
    [super xh_BindViewModel];
    self.viewModel.dataSource = @[@"不带参数push",@"带参数push",@"带对象push",@"带参数present",@"自定义schecm"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"HomeDetailViewController"] extraParameters:nil];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            break;
        case 1:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"HomeDetailViewController"] extraParameters:@{@"name":@"崔斯特=我"}];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            break;
        case 2:
        {
            /// 传model需转出json字符串 并且model的参数不能有null
            TestEntity * testEntity = [[TestEntity alloc] init];
            NSString * jsonStr = [testEntity toJSONString];
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"HomeDetailViewController"] extraParameters:@{@"object":jsonStr}];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            break;
        case 3:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPresentRoute parameters:@[@"HomeDetailViewController"] extraParameters:@{@"name":@"崔斯特"}];
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
