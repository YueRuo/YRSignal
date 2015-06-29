//
//  NSObject+YRSignal.h
//  YRFoundation
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YRSignal.h"

@interface NSObject(YRSignal)<YRSignalDelegate>
//监听方
-(void)addObserverForYRSignalName:(NSString *)name;
-(void)removeObserverForYRSignalName:(NSString *)name;
-(void)removeObserverForYRSignal;
//发送方
-(void)sendYRSignalName:(NSString *)name;
-(void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo;
-(void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo callBack:(YRSignalCallBack)callback;
-(void)sendYRSignal:(YRSignal *)signal;

//接收的监听方法
-(id)handleYRSignal:(YRSignal *)signal;
@end
