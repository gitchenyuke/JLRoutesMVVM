//
//  UICollectionView+XHExtension.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "UICollectionView+XHExtension.h"

@implementation UICollectionView (XHExtension)
- (void)xh_registerCell:(Class)cls {
    [self xh_registerCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)xh_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerClass:cls forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)xh_registerNibCell:(Class)cls {
    [self xh_registerNibCell:cls forCellReuseIdentifier:NSStringFromClass(cls)];
}
- (void)xh_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}


- (void)xh_registerView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind{
    [self xh_registerView:cls forSupplementaryViewOfKind:kind forViewReuseIdentifier:NSStringFromClass(cls)];
}
- (void)xh_registerView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind forViewReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerClass:cls forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
}

- (void)xh_registerNibView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind{
    [self xh_registerNibView:cls forSupplementaryViewOfKind:kind forViewReuseIdentifier:NSStringFromClass(cls)];
}
- (void)xh_registerNibView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind forViewReuseIdentifier:(NSString *)reuseIdentifier{
    [self registerNib:[UINib nibWithNibName:NSStringFromClass(cls) bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier];
}
@end
