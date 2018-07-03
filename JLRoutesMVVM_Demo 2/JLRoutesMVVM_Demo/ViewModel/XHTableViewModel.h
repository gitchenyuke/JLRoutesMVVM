//
//  XHTableViewModel.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHViewModel.h"

@interface XHTableViewModel : XHViewModel
/// The data source of table view. 这里不能用NSMutableArray，因为NSMutableArray不支持KVO，不能被RACObserve
@property (nonatomic, readwrite, copy) NSArray *dataSource;
/// tableView‘s style defalut is UITableViewStylePlain , 只适合 UITableView 有效
@property (nonatomic, readwrite, assign) UITableViewStyle style;
/// 需要支持下来刷新 defalut is NO
@property (nonatomic, readwrite, assign) BOOL shouldPullDownToRefresh;
/// 需要支持上拉加载 defalut is NO
@property (nonatomic, readwrite, assign) BOOL shouldPullUpToRefresh;
/// 是否数据是多段 (It's effect tableView's dataSource 'numberOfSectionsInTableView:') defalut is NO
@property (nonatomic, readwrite, assign) BOOL shouldMultiSections;
/// 当前页 defalut is 1
@property (nonatomic, readwrite, assign) int page;
/// 每一页的数据 defalut is 20
@property (nonatomic, readwrite, assign) int perPage;
/// 空数据文案
@property (nonatomic, readwrite, strong) NSString *emtpy;
/// 请求服务器数据的命令 上拉分页
@property (nonatomic, readonly, strong) RACCommand *requestRemoteDataCommand;
/// 选中命令 eg:  didSelectRowAtIndexPath:
@property (nonatomic, readwrite, strong) RACCommand *didSelectCommand;
/// reloadTableView
@property (nonatomic, readwrite, strong) RACSubject *reloadSubject;

/** request remote data or local data, sub class can override it
 *  page - 请求第几页的数据
 */
- (RACSignal *)requestRemoteDataSignalWithPage:(int)page;
/// cell 点击事件
- (void)didSelectIndexPath:(NSIndexPath *)indexPath;
@end
