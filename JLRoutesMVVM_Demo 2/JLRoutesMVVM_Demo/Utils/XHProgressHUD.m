//
//  XHProgressHUD.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/7/3.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "XHProgressHUD.h"
#import <objc/runtime.h>
#import <CoreMotion/CoreMotion.h>

#define WEAKSELF(weakSelf)  __weak __typeof(&*self)weakSelf = self;

@interface XHProgressHUD ()
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, assign) UIInterfaceOrientation lastOrientation;
@end
@implementation XHProgressHUD

// Customization
+ (void)initialize
{
    [self setSuccessImage:[UIImage imageNamed:@"HUD_success"]];
    [self setInfoImage:[UIImage imageNamed:@"HUD_info"]];
    [self setErrorImage:[UIImage imageNamed:@"HUD_error"]];
    
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    /// 自定义样式
    [self setDefaultStyle:SVProgressHUDStyleCustom];
    /// 背景颜色
    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    /// 字体颜色
    [self setForegroundColor:[UIColor whiteColor]];
    [self setCornerRadius:8.0];
}

// 根据 提示文字字数，判断 HUD 显示时间
- (NSTimeInterval)displayDurationForString:(NSString*)string
{
    return MIN((float)string.length*0.06 + 0.5, 2.0);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if([self.motionManager isAccelerometerAvailable]){
        [self orientationChange];
    }
}

- (void)willRemoveSubview:(UIView *)subview
{
    if (self.motionManager) {
        [self.motionManager stopAccelerometerUpdates];
        self.motionManager = nil;
    }
}

#pragma mark - 屏幕方向旋转
- (void)orientationChange
{
    WEAKSELF(weakSelf);
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        CMAcceleration acceleration = accelerometerData.acceleration;
        __block UIInterfaceOrientation orientation;
        if (acceleration.x >= 0.75) {
            orientation = UIInterfaceOrientationLandscapeLeft;
        }
        else if (acceleration.x <= -0.75) {
            orientation = UIInterfaceOrientationLandscapeRight;
            
        }
        else if (acceleration.y <= -0.75) {
            orientation = UIInterfaceOrientationPortrait;
            
        }
        else if (acceleration.y >= 0.75) {
            orientation = UIInterfaceOrientationPortraitUpsideDown;
            return ;
        }
        else {
            // Consider same as last time
            return;
        }
        
        if (orientation != weakSelf.lastOrientation) {
            [weakSelf configHUDOrientation:orientation];
            weakSelf.lastOrientation = orientation;
            NSLog(@"%tu=-------%tu",orientation,weakSelf.lastOrientation);
        }
        
    }];
}

- (void)configHUDOrientation:(UIInterfaceOrientation )orientation
{
    CGFloat angle = [self calculateTransformAngle:orientation];
    self.transform = CGAffineTransformRotate(self.transform, angle);
}


- (CGFloat)calculateTransformAngle:(UIInterfaceOrientation )orientation
{
    CGFloat angle;
    if (self.lastOrientation == UIInterfaceOrientationPortrait) {
        switch (orientation) {
            case UIInterfaceOrientationLandscapeRight:
                angle = M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                angle = -M_PI_2;
                break;
            default:
                break;
        }
    } else if (self.lastOrientation == UIInterfaceOrientationLandscapeRight) {
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
                angle = -M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeLeft:
                angle = M_PI;
                break;
            default:
                break;
        }
    } else if (self.lastOrientation == UIInterfaceOrientationLandscapeLeft) {
        switch (orientation) {
            case UIInterfaceOrientationPortrait:
                angle = M_PI_2;
                break;
            case UIInterfaceOrientationLandscapeRight:
                angle = M_PI;
                break;
            default:
                break;
        }
    }
    return angle;
}

#pragma mark - Lazy Load
- (CMMotionManager *)motionManager
{
    if (_motionManager == nil) {
        _motionManager = [[CMMotionManager alloc] init];
        _motionManager.accelerometerUpdateInterval = 1./15.;
        
    }
    return _motionManager;
}

@end
