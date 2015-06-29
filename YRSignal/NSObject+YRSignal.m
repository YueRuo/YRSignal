//
//  NSObject+YRSignal.m
//  YRFoundation
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import "NSObject+YRSignal.h"
#import "YRSignalBus.h"

@implementation NSObject(YRSignal)

-(void)addObserverForYRSignalName:(NSString *)name{
    [[YRSignalBus shared]addYRSignalObserver:self name:name];
}
-(void)removeObserverForYRSignalName:(NSString *)name{
    [[YRSignalBus shared]removeYRSignalObserver:self name:name];
}
-(void)removeObserverForYRSignal{
    [[YRSignalBus shared]removeYRSignalObserver:self];
}

-(void)sendYRSignalName:(NSString *)name{
    [self sendYRSignalName:name userInfo:nil callBack:nil];
}
-(void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo{
    [self sendYRSignalName:name userInfo:userInfo callBack:nil];
}
-(void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo callBack:(YRSignalCallBack)callback{
    YRSignal *signal = [[YRSignal alloc]init];
    signal.name = name;
    signal.userInfo = userInfo;
    signal.sender = self;
    signal.callBack = callback;
    [self sendYRSignal:signal];
}
-(void)sendYRSignal:(YRSignal *)signal{
    [[YRSignalBus shared]sendYRSignal:signal];
}

-(id)handleYRSignal:(YRSignal *)signal{
    return nil;
}
@end
