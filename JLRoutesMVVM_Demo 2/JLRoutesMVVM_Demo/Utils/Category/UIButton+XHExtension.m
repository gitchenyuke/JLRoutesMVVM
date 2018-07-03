//
//  UIButton+XHExtension.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "UIButton+XHExtension.h"
#undef    NAV_BUTTON_MIN_WIDTH
#define   NAV_BUTTON_MIN_WIDTH    (40.0f)

#undef    NAV_BUTTON_MIN_HEIGHT
#define   NAV_BUTTON_MIN_HEIGHT    (40.0f)

#undef    NAV_BAR_HEIGHT
#define   NAV_BAR_HEIGHT    (44.0f)

@implementation UIButton (XHExtension)
-(UIButton *)initNavigationButton:(UIImage *)image{
    CGRect buttonFrame = CGRectZero;
    
    buttonFrame = CGRectMake(0, 0, image.size.width, NAV_BAR_HEIGHT);
    
    if ( buttonFrame.size.width >= NAV_BUTTON_MIN_WIDTH )
    {
        buttonFrame.size.width = NAV_BUTTON_MIN_WIDTH;
    }
    
    if ( buttonFrame.size.height >= NAV_BUTTON_MIN_HEIGHT )
    {
        buttonFrame.size.height = NAV_BUTTON_MIN_HEIGHT;
    }
    self = [self initWithFrame:buttonFrame];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor clearColor];
    self.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);// 图片和字体靠近一点，根据实际情况调整
    [self setImage:image forState:UIControlStateNormal];
    return self;
}
-(UIButton *)initNavigationButtonWithTitle:(NSString *)str color:(UIColor *)color{
    CGRect buttonFrame = CGRectZero;
    
    CGSize titleSize = [str boundingRectWithSize:CGSizeMake(999999.0f, NAV_BAR_HEIGHT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]} context:nil].size;
    
    buttonFrame = CGRectMake(0, 0, titleSize.width, NAV_BAR_HEIGHT);
    
    
    self = [self initWithFrame:buttonFrame];
    self.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundColor = [UIColor clearColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    [self setTitleColor:color forState:UIControlStateNormal];
    [self setTitle:str forState:UIControlStateNormal];
    return self;
}

-(UIButton *)initWithTitle:(NSString *)title TitleColor:(UIColor *)color Font:(CGFloat)font{
    self = [super init];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:font];
    }
    return self;
}

-(UIButton *)initWithImageNormal:(NSString *)imgaenormal imageSeleted:(NSString *)imageSeleted{
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:imgaenormal] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imageSeleted] forState:UIControlStateSelected];
    }
    return self;
}

-(UIButton *)initImage:(NSString *)img imageHight:(NSString *)imageHight{
    self = [super init];
    if (self) {
        [self setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:imageHight] forState:UIControlStateHighlighted];
    }
    return self;
}

-(UIButton *)initBackgroundColorNoraml:(UIColor *)colorNoraml backgroundColoHight:(UIColor *)colorHight{
    self = [super init];
    if (self) {
        [self jk_setBackgroundColor:colorNoraml forState:UIControlStateNormal];
        [self jk_setBackgroundColor:colorHight forState:UIControlStateHighlighted];
    }
    return self;
}

-(UIButton *)initTextColorNoraml:(UIColor *)colorNoraml TextColorSelected:(UIColor *)colorSelected{
    self = [super init];
    if (self) {
        [self setTitleColor:colorNoraml forState:UIControlStateNormal];
        [self setTitleColor:colorSelected forState:UIControlStateSelected];
    }
    return self;
}

-(UIButton *)initWithBackgroundColorNoraml:(UIColor *)backNoralColor seletedColor:(UIColor *)seletedColor colorHight:(UIColor *)colorHight{
    self = [super init];
    if (self) {
        [self jk_setBackgroundColor:backNoralColor forState:UIControlStateNormal];
        [self jk_setBackgroundColor:colorHight forState:UIControlStateHighlighted];
        [self jk_setBackgroundColor:seletedColor forState:UIControlStateSelected];
    }
    return self;
}

-(UIButton *)initWithButtonLoginTitle:(NSString *)title{
    self = [super init];
    if (self) {
        [self setTitle:title forState:UIControlStateNormal];
        [self jk_setBackgroundColor:ColorS(COLOR_BLUE) forState:UIControlStateNormal];
        [self jk_setBackgroundColor:ColorS(COLOR_LINE) forState:UIControlStateDisabled];
    }
    return self;
}
-(UIButton *)initWithImage:(UIImage *)imgae{
    self = [super init];
    if (self) {
        [self setImage:imgae forState:UIControlStateNormal];
    }
    return self;
}

- (UIColor *)disabledBackgroundColor {
    return objc_getAssociatedObject(self, @selector(disabledBackgroundColor));
}
- (void)setDisabledBackgroundColor:(UIColor *)disabledBackgroundColor{
    if (disabledBackgroundColor!=nil) {
        [self jk_setBackgroundColor:disabledBackgroundColor forState:UIControlStateDisabled];
    }
    objc_setAssociatedObject(self, @selector(disabledBackgroundColor), disabledBackgroundColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/**
 *  @brief  使用颜色设置按钮背景
 *
 *  @param backgroundColor 背景颜色
 *  @param state           按钮状态
 */
- (void)jk_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    [self setBackgroundImage:[UIButton jk_b_imageWithColor:backgroundColor] forState:state];
}

+ (UIImage *)jk_b_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
