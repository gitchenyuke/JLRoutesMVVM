//
//  XHTableViewModel.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHTableViewModel.h"

@interface XHTableViewModel ()
/// request remote data cmd 网络请求命令
@property (nonatomic, readwrite, strong) RACCommand *requestRemoteDataCommand;
@end

@implementation XHTableViewModel

- (void)initialize{
    [super initialize];
    self.page = 1;
    self.perPage = XH_PAGE_SIZE;
    self.emtpy = EMPTYDATA;
    /// request remote data
    @weakify(self)
    self.requestRemoteDataCommand = [[RACCommand alloc] initWithSignalBlock:^(NSNumber *page) {
        @strongify(self)
        return [[self requestRemoteDataSignalWithPage:page.unsignedIntValue] takeUntil:self.rac_willDeallocSignal];
    }];
    
    self.didSelectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSIndexPath *indexPath) {
        @strongify(self)
        [self didSelectIndexPath:indexPath];
        return [RACSignal empty];
    }];
    
}

- (void)didSelectIndexPath:(NSIndexPath *)indexPath{}

- (RACSignal *)requestRemoteDataSignalWithPage:(int)page {return [RACSignal empty];}

- (RACSubject *)reloadSubject{
    if (!_reloadSubject) {
        _reloadSubject = [RACSubject subject];
    }
    return _reloadSubject;
}

@end
