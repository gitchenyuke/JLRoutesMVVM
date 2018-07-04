//
//  XHTableViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/26.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHTableViewController.h"
#import "QMUICommonDefines.h"

@interface XHTableViewController ()
/// tableView
@property (nonatomic, readwrite, weak)  UITableView *tableView;
/// viewModel
@property (nonatomic, readwrite, strong) XHTableViewModel *viewModel;
@end

@implementation XHTableViewController

- (void)dealloc {
    // 用下划线而不是self.xxx来访问tableView，避免dealloc时self.view尚未被加载，此时调用self.tableView反而会触发loadView
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)xh_InitSubviews
{
    [super xh_InitSubviews];
    
    /// cell 默认高度
    self.cellHight = 50.f;
    /// FIXED: 纯代码布局，子类如果重新布局，建议用Masonry重新设置约束
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:self.viewModel.style];
    /// 注册cell
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    /// set delegate and dataSource
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    
    // 添加加载刷新
    if (self.viewModel.shouldPullDownToRefresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            /// 请求第一页的网络数据
            self.viewModel.page = 1;
            [self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page)];
        }];
        [self.tableView.mj_header beginRefreshing];
    }
    
    if (self.viewModel.shouldPullUpToRefresh) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            self.viewModel.page++;
            [self.viewModel.requestRemoteDataCommand execute:@(self.viewModel.page)];
        }];
    }
    
    if (@available(iOS 11.0, *)) {
        /// 适配 iPhone X + iOS 11，
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self layoutTableView];
}

- (void)layoutTableView{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)xh_BindViewModel
{
    [super xh_BindViewModel];
    /// 监听视图模型的数据源  deliverOnMainThread 主线程异步刷新
    @weakify(self)
    [[RACObserve(self.viewModel, dataSource) deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        [self reloadData];
    }];
    
    /// 手动刷新tableview
    [[self.viewModel.reloadSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self reloadData];
    }];
    
    /// 订阅command命令中的信号
    [[self.viewModel.requestRemoteDataCommand.executionSignals.switchToLatest deliverOnMainThread] subscribeNext:^(id x) {
        @strongify(self)
        
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        [self configurationEmptyView];
    }];
}

/// reload tableView data
- (void)reloadData{
    [self.tableView reloadData];
}
/// duqueueReusavleCell
- (UITableViewCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

/// configure cell data
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath withObject:(id)object {}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //是否有分段
    if (self.viewModel.shouldMultiSections) return self.viewModel.dataSource?self.viewModel.dataSource.count : 1;
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.shouldMultiSections) return [self.viewModel.dataSource[section] count];
    return self.viewModel.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.cellHight;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self tableView:tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    // fetch object
    id object = nil;
    if (self.viewModel.shouldMultiSections) object = self.viewModel.dataSource[indexPath.section][indexPath.row];
    if (!self.viewModel.shouldMultiSections) object = self.viewModel.dataSource[indexPath.row];
    
    /// bind model
    [self configureCell:cell atIndexPath:indexPath withObject:(id)object];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 执行 commond
    [self.viewModel.didSelectCommand execute:indexPath];
}

#pragma mark - 空列表视图 QMUIEmptyView

/// 重写空数据显示
- (void)configurationEmptyView{
    //self.viewModel.emtpy 改变时刷新空数据文案
    if (XHArrayIsEmpty(self.viewModel.dataSource)) {
        //[self showEmptyViewWithLoading:NO image:ImageNamed(@"image1.jpg") text:nil detailText:@"图片间距可通过imageInsets来调整" buttonTitle:@"重新加载" buttonAction:@selector(reload:)];
        [self showEmptyViewWithImage:UIImageMake(@"image1.jpg") text:nil detailText:@"图片间距可通过imageInsets来调整" buttonTitle:nil buttonAction:NULL];
        //[self showEmptyViewWithText:@"请求失败" detailText:@"请检查网络连接" buttonTitle:@"重试" buttonAction:@selector(reload:)];
    }else{
        [self hideEmptyView];
    }
}

- (void)showEmptyView {
    if (!self.emptyView && self.isShowEmpty) {
        self.emptyView = [[XHEmptyView alloc] init];
        self.emptyView.verticalOffset = 0;
        self.emptyView.imageViewInsets = UIEdgeInsetsMake(0, 0, 10, 0);
    }
    [self.tableView addSubview:self.emptyView];
    [self layoutEmptyView];
}

- (void)hideEmptyView {
    [self.emptyView removeFromSuperview];
}

- (BOOL)layoutEmptyView {
    if (!self.emptyView || !self.emptyView.superview) {
        return NO;
    }
    
    UIEdgeInsets insets = self.tableView.contentInset;
    if (@available(iOS 11, *)) {
        if (self.tableView.contentInsetAdjustmentBehavior != UIScrollViewContentInsetAdjustmentNever) {
            insets = self.tableView.adjustedContentInset;
        }
    }
    
    // 当存在 tableHeaderView 时，emptyView 的高度为 tableView 的高度减去 headerView 的高度
    if (self.tableView.tableHeaderView) {
        self.emptyView.frame = CGRectMake(0, CGRectGetMaxY(self.tableView.tableHeaderView.frame), CGRectGetWidth(self.tableView.bounds) - UIEdgeInsetsGetHorizontalValue(insets), CGRectGetHeight(self.tableView.bounds) - UIEdgeInsetsGetVerticalValue(insets) - CGRectGetMaxY(self.tableView.tableHeaderView.frame));
    } else {
        self.emptyView.frame = CGRectMake(0, 0, CGRectGetWidth(self.tableView.bounds) - UIEdgeInsetsGetHorizontalValue(insets), CGRectGetHeight(self.tableView.bounds) - UIEdgeInsetsGetVerticalValue(insets));
    }
    return YES;
}

@end
