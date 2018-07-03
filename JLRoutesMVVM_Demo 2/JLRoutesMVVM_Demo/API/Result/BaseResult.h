//
//  BaseResult.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/27.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseResult : JSONModel
@property(nonatomic,assign) int code;
- (BOOL)isSuccess;
@end
