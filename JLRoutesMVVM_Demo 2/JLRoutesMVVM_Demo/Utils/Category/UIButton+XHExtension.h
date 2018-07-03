//
//  UIButton+XHExtension.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (XHExtension)
/// Disabled的背景颜色
@property(nonatomic,strong) UIColor * disabledBackgroundColor;
-(UIButton *)initNavigationButton:(UIImage *)image;
-(UIButton *)initNavigationButtonWithTitle:(NSString *)str color:(UIColor *)color;
-(UIButton *)initWithTitle:(NSString *)title TitleColor:(UIColor *)color Font:(CGFloat)font;

-(UIButton *)initWithImageNormal:(NSString *)imgaenormal imageSeleted:(NSString *)imageSeleted;
-(UIButton *)initImage:(NSString *)img imageHight:(NSString *)imageHight;
-(UIButton *)initBackgroundColorNoraml:(UIColor *)colorNoraml backgroundColoHight:(UIColor *)colorHight;
-(UIButton *)initTextColorNoraml:(UIColor *)colorNoraml TextColorSelected:(UIColor *)colorSelected;
-(UIButton *)initWithBackgroundColorNoraml:(UIColor *)backNoralColor seletedColor:(UIColor *)seletedColor colorHight:(UIColor *)colorHight;
-(UIButton *)initWithButtonLoginTitle:(NSString *)title;
-(UIButton *)initWithImage:(UIImage *)imgae;

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)jk_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
@end
