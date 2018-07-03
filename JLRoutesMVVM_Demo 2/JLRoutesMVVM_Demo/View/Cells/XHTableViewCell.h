//
//  XHTableViewCell.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHTableViewCell : UITableViewCell
@property(nonatomic,assign) id entity;
- (void)initView;
- (void)reloadData:(id)entity;
+ (instancetype)cellWithTableView:(UITableView *)tableView;
+ (instancetype)cellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;
+ (CGFloat)getTableViewCellHightModel:(id)model;
@end
