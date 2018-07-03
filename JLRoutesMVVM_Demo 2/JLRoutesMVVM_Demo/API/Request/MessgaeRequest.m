//
//  MessgaeRequest.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/28.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "MessgaeRequest.h"

@implementation MessgaeRequest
- (id)initNewRequest{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)requestUrl{
    return @"user/article/list///80/20";
}

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodGET;
}

- (id)requestArgument{
    return @{};
}

- (MessgaeResult *)result{
    NSError *err = nil;
    MessgaeResult *result = [[MessgaeResult alloc] initWithDictionary:[self responseJSONObject] error:&err];
    if (err == nil) {
        return  result;
    }
    return nil;
}

@end
