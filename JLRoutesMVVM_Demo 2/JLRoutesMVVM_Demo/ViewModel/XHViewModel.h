//
//  XHViewModel.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHViewModel : NSObject
/// hud出错文案
@property(nonatomic,strong) NSString *errorMessage;
/// 请求服务器数据的命令
@property (nonatomic, readonly, strong) RACCommand *requestDataCommand;

- (void)initialize;
/// loading 请求数据
- (RACSignal *)requestDataSignal;
@end
