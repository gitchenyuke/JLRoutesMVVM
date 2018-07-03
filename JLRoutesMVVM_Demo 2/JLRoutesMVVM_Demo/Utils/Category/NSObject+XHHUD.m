//
//  NSObject+XHHUD.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/7/3.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "NSObject+XHHUD.h"
#import <SVProgressHUD.h>
#import "XHProgressHUD.h"

@implementation NSObject (XHHUD)

- (void)showText:(NSString *)aText
{
    [XHProgressHUD showWithStatus:aText];
}


- (void)showErrorText:(NSString *)aText
{
    [XHProgressHUD showErrorWithStatus:aText];
}

- (void)showSuccessText:(NSString *)aText
{
    [XHProgressHUD showSuccessWithStatus:aText];
}

- (void)showLoading
{
    [XHProgressHUD show];
}


- (void)dismissLoading
{
    [XHProgressHUD dismiss];
}

- (void)showProgress:(NSInteger)progress
{
    [XHProgressHUD showProgress:progress/100.0 status:[NSString stringWithFormat:@"%li%%",(long)progress]];
}

- (void)showImage:(UIImage*)image text:(NSString*)aText
{
    [XHProgressHUD showImage:image status:aText];
}

@end
