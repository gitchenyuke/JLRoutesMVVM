//
//  XHViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHViewController.h"

@interface XHViewController ()
@property(nonatomic,strong) XHViewModel * viewModel;
@end

@implementation XHViewController
@dynamic viewModel;

/// 当XHViewController初始化后会调用
+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    XHViewController *viewController = [super allocWithZone:zone];
    @weakify(viewController)
    [[viewController rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(viewController)
        [viewController xh_InitSubviews];
        [viewController xh_BindViewModel];
    }];
    return viewController;
}

- (instancetype)initWithViewModel:(XHViewModel *)viewModel{
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        [self xh_InitSubviews];
        [self xh_BindViewModel];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ColorS(COLOR_BOTTOM);
    
    self.isShowEmpty = YES;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    if (@available(iOS 11.0, *)) { // 适配ios11 
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutEmptyView];
}

#pragma mark - 空列表视图 QMUIEmptyView

- (void)configurationEmptyView{
    /// 请求出错 则显示空EmptyView
    if (XHStringIsNotEmpty(self.viewModel.errorMessage)) {
        [self showEmptyViewWithLoading:NO image:ImageNamed(@"image1.jpg") text:nil detailText:@"图片间距可通过imageInsets来调整" buttonTitle:@"重新加载" buttonAction:@selector(reload:)];
    }else{
        [self hideEmptyView];
    }
}

- (void)showEmptyView {
    if (!self.emptyView && self.isShowEmpty) {
        self.emptyView = [[XHEmptyView alloc] initWithFrame:self.view.bounds];
        self.emptyView.verticalOffset = 0;
        self.emptyView.imageViewInsets = UIEdgeInsetsMake(0, 0, 10, 0);
    }
    [self.view addSubview:self.emptyView];
}

- (void)hideEmptyView {
    [self.emptyView removeFromSuperview];
}

- (BOOL)isEmptyViewShowing {
    return self.emptyView && self.emptyView.superview;
}

- (void)showEmptyViewWithLoading {
    [self showEmptyView];
    [self.emptyView setImage:nil];
    [self.emptyView setLoadingViewHidden:NO];
    [self.emptyView setTextLabelText:nil];
    [self.emptyView setDetailTextLabelText:nil];
    [self.emptyView setActionButtonTitle:nil];
}

- (void)showEmptyViewWithText:(NSString *)text
                   detailText:(NSString *)detailText
                  buttonTitle:(NSString *)buttonTitle
                 buttonAction:(SEL)action {
    [self showEmptyViewWithLoading:NO image:nil text:text detailText:detailText buttonTitle:buttonTitle buttonAction:action];
}

- (void)showEmptyViewWithImage:(UIImage *)image
                          text:(NSString *)text
                    detailText:(NSString *)detailText
                   buttonTitle:(NSString *)buttonTitle
                  buttonAction:(SEL)action {
    [self showEmptyViewWithLoading:NO image:image text:text detailText:detailText buttonTitle:buttonTitle buttonAction:action];
}

- (void)showEmptyViewWithLoading:(BOOL)showLoading
                           image:(UIImage *)image
                            text:(NSString *)text
                      detailText:(NSString *)detailText
                     buttonTitle:(NSString *)buttonTitle
                    buttonAction:(SEL)action {
    [self showEmptyView];
    [self.emptyView setLoadingViewHidden:!showLoading];
    [self.emptyView setImage:image];
    [self.emptyView setTextLabelText:text];
    [self.emptyView setDetailTextLabelText:detailText];
    [self.emptyView setActionButtonTitle:buttonTitle];
    [self.emptyView.actionButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
    [self.emptyView.actionButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)layoutEmptyView {
    if (self.emptyView) {
        // 由于为self.emptyView设置frame时会调用到self.view，为了避免导致viewDidLoad提前触发，这里需要判断一下self.view是否已经被初始化
        BOOL viewDidLoad = self.emptyView.superview || [self isViewLoaded];
        if (viewDidLoad) {
            CGSize newEmptyViewSize = self.emptyView.superview.bounds.size;
            CGSize oldEmptyViewSize = self.emptyView.frame.size;
            if (!CGSizeEqualToSize(newEmptyViewSize, oldEmptyViewSize)) {
                self.emptyView.frame = CGRectMake(CGRectGetMinX(self.emptyView.frame), CGRectGetMinY(self.emptyView.frame), newEmptyViewSize.width, newEmptyViewSize.height);
            }
            return YES;
        }
    }
    return NO;
}

- (void)xh_BindViewModel{
    @weakify(self)
    [[self.viewModel.requestDataCommand.executionSignals.switchToLatest deliverOnMainThread] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self configurationEmptyView];
    }];
    
    /// showHUD
    [[self.viewModel.requestDataCommand.executing skip:1] subscribeNext:^(id x) {
        @strongify(self)
        if ([x isEqualToNumber:@(YES)]) {
            [self showWaitingDialog:WAITING_DIALOG];
        }else if (!self.viewModel.errorMessage) {
            [self hideWaitingDialog];
        }else{
            [self hideWaitingDialog:self.viewModel.errorMessage];
        }
    }];
}

/// 重新加载
- (void)reload:(id)sender {
    [self.viewModel.requestDataCommand execute:nil];
}

- (void)xh_InitSubviews{}


@end
