//
//  XHReactiveCocoaDEMOController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/7/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHReactiveCocoaDEMOController.h"

@interface XHReactiveCocoaDEMOController ()

@end

@implementation XHReactiveCocoaDEMOController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)xh_BindViewModel{
    [super xh_BindViewModel];
    
    self.viewModel.dataSource = @[@"RACTupe: 元组合",
                                  @"RACSequence: 用来代替array,dic 快速遍历",
                                  @"rac_liftSelector: 多个请求完成后同步刷新UI",
                                  @"RACSignal_bind: 信号值的操作",
                                  @"RACSignal_map: 映射",
                                  @"RACMulticastConnection",
                                  @"RACSignal_ReduceEach",
                                  @"RACSignal_scan",
                                  @"RACSignal_ignore",
                                  @"RACSignal_take 只接受指定的前几次或后几次信号",
                                  @"RACSignal_skip 忽略掉几个",
                                  @"RACSignal_startWith",
                                  @"RACSignal_retry",
                                  @"RACSignal_collect",
                                  @"RACSignal_aggregate",
                                  @"RACSignal_delay 信号的时间操作",
                                  @"RACSubject_throttle",
                                  @"RACSignal_concat",
                                  @"RACSignal_merge",
                                  @"RACSignal_zip 信号压缩",
                                  @"RACSignal_sample",
                                  @"RACSignal_takeUntil",
                                  @"RACSignal_takeUntilReplacement",];
    
    
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            //元组合
            RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"aaa",@"bbb",@123]];
            NSString *str = tuple[0];
            NSLog(@"%@",str);
        }
        break;
        case 1:
        {
            // RACSequence:用来代替array，dic.可以快速的遍历
            //最常用的应用场景，字典转模型。
            NSArray *arr = @[@"aaa",@"bbbb",@123];
            
            [arr.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
                NSLog(@"-----%@",x);
            }];
            
            //-----------------------------------------------------------
            
            NSDictionary *dic = @{@"name":@"wiki",@"age":@12};
            
            [dic.rac_sequence.signal subscribeNext:^(RACTuple *x) {
                
                RACTupleUnpack(NSString *key ,NSString *value) = x;
                NSLog(@"%@:%@",key,value);
            }];
        }
        break;
        case 2:
        {
            // 应用场景多个网络请求成功后 再刷新UI
            RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                //发送请求
                NSLog(@"请求网络数据1");
                //发送数据
                [subscriber sendNext:@"发送数据1"];
                return nil;
            }];
            
            RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                //发送请求
                NSLog(@"请求网络数据2");
                //发送数据
                [subscriber sendNext:@"发送数据2"];
                return nil;
            }];
            
            [self rac_liftSelector:@selector(updateUIWithOne:andTwoData:) withSignalsFromArray:@[signal1,signal2]];
        }
        break;
        case 3:
        {
            RACSubject *subject = [RACSubject subject];
            
            RACSignal *bindSignal = [subject bind:^RACSignalBindBlock _Nonnull{
                
                return ^RACSignal * (id value , BOOL *stop) {
                    
                    //            return [RACReturnSignal return:value];
                    
                    
                    //可以对value二次处理，再转发。
                    NSString *str = [NSString stringWithFormat:@"修改过原始数据 ： %@",value];
                    
                    return [RACSignal return:str];
                   // return [RACReturnSignal return:str];
                };
                
            }];
            
            [bindSignal subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@",x);
            }];
            
            [subject sendNext:@"发送数据"];
        }
        break;
        case 4:
        {
            //映射
            RACSubject *subject = [RACSubject subject];
            
            [[subject map:^id _Nullable(id  _Nullable value) {
                
                //直接返回的数据，就是需要处理的数据。
                return [NSString stringWithFormat:@"处理 ： %@",value];
            }] subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"处理过后的:%@",x);
                
            }];
            
            [subject sendNext:@"123"];
            [subject sendNext:@"456"];
        }
        break;
            case 5:
        {
            //   RACMulticastConnection 连接类。当一个信号被多次订阅的时候，避免多次调用创建信号中的block。
            
            //多次订阅了同一个信号。网络请求走了两次。
            RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                //发送网络请求
                //发送数据
                NSLog(@"请求到的数据");
                [subscriber sendNext:@"请求到的数据"];
                return nil;
            }];
            
            //不管订阅多少次信号，之请求一次数据。用RACMulticastConnection、必须通过信号创建。
            //将信号转成连接类
            RACMulticastConnection *connection =  [signal publish];
            
            //订阅信号
            [connection.signal subscribeNext:^(id  _Nullable x) {
                //订阅信号
                NSLog(@"aaa : %@",x);
            }];
            
            [connection.signal subscribeNext:^(id  _Nullable x) {
                //订阅信号
                NSLog(@"bbb : %@",x);
            }];
            
            //连接
            [connection connect] ;  //信号只会被订阅一次。多次connect无效。

        }
            break;
            case 6:
        {
            RACTuple *tuple = RACTuplePack(@"1",@"2");
            RACSignal *signal = [RACSignal return:tuple];
            
            
            RACSignal *signal2 = [signal reduceEach:^id(NSString *first, NSString *second){
                
                return [NSString stringWithFormat:@"%@:%@",first,second];
                
            }];
            
            [signal2 subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
            }];
        }
            break;
        case 7:
        {
            // 按数组遍历叠加
            RACSignal *signal = @[@1,@2,@3,@4].rac_sequence.signal;
            
            RACSignal *signal2 = [signal scanWithStart:@0 reduce:^id _Nullable(NSNumber  *running,NSNumber *next) {
                
                return @(running.integerValue + next.integerValue);
            }];
            
            [signal2 subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
            }];
            
        }
            break;
        case 8:
        {
            RACSubject *subject = [RACSubject subject];
            
            //    RACSignal *ignoreSignal = [subject ignoreValues];
            //    RACSignal *ignoreSignal = [subject ignore:@"1"];
            
            // 过滤1和2的信号值
            RACSignal *ignoreSignal = [[subject ignore:@"1"] ignore:@"2"];
            
            [ignoreSignal subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@",x);
            }];
            
            [subject sendNext:@"1"];
            [subject sendNext:@"2"];
            [subject sendNext:@"112321"];
        }
            break;
        case 9:
        {
            //指定拿前几次发送的数据
            RACSubject *subject = [RACSubject subject];
            [[subject take:2] subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);  //3 1
            }];
            
            //指定拿后几次发送的数据
            [[subject takeLast:2] subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);  // 1 2
            }];
            
            [subject sendNext:@"3"];
            [subject sendNext:@"1"];
            [subject sendNext:@"2"];
            
            [subject sendCompleted];  //从后往前拿一定要标记已经全部发送完毕了
        }
            break;
        case 10:
        {
            //skip 忽略掉几个
            
            RACSubject *subject = [RACSubject subject];
            
            [[subject skip:2] subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@",x);
            }];
            
            [subject sendNext:@"1"];
            [subject sendNext:@"2"];
            [subject sendNext:@"3"];
        }
            break;
        case 11:
        {
            RACSignal *signal = @[@1,@2,@3,@4].rac_sequence.signal;
            
            RACSignal *signal2 = [signal startWith:@"hello world"];
            
            [signal2 subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
                
                
            }];
        }
            break;
        case 12:
        {
            __block int i = 0;
            
            RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                if (i == 10) {
                    [subscriber sendNext:@10];
                }else{
                    NSLog(@"接收到错误");
                    [subscriber sendError:nil];
                }
                i++;
                return nil;
                
            }];
            
            RACSignal *signal2  = [signal retry];
            //    RACSignal *signal2  = [signal retry:2];
            
            [signal2 subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
                
            }];
            
        }
            break;
        case 13:
        {
            RACSignal *signal = @[@1,@2,@3,@4].rac_sequence.signal;
            
            [[signal collect] subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
            }];
        }
            break;
        case 14:
        {
            RACSignal *signal = @[@1,@2,@3,@4].rac_sequence.signal;
            
            [[signal aggregateWithStart:@0 reduce:^id _Nonnull(NSNumber  *running,NSNumber *next) {
                return @(running.integerValue + next.integerValue);
                
            }] subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
            }];
        }
            break;
        case 15:
        {
            RACSignal *signal = @[@1,@2,@3,@4].rac_sequence.signal;
            // 延迟1s
            [[signal delay:1] subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@",x);
            }];
        }
            break;
        case 16:
        {
            //如果发送1，2秒内发送了2，那么1被抛弃了，如果2秒内，3又发送了，那么2就被抛弃了。那么保留了3.
            //比如搜索操作，2秒内有新内容被搜索，那么前面的搜搜索就取消。
            
            RACSubject *signal = [RACSubject subject];
            
            [[signal throttle:2] subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@",x);
                
            }];
            
            [signal sendNext:@"1"];
            [signal sendNext:@"2"];
            [signal sendNext:@"3"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [signal sendNext:@"4"];
                [signal sendNext:@"5"];
                
            });
        }
            break;
        case 17:
        {
            //网络请求a b ，a返回处理a， b返回处理b
            
            //组合:信号的组合
            
            RACSignal *signalA = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [subscriber sendNext:@"数据A"];
                
                //告诉A发送完毕，组合信号才走下面的信号
                [subscriber sendCompleted];
                
                //[subscriber sendNext:nil];  error不可以。a完整结束，才会走b
                
                return nil;
            }];
            
            RACSignal *signalB = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [subscriber sendNext:@"数据B"];
                [subscriber sendCompleted];
                
                return nil;
            }];
            
            RACSignal *signalC = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                [subscriber sendNext:@"数据C"];
                [subscriber sendCompleted];
                
                return nil;
            }];
            
            //创建组合信号 concat，按顺序组合
            //按照A C B 顺序执行
            
            //    RACSignal *concatSignal =  [[signalA concat:signalB] concat:signalC];
            RACSignal *concatSignal =  [RACSignal concat:@[signalA,signalC,signalB] ];
            
            
            //订阅组合信号
            [concatSignal subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
            }];
        }
            break;
        case 18:
        {
            //一个页面N个请求，拿到哪个数据显示哪个数据
            
            //    subject发送数据的时候，是可以没有顺序的
            
            RACSubject *signalA = [RACSubject subject];
            RACSubject *signalB = [RACSubject subject];
            RACSubject *signalC = [RACSubject subject];
            
            //组合信号
            //    RACSignal *mergeSignal = [signalA merge:signalB];
            
            RACSignal *mergeSignal = [RACSignal merge:@[signalA,signalB,signalC]];
            
            //根据发送的情况处理
            [mergeSignal subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
            }];
            
            [signalB sendNext:@"数据B"];
            [signalC sendNext:@"数据C"];
            [signalA sendNext:@"数据A"];
            
            //Ps:特别注意如果A在主线程，B在子线程，C有时候在主线程执行有时候在子线程执行，对于C的一些操作这是一个坑！
        }
            break;
        case 19:
        {
            //把两个信号压缩成一个信号。只有当两个信号同时发出信号内容，并且将内容合并成一个元祖返回
            //一个发一个，是一组。
            
            RACSubject *signalA = [RACSubject subject];
            RACSubject *signalB = [RACSubject subject];
            
            //压缩
            //    RACSignal *zipSignal =  [signalA zipWith:signalB];
            
            RACSignal *zipSignal = [RACSignal zip:@[signalA,signalB] ];
            
            
            [zipSignal subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@",x);  //result is a-b
            }];
            
            [signalB sendNext:@"number B1"];
            [signalA sendNext:@"number A1"];
            
            [signalB sendNext:@"number B2"];
            [signalA sendNext:@"number A2"];
            
            [signalB sendNext:@"number B3"];
            [signalB sendNext:@"number B4"];
            [signalA sendNext:@"number A3"];
            
            [signalA sendNext:@"number A4"];
            
            [signalA sendNext:@"number A5"];
            [signalA sendNext:@"number A6"];
            [signalA sendNext:@"number A7"];
            
            [signalB sendNext:@"number B5"];
        }
            break;
        case 20:
        {
            // [signal1 sample:signal2]的意思是,只有当signal2信号发出后,才需要获取signal1的最新值,取出signal2还没有使用的最旧的信号,合并发出
            
            RACSubject *signal1 = [RACSubject subject];
            RACSubject *signal2 = [RACSubject subject];
            
            RACSignal *signal3 = [signal1 sample:signal2];
            
            [signal3 subscribeNext:^(id  _Nullable x) {
                NSLog(@"%@",x);
            }];
            
            [signal1 sendNext:@"1"];
            [signal2 sendNext:@"Z"];
            [signal1 sendNext:@"2"];
            [signal2 sendNext:@"Z"];
            [signal2 sendNext:@"Z"];
            [signal1 sendNext:@"3"];
            [signal2 sendNext:@"Z"];
            [signal1 sendNext:@"4"];
        }
            break;
        case 21:
        {
            RACSubject *subject = [RACSubject subject];
            
            RACSubject *signal = [RACSubject subject];
            
            //直到标记信号开始发送数据，结束
            [[subject takeUntil:signal] subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
                
            }];
            
            [subject sendNext:@"1"];
            [subject sendNext:@"2"];
            [signal sendNext:@"lol"];
            [signal sendCompleted];  //senderror 不行
            [subject sendNext:@"3"];
            [subject sendCompleted];
        }
            break;
        case 22:
        {
            RACSubject *subject = [RACSubject subject];
            RACSubject *signal = [RACSubject subject];
            
            //直到标记信号发送完数据，结束
            [[subject takeUntilReplacement:signal] subscribeNext:^(id  _Nullable x) {
                
                NSLog(@"%@",x);
                
            }];
            
            [subject sendNext:@"1"];
            [subject sendNext:@"2"];
            [signal sendNext:@"lol"];
            [signal sendCompleted];  //senderror 不行
            [subject sendNext:@"3"];
            [subject sendCompleted];
        }
            break;
        default:
        break;
    }
    
    
}

/// 所有网络请求成功后的数据
- (void)updateUIWithOne:(NSString *)oneData andTwoData:(NSString *)twoData{
    
    NSLog(@"updateUI --> %@ : %@" , oneData ,twoData);
}
    
@end
