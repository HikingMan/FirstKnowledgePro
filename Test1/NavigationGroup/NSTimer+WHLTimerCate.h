//
//  NSTimer+WHLTimerCate.h
//  Test1
//
//  Created by Wang HongLu on 2018/1/15.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WHLTimerCate)


+ (NSTimer *)whl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)isRepeat block:(void(^)(NSTimer *timer)) block;

@end
