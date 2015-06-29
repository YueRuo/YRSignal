//
//  YRSignalBus.h
//  YRFoundation
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YRSignal.h"

@interface YRSignalBus : NSObject
+(instancetype)shared;
-(void)addYRSignalObserver:(NSObject *)observer name:(NSString*)signalName;
-(void)removeYRSignalObserver:(NSObject *)observer name:(NSString*)signalName;
-(void)removeYRSignalObserver:(NSObject *)observer;
-(void)sendYRSignal:(YRSignal *)signal;
@end
