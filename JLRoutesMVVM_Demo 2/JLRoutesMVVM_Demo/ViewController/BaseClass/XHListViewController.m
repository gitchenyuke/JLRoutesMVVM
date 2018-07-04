//
//  XHListViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHListViewController.h"

@interface XHListViewController ()

@end

@implementation XHListViewController

- (void)xh_InitSubviews{
    [super xh_InitSubviews];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(NSString *)object{
    cell.textLabel.text = object;
}

- (XHTableViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[XHTableViewModel alloc] init];
    }
    return _viewModel;
}

@end
