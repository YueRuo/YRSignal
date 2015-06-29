//
//  YRSignalBus.m
//  YRFoundation
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import "YRSignalBus.h"

@interface YRSignalSafeObserver : NSObject
@property (weak,nonatomic) id obj;
@end
@implementation YRSignalSafeObserver
@end

@implementation YRSignalBus{
    NSMutableDictionary *_signalBusDic;
}

+(instancetype)shared{
    static id instance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance=[[[self class] alloc]init];
    });
    return instance;
}

-(instancetype)init{
    if (self=[super init]) {
        _signalBusDic = [NSMutableDictionary dictionaryWithCapacity:50];
    }
    return self;
}

-(void)addYRSignalObserver:(NSObject *)observer name:(NSString*)signalName{
    if (!signalName) {
        return;
    }
    YRSignalSafeObserver *safeObserver = [[YRSignalSafeObserver alloc]init];
    safeObserver.obj = observer;
    NSMutableArray *array = [_signalBusDic objectForKey:signalName];
    if (!array) {
        array = [NSMutableArray arrayWithCapacity:10];
        [_signalBusDic setObject:array forKey:signalName];
    }
    [array addObject:safeObserver];
}
-(void)removeYRSignalObserver:(NSObject *)observer name:(NSString*)signalName{
    if (!signalName) {
        return;
    }
    NSMutableArray *array = [_signalBusDic objectForKey:signalName];
    [array removeObject:observer];
    if (array.count==0) {
        [_signalBusDic removeObjectForKey:signalName];
    }
}
-(void)removeYRSignalObserver:(NSObject *)observer{
    if (!observer) {
        return;
    }
    [_signalBusDic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [obj removeObject:observer];
    }];
}
-(void)sendYRSignal:(YRSignal *)signal{
    NSArray *array = [self observersForYRSignalName:signal.name];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj) {
            id result = [obj handleYRSignal:signal];
            if (signal.callBack) {
                signal.callBack(obj,result);
            }
        }
    }];
}

-(NSArray*)observersForYRSignalName:(NSString *)signalName{
    if (!signalName) {
        return nil;
    }
    NSMutableArray *safeObservers = [_signalBusDic objectForKey:signalName];
    NSMutableArray *observers = [NSMutableArray arrayWithCapacity:safeObservers.count];
    for (NSInteger i=safeObservers.count-1; i>=0; i--) {
        YRSignalSafeObserver *safeObserver = safeObservers[i];
        if (!safeObserver.obj) {
            [safeObservers removeObjectAtIndex:i];
        }else{
            [observers insertObject:safeObserver.obj atIndex:0];
        }
    }
    if ([safeObservers count]==0) {
        [_signalBusDic removeObjectForKey:signalName];
    }
    return observers;
}

@end

