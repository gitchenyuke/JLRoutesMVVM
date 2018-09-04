//
//  MeViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "MeViewController.h"
#import "XHOrientationViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Transition"];
}

- (void)xh_BindViewModel{
    [super xh_BindViewModel];
    self.viewModel.dataSource = @[@"优化导航栏在转场时的样式",@"转场横屏",@"ReactiveCocoaDEMO",@"ZFPlayer"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
        case 0:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"XHChangeNavBarStyleViewController"] extraParameters:nil];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            break;
        case 1:
        {
            XHOrientationViewController * viewController = [[XHOrientationViewController alloc] init];
            // QMUICommonViewController 提供属性 supportedOrientationMask 用于控制界面所支持的显示方向，在 UIViewController (QMUI) 里会自动根据下一个要显示的界面去旋转设备的方向
            //viewController.supportedOrientationMask = UIInterfaceOrientationMaskLandscapeLeft;
            
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case 2:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"XHReactiveCocoaDEMOController"] extraParameters:nil];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
            break;
        case 3:
        {
            NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"XHPlayerViewController"] extraParameters:nil];
            XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
        }
        default:
            break;
    }
}


@end
