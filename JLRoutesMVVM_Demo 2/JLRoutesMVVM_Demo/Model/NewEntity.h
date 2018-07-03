//
//  NewEntity.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/28.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "Entity.h"

@protocol NewEntity;
@interface NewEntity : Entity
@property(nonatomic,strong) NSString<Optional> * id;
@property(nonatomic,strong) NSArray<Optional>  * imgsrc;//thum取第一张
@property(nonatomic,strong) NSString<Optional> * replyCount;//浏览次数
@property(nonatomic,strong) NSString<Optional> * title;//标题
@property(nonatomic,strong) NSString<Optional> * url; //web链接
@property(nonatomic,strong) NSString<Optional> * showType; //显示类型2 全宽 其他默认
//@property(nonatomic,strong) NSString<Optional> * cellIdentifier; //cell标识
@end
