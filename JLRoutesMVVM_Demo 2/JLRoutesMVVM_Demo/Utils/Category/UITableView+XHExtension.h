//
//  UITableView+XHExtension.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (XHExtension)
/**
 * 使用以下两个方法注册的cell，identifier和类名保持一致
 * 推荐使用类名做cell的标识符
 * 使用该方法获取identifier字符串：
 * NSString *identifier = NSStringFromClass([UITableViewCell class])
 */
- (void)xh_registerCell:(Class)cls;
- (void)xh_registerNibCell:(Class)cls;

- (void)xh_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;
- (void)xh_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)xh_registerHeaderFooterViewView:(Class)cls;
- (void)xh_registerHeaderFooterViewNibView:(Class)cls;

- (void)xh_registerHeaderFooterView:(Class)cls forViewReuseIdentifier:(NSString *)reuseIdentifier;
- (void)xh_registerHeaderFooterNibView:(Class)cls forViewReuseIdentifier:(NSString *)reuseIdentifier;
@end
