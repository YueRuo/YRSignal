//
//  NSObject+YRSignal.h
//  YRFoundation
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YRSignalCallBack)(__weak id receiver,id callbackData);
typedef NS_ENUM(NSUInteger, YRSignalOption) {//发送的消息指定接收范围
    YRSignalOptionALL,//默认值，所有接受者都可处理
    YRSignalOptionOnlyToLast,//仅有最后的注册者处理
    YRSignalOptionOnlyToFirst,//仅有最早的注册者处理
};
@class YRSignal;

@interface NSObject(YRSignal)
//监听方
- (void)addObserverForYRSignalName:(NSString *)name;
- (void)removeObserverForYRSignalName:(NSString *)name;
- (void)removeObserverForYRSignal;
//发送方
- (void)sendYRSignalName:(NSString *)name;
- (void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo;
- (void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo callBack:(YRSignalCallBack)callback;
- (void)sendYRSignalName:(NSString *)name userInfo:(id)userInfo option:(YRSignalOption)option callBack:(YRSignalCallBack)callback;
- (void)sendYRSignal:(YRSignal *)signal;
/*!
 *    @brief    接收的监听方法，处理某个信号，具体的是否处理该消息根据signal的name判别
 *    @param     signal     待处理的信号消息
 *    @return    处理完该信号后想要回传给sender的信息，nil表示无信息需要回传
 */
- (id)handleYRSignal:(YRSignal *)signal;
@end


@interface YRSignal : NSObject
@property (strong, nonatomic) NSString *name;//名字,唯一标识
@property (assign, nonatomic) NSInteger tag;//数字,辅助标识
@property (strong, nonatomic) id userInfo;//附带信息或参数
@property (assign, nonatomic) YRSignalOption option;//发送方式，默认为ALL

@property (weak, nonatomic) id sender;//发送者
@property (copy, nonatomic) YRSignalCallBack callBack;//回调
@end
