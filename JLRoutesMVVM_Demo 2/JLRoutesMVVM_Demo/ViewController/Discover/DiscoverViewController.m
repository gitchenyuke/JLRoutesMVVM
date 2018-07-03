//
//  DiscoverViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Button"];
}

- (void)xh_BindViewModel{
    [super xh_BindViewModel];
    self.viewModel.dataSource = @[@"UIButton",@"UILable"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"XHButtonViewController"] extraParameters:nil];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            break;
        case 1:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"XHTestEmptyViewController"] extraParameters:nil];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            break;
        default:
            break;
    }
}


@end
