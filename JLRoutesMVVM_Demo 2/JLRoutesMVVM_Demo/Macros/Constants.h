//
//  Constants.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

// 是否为空对象
#define XHObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])
// 字符串为空
#define XHStringIsEmpty(__string) ((__string.length == 0) || XHObjectIsNil(__string))
// 字符串不为空
#define XHStringIsNotEmpty(__string)  (!XHStringIsEmpty(__string))
// 数组为空
#define XHArrayIsEmpty(__array) ((XHObjectIsNil(__array)) || (__array.count==0))

// View 圆角和加边框
#define ViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

// View 圆角
#define ViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

//常用宏
#define KMainScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define KMainScreenHeigth  [[UIScreen mainScreen] bounds].size.height
#define KWidth_scale       [[UIScreen mainScreen] bounds].size.width/375.0
#define KHeight_scale      (KMainScreenHeigth == 812.0 ? 667.0/667.0 : KMainScreenHeigth/667.0) //因为iphoneX宽度与iphone8一样,但高度却比iphone8高
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define SafeAreaTopHeight  (KMainScreenHeigth == 812.0 ? 88 : 64) //iphoneX 导航栏高度
#define SafeAreaBottomHeight (KMainScreenHeigth == 812.0 ? 83 : 49) //iphoneX tabar高度

#define KUserDefaults      [NSUserDefaults standardUserDefaults]
#define UserCenterManager  [UserCenter shareUserCenter]

//设计规范
//字体大小
#define FONT_BIG            18.0f
#define FONT_MIDDLE         15.0f
#define FONT_SMALL          12.0f
#define FONT_SPECIAL        22.5f

//背景颜色
#define COLOR_BOTTOM        @"#F3F3F3"       //背景灰色
#define COLOR_BOTTOM_TWO    @"#F5F5F5"       //浅灰色
#define COLOR_BOTTOM_THREE  @"#FBFBFB"       //浅蓝色

//字体颜色
#define COLOR_LINE          @"#DEDEDE"   //线条颜色
#define COLOR_BLACK_ONE     @"#36363B"   //四种黑色字体,有深到浅
#define COLOR_BLACK_TWO     @"#505050"
#define COLOR_BLACK_THREE   @"#787878"
#define COLOR_BLACK_FOURTH  @"#969696"
#define COLOR_GREEN         @"#32c1b4"  //绿色字体
#define COLOR_BLUE          @"#1e82d2"  //蓝色字体
#define COLOR_ORANGE        @"#F76859"  //橘色字体

#define COLOR_BLUE_ONE      @"#3CA6FE"   //主体蓝 游艺宝:#3CA6FE #1B77CC
#define COLOR_PINK          @"#F76859"   //粉色

//饼状图颜色
#define COLOR_PIE_PURPLE    @"#DC8AEA"  //紫色
#define COLOR_PIE_BLUE      @"#1B77CC"  //蓝色
#define COLOR_PIE_ORANGE    @"#FAC286"  //橘色
#define COLOR_PIE_GREEN     @"#32C1B4"  //绿色
#define COLOR_PIE_RED       @"#FC8478"  //浅红

//房态管理 房态颜色
#define COLOR_ROOMSTATUS_PINK   @"#FC6886"  //浅红
#define COLOR_ROOMSTATUS_GREEN  @"#74BE8F"  //绿色
#define COLOR_ROOMSTATUS_ORANGE @"#C1C5CA"  //橙色
#define COLOR_ROOMSTATUS_BLUE   @"#65AFFF"  //蓝色

#define WAITING_DIALOG      @"正在加载..."
#define NETERROR            @"网络或服务器异常~"
#define REQUESTDEFAIL       @"请求出错"
#define EMPTYDATA           @"暂无数据"

//默认图
#define DEFAULTGRAPH_ONE    @"defaultGraph_1"
#define DEFAULTGRAPH_TWO    @"defaultGraph_2"
#define DEFAULTGRAPH_THREE  @"defaultGraph_3"

#define NOTDATAIMAGE_3      @"ic_empt_data"//无数据图
#define HEAD_IMAGE          @"ic_image_head" //默认头像

#define DominUrl            @"http://i.play.163.com/"

#define BUTTON_BOTTOM 60//底部按钮统一高度
#define BUTTON_WITD   105//按钮默认宽度
#define XH_PAGE_SIZE  20//列表每页记录数
#define ALER_SPACING  56//提示框距离两边的距离总和
#define DR_DURATION   0.3//弹窗动画时间

//正则: 手机号(简单) 1开头 11位
#define REGEX_MOBILE_SIMPLE @"^[1]\\d{10}$"

#define FontS(s)           [UIFont systemFontOfSize:s] //设置字体大小
#define ColorS(s)          [UIColor jk_colorWithHexString:s] //设置字体颜色
#define RemoveObserver(s)  [[NSNotificationCenter defaultCenter]removeObserver:s];//移除通知
#define XHOpenUrl(s)       [[UIApplication sharedApplication] openURL:[NSURL URLWithString:s]]
#define ImageNamed(name)   [UIImage imageNamed:name]
#define URL(s)             [NSURL URLWithString:s]
#define DRKWS(s)           KWidth_scale*s //屏幕比例宽
#define DRKHS(s)           KHeight_scale*s //屏幕比例高


#endif /* Constants_h */
