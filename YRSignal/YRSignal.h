//
//  YRSignal.h
//  YRFoundation
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YRSignalCallBack)(__weak id receiver,id callbackData);
@protocol YRSignalDelegate;
@interface YRSignal : NSObject
@property (strong,nonatomic) NSString *name;//名字,唯一标识
@property (assign,nonatomic) NSInteger tag;//数字,辅助标识
@property (strong,nonatomic) id userInfo;//附带信息或参数

@property (weak,nonatomic) id sender;//发送者
@property (copy,nonatomic) YRSignalCallBack callBack;//回调
@end

@protocol YRSignalDelegate <NSObject>
/*!
 *	@brief	处理某个信号，具体的是否处理该消息根据signal的name判别
 *
 *	@param 	signal 	待处理的信号消息
 *
 *	@return	处理完该信号后想要回传给sender的信息，nil表示无信息需要回传
 */
-(id)handleYRSignal:(YRSignal *)signal;
@end

