//
//  XHViewModel.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHViewModel.h"

@interface XHViewModel ()
/// 请求服务器数据的命令
@property (nonatomic, readwrite, strong) RACCommand *requestDataCommand;
@end
@implementation XHViewModel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}
- (void)initialize{
    @weakify(self)
    
    self.requestDataCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *page) {
        @strongify(self)
        return [[self requestDataSignal] takeUntil:self.rac_willDeallocSignal];
    }];
}

- (RACSignal *)requestDataSignal{return [RACSignal empty];}

@end
