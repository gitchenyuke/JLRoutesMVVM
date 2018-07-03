//
//  MessgaeResult.h
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/28.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "BaseResult.h"
#import "NewEntity.h"
@interface MessgaeResult : BaseResult
@property(nonatomic,strong) NSArray<Optional,NewEntity> * info;
@end
