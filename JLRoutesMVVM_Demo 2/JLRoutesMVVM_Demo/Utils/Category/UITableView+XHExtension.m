//
//  UITableView+XHExtension.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "UITableView+XHExtension.h"

@implementation UITableView (XHExtension)
- (void)xh_registerCell:(Class)cls {
    [self xh_registerCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)xh_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerClass:cls forCellReuseIdentifier:reuseIdentifier];
}

- (void)xh_registerNibCell:(Class)cls {
    [self xh_registerNibCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)xh_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
}


- (void)xh_registerHeaderFooterViewView:(Class)cls{
    [self xh_registerHeaderFooterView:cls forViewReuseIdentifier:NSStringFromClass(cls)];
}
- (void)xh_registerHeaderFooterView:(Class)cls forViewReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerClass:cls forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}

- (void)xh_registerHeaderFooterViewNibView:(Class)cls{
    [self xh_registerHeaderFooterNibView:cls forViewReuseIdentifier:NSStringFromClass(cls)];
}
- (void)xh_registerHeaderFooterNibView:(Class)cls forViewReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forHeaderFooterViewReuseIdentifier:reuseIdentifier];
}
@end
