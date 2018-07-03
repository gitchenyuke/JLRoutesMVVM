//
//  HomeDetailViewController.m
//  JLRoutesMVVM_Demo
//
//  Created by yukechen on 2018/6/25.
//  Copyright © 2018年 yukechen. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "TestEntity.h"
@interface HomeDetailViewController ()

@end

@implementation HomeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"传过来的:%@",self.name);
    
    NSError * err;
    TestEntity * info = [[TestEntity alloc] initWithString:self.object error:&err];

    NSLog(@"name:%@",info.name);
    
    NSString * title = self.name?self.name:info.name;
    [self setTitle:title];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
