//
//  XHWebViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/26.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHWebViewController.h"
#import "YJWebViewProgressView.h"
#import "XHWebViewModel.h"
#import <WebKit/WebKit.h>

@interface XHWebViewController ()
<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic,strong) WKWebView *webView;
@property (nonatomic,strong) YJWebViewProgressView *webProgressView;
/// 返回按钮
@property (nonatomic, readwrite, strong) UIBarButtonItem *backItem;
/// 关闭按钮 （点击关闭按钮  退出WebView）
@property (nonatomic, readwrite, strong) UIBarButtonItem *closeItem;
/// viewModel
@property (nonatomic, strong, readonly) XHWebViewModel *viewModel;
@end

@implementation XHWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    self.webView.navigationDelegate = self;
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.webView.scrollView.backgroundColor = [UIColor whiteColor];
    self.webView.allowsBackForwardNavigationGestures = YES;
    [self.view addSubview:self.webView];
    [self.webView setNeedsUpdateConstraints];
    
    self.navigationItem.leftBarButtonItem = self.backItem;
    
    CGFloat progressBarHeight = 2.f;
    _webProgressView = [[YJWebViewProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, progressBarHeight)];
    _webProgressView.progressBarColor = [UIColor orangeColor];
    _webProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_webProgressView];
    
    [self addObservers];
}

#pragma mark - 事件处理
- (void)backItemDidClicked{ /// 返回按钮事件处理
    /// 可以返回到上一个网页，就返回到上一个网页
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{/// 不能返回上一个网页，就返回到上一个界面
        [self backViewController];
    }
}

- (void)closeItemDidClicked{
    [self backViewController];
}
- (void)backViewController{
    /// 判断 是Push还是Present进来的，
    if (self.presentingViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)loadRequest:(NSString *)url
{
    // 转义
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

- (void)addObservers {
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    [_webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)dealloc {
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
    [_webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (object == self.webView) {
            [self.webProgressView setProgress:self.webView.estimatedProgress animated:YES];
        }else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.title = self.webView.title;
        }
        else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else if ([keyPath isEqualToString:@"contentSize"]){
        if (object == self.webView.scrollView) {
            //                  self.scrollView.contentSize = self.webView.scrollView.contentSize;
        }else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
    
}
#pragma mark - WebView Delegate -
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    /// 不显示关闭按钮
    if(self.viewModel.shouldDisableWebViewClose) return;
    
    UIBarButtonItem *backItem = self.navigationItem.leftBarButtonItems.firstObject;
    if (backItem) {
        if ([self.webView canGoBack]) {
            [self.navigationItem setLeftBarButtonItems:@[backItem, self.closeItem]];
        } else {
            [self.navigationItem setLeftBarButtonItems:@[backItem]];
        }
    }
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.webProgressView setProgress:0 animated:YES];
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {}
#pragma mark - WKUIDelegate
- (nullable WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    /// CoderMike Fixed : 解决点击网页的链接 不跳转的Bug。
    WKFrameInfo *frameInfo = navigationAction.targetFrame;
    if (![frameInfo isMainFrame]) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (UIBarButtonItem *)backItem{
    if (!_backItem) {
        UIButton *backBtn = [[UIButton alloc] initWithImage:ImageNamed(@"nav_back2")];
        backBtn.frame = CGRectMake(0, 0, 32, 30);
        [backBtn addTarget:self action:@selector(backItemDidClicked) forControlEvents:UIControlEventTouchUpInside];
        _backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    return _backItem;
}
- (UIBarButtonItem *)closeItem{
    if (!_closeItem) {
        UIButton *closeBtn = [[UIButton alloc] initWithImage:ImageNamed(@"btn_nav_close")];
        closeBtn.frame = CGRectMake(0, 0, 32, 30);
        [closeBtn addTarget:self action:@selector(backItemDidClicked) forControlEvents:UIControlEventTouchUpInside];
        _closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    }
    return _closeItem;
}

@end
