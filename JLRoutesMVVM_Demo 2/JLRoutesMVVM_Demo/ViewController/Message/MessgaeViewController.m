//
//  MessgaeViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "MessgaeViewController.h"
#import "MessageTableViewCell.h"
#import "MessgaeViewModel.h"
@interface MessgaeViewController ()
@property(nonatomic,strong) MessgaeViewModel * viewModel;

@end

@implementation MessgaeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"List"];
}

- (void)xh_InitSubviews{
    [super xh_InitSubviews];
    self.cellHight = 100.f;
    [self.tableView xh_registerCell:[MessageTableViewCell class]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath{
    return [MessageTableViewCell cellWithTableView:tableView];
}

- (void)configureCell:(MessageTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(NewEntity *)object{
    cell.entity = object;
}

- (MessgaeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MessgaeViewModel alloc] init];
    }
    return _viewModel;
}

@end
