//
//  NSObject+YRSignal.m
//  YRFoundation
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import "NSObject+YRSignal.h"

@interface YRSignalBus : NSObject
+ (instancetype)shared;
- (void)addYRSignalObserver:(NSObject *)observer name:(NSString*)signalName;
- (void)removeYRSignalObserver:(NSObject *)observer name:(NSString*)signalName;
- (void)removeYRSignalObserver:(NSObject *)observer;
- (void)sendYRSignal:(YRSignal *)signal;
@end

@implementation NSObject(YRSignal)

- (void)addObserverForYRSignalName:(NSString *)name{
    [[YRSignalBus shared] addYRSignalObserver:self name:name];
}

- (void)removeObserverForYRSignalName:(NSString *)name{
    [[YRSignalBus shared] removeYRSignalObserver:self name:name];
}

- (void)removeObserverForYRSignal{
    [[YRSignalBus shared] removeYRSignalObserver:self];
}

- (void)sendYRSignalName:(NSString *)name{
    [self sendYRSignalName:name userInfo:nil option:YRSignalOptionALL callBack:nil];
}

- (void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo{
    [self sendYRSignalName:name userInfo:userInfo option:YRSignalOptionALL callBack:nil];
}

- (void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo callBack:(YRSignalCallBack)callback{
    [self sendYRSignalName:name userInfo:userInfo option:YRSignalOptionALL callBack:callback];
}

- (void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo option:(YRSignalOption)option callBack:(YRSignalCallBack)callback{
    YRSignal *signal = [[YRSignal alloc]init];
    signal.name = name;
    signal.userInfo = userInfo;
    signal.sender = self;
    signal.option = option;
    signal.callBack = callback;
    [self sendYRSignal:signal];
}
- (void)sendYRSignal:(YRSignal *)signal{
    [[YRSignalBus shared] sendYRSignal:signal];
}

- (id)handleYRSignal:(YRSignal *)signal{
    return nil;
}
@end

@implementation YRSignal
@end

@implementation YRSignalBus{
    NSMutableDictionary *_signalBusDic;
}

+ (instancetype)shared{
    static id instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc]init];
    });
    return instance;
}

- (instancetype)init{
    if (self=[super init]) {
        _signalBusDic = [NSMutableDictionary dictionaryWithCapacity:50];
    }
    return self;
}

- (void)addYRSignalObserver:(NSObject *)observer name:(NSString*)signalName{
    if (!signalName) {
        return;
    }
    NSPointerArray *array = [_signalBusDic objectForKey:signalName];
    if (!array) {
        array = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsWeakMemory];
        [_signalBusDic setObject:array forKey:signalName];
    }
    [array addPointer:(__bridge void * _Nullable)(observer)];
}

- (void)removeYRSignalObserver:(NSObject *)observer name:(NSString*)signalName{
    if (!signalName) {
        return;
    }
    NSPointerArray *array = [_signalBusDic objectForKey:signalName];
    for (NSInteger i = array.count - 1; i > 0; i--) {
        if ([array pointerAtIndex:i]==(__bridge void * _Nullable)(observer)) {
            [array removePointerAtIndex:i];
        }
    }
    if (array.count==0) {
        [_signalBusDic removeObjectForKey:signalName];
    }
}

- (void)removeYRSignalObserver:(NSObject *)observer{
    if (!observer) {
        return;
    }
    [_signalBusDic enumerateKeysAndObjectsUsingBlock:^(id key, NSPointerArray * observers, BOOL *stop) {
        for (NSInteger i = observers.count - 1; i > 0; i--) {
            if ([observers pointerAtIndex:i]==(__bridge void * _Nullable)(observer)) {
                [observers removePointerAtIndex:i];
            }
        }
    }];
}

- (void)sendYRSignal:(YRSignal *)signal{
    NSPointerArray *observers = [_signalBusDic objectForKey:signal.name];
    switch (signal.option) {
        case YRSignalOptionALL:{
            for (NSInteger i = observers.count - 1; i >= 0; i--) {
                id obj = [observers pointerAtIndex:i];
                if (signal.callBack) {
                    signal.callBack(obj,[obj handleYRSignal:signal]);
                }
            }
            break;}
        case YRSignalOptionOnlyToLast:{
            id obj = [observers pointerAtIndex:observers.count-1];
            if (signal.callBack) {
                signal.callBack(obj,[obj handleYRSignal:signal]);
            }
            break;}
        case YRSignalOptionOnlyToFirst:{
            id obj = [observers pointerAtIndex:0];
            if (signal.callBack) {
                signal.callBack(obj,[obj handleYRSignal:signal]);
            }
            break;}
        default:
            break;
    }
}

@end
