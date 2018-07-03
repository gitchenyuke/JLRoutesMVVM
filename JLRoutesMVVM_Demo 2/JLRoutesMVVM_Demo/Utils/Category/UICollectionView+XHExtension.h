//
//  UICollectionView+XHExtension.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (XHExtension)
- (void)xh_registerCell:(Class)cls;
- (void)xh_registerNibCell:(Class)cls;

- (void)xh_registerCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;
- (void)xh_registerNibCell:(Class)cls forCellReuseIdentifier:(NSString *)reuseIdentifier;

- (void)xh_registerView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind;
- (void)xh_registerNibView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind;

- (void)xh_registerView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind forViewReuseIdentifier:(NSString *)reuseIdentifier;
- (void)xh_registerNibView:(Class)cls forSupplementaryViewOfKind:(NSString *)kind forViewReuseIdentifier:(NSString *)reuseIdentifier;
@end
