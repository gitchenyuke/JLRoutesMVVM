//
//  TestEntity.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/26.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "TestEntity.h"

@implementation TestEntity
- (id)init{
    self = [super init];
    if (self) {
        _name = @"崔斯特";
        _age = 18;
        _sex = @"男";
    }
    return self;
}
@end
