//
//  YJWebViewProgressView.m
//  YJLaunchImage
//
//  Created by YJ on 2016/12/27.
//  Copyright © 2016年 YJ. All rights reserved.
//


#define INITIAL_PROGRESS_FROM_VALUE 0.04
#define INITIAL_PROGRESS_TO_VALUE 0.1
//默认动画时间，单位秒
#define DEFAULT_DURATION 0.25

#import "YJWebViewProgressView.h"

@interface YJWebViewProgressView ()
@property (nonatomic,strong) UIView *progressBarView;
@property (nonatomic) float progress;
@end
@implementation YJWebViewProgressView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupViews];
}

-(void)setupViews {
    self.userInteractionEnabled = NO;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _progressBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,INITIAL_PROGRESS_FROM_VALUE * self.bounds.size.width, self.bounds.size.height)];
    _progressBarView.backgroundColor =[UIApplication sharedApplication].keyWindow.tintColor;
    [self addSubview:_progressBarView];
    
    _progress = -1;
}

- (void)setProgressBarColor:(UIColor *)progressBarColor {
    self.progressBarView.backgroundColor = progressBarColor;
}

- (UIColor *)progressBarColor {
    return self.progressBarView.backgroundColor;
}

- (void)reset {
    _progress = -1;
    _progressBarView.alpha = 1;
    
    CGRect frame = _progressBarView.frame;
    frame.size.width = INITIAL_PROGRESS_FROM_VALUE * self.bounds.size.width;
    _progressBarView.frame = frame;
}

-(void)setProgress:(float)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(float)progress animated:(BOOL)animated {
    _progress = progress;
    
    //NSLog(@"progress %f", progress);
    
    if (progress == 0) {
        [UIView animateWithDuration:animated ? DEFAULT_DURATION : 0.0 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 1.0;
            CGRect frame = _progressBarView.frame;
            frame.size.width = INITIAL_PROGRESS_TO_VALUE * self.bounds.size.width;
            _progressBarView.frame = frame;
        } completion:nil];
    }else if (progress <= 1) {
        [UIView animateWithDuration:animated ? DEFAULT_DURATION : 0.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            CGRect frame = _progressBarView.frame;
            frame.size.width = progress * self.bounds.size.width;
            _progressBarView.frame = frame;
        } completion:nil];
    }
    if (progress == 1) {
        [UIView animateWithDuration:animated ? DEFAULT_DURATION : 0.0 delay:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _progressBarView.alpha = 0.0;
        } completion:^(BOOL completed){
            _progress = -1;
        }];
    }
    
}

@end
