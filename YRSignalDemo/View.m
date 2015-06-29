//
//  View.m
//  YRSignalDemo
//
//  Created by 王晓宇 on 15/6/29.
//  Copyright (c) 2015年 YueRuo. All rights reserved.
//

#import "View.h"
#import "NSObject+YRSignal.h"
#import "SignalKeyDefine.h"
@implementation View
-(instancetype)init{
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self addObserverForYRSignalName:TestSignalKey];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)handleYRSignal:(YRSignal *)signal{
    if ([signal.name isEqualToString:TestSignalKey]) {//如果有多份监听事件，只想处理其中某些时，可以按name或者tag区分
        NSString *result = @"不管你是谁，我愿追随";
        NSLog(@"--view 发现了 %@ 发出的信号，内容为：%@，思考后应答为：%@",[[signal sender]class],signal.userInfo,result);
        return result;
    }
    return nil;
}

@end
