//
//  XHTestEmptyViewModel.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/7/3.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHTestEmptyViewModel.h"
#import "MessgaeRequest.h"

@implementation XHTestEmptyViewModel

- (RACSignal *)requestDataSignal{
    @weakify(self)
    self.errorMessage = nil;
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        MessgaeRequest * req = [[MessgaeRequest alloc] initNewRequest];
        [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            MessgaeRequest * req = (MessgaeRequest *)request;
            MessgaeResult * res = [req result];
            if ([res isSuccess]) {
                //self.dataSource = res.info;
                self.errorMessage = REQUESTDEFAIL;
            }else{
                self.errorMessage = REQUESTDEFAIL;
            }
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            @strongify(self)
            //self.dataSource = @[];
            self.errorMessage = NETERROR;
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

@end
