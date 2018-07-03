//
//  XHTableViewController.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/26.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHViewController.h"
#import "XHTableViewModel.h"
@interface XHTableViewController : XHViewController
<
UITableViewDelegate,
UITableViewDataSource
>
/// tableView
@property (nonatomic, readonly, weak) UITableView *tableView;
/// defalut 50.f
@property (nonatomic,assign) CGFloat cellHight;
/// reload tableView data , sub class can override
- (void)reloadData;
/// layoutTableView
- (void)layoutTableView;
/// dequeueReusableCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object;
@end
