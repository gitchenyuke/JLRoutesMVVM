//
//  MessgaeViewModel.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/28.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "MessgaeViewModel.h"

@implementation MessgaeViewModel

- (void)initialize{
    [super initialize];
    
    self.shouldPullDownToRefresh = YES;
}

- (void)didSelectIndexPath:(NSIndexPath *)indexPath{
    NewEntity * entity = self.dataSource[indexPath.row];
    NSString * router = [JLRoutes fk_generateURLWithPattern:XHNavPushRoute parameters:@[@"XHTestWebViewController"] extraParameters:@{@"url":entity.url}];
    XHOpenUrl(JLRGenRoute(XHDefaultRouteSchema, router));
}

- (RACSignal *)requestDataSignal{
    return [self requestRemoteDataSignalWithPage:1];
}

- (RACSignal *)requestRemoteDataSignalWithPage:(int)page{
    @weakify(self)
    self.errorMessage = nil;
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        @strongify(self)
        MessgaeRequest * req = [[MessgaeRequest alloc] initNewRequest];
        [req startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            MessgaeRequest * req = (MessgaeRequest *)request;
            MessgaeResult * res = [req result];
            if ([res isSuccess]) {
                self.dataSource = res.info;
            }else{
                self.errorMessage = REQUESTDEFAIL;
            }
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            @strongify(self)
            self.dataSource = @[];
            self.errorMessage = NETERROR;
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        }];
        return nil;
    }];
}

@end
