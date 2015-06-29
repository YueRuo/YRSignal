//
//  ViewController.m
//  YRSignalDemo
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import "ViewController.h"
#import "View.h"
#import "NSObject+YRSignal.h"
#import "SignalKeyDefine.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    View *view = [[View alloc]init];
    [self.view addSubview:view];
    
    
    [self sendYRSignalName:TestSignalKey userInfo:@"我要干一番事业，谁来陪我！" callBack:^(__weak id receiver, id callbackData) {
        NSLog(@"发送者发现一名响应者：%@，响应信息为：%@",[receiver class],callbackData);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
