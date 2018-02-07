//
//  NSTimer+WHLTimerCate.m
//  Test1
//
//  Created by Wang HongLu on 2018/1/15.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NSTimer+WHLTimerCate.h"

@implementation NSTimer (WHLTimerCate)

//nstimer的循环引用问题：本来想在dealloc中调用[self.testTimer invalidate]来手动停止timer，从而释放nstimer。但是因为循环引用使得引用timer的对象无法释放，执行不到dealloc方法。以下方法就是为了转移timer的target，从而打破timer对于（引用了timer的对象的引用），当执行到dealloc时，手动释放[self.testTimer invalidate]。

//如果没有在dealloc里面执行[self.testTimer invalidate]，再次进到当前页面会有两个timer，这说明：我们虽然打破了循环引用链接，但是timer还是没有释放的。因为runloop还是持有timer的，只有手动调用[self.testTimer invalidate]，才会释放timer。
+ (NSTimer *)whl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)isRepeat block:(void (^)(NSTimer *))block{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(whl_blockInvoke:) userInfo:block repeats:isRepeat];
    
    return timer;
}
+ (void)whl_blockInvoke:(NSTimer *)timer{
    
    void (^block)(NSTimer *) = timer.userInfo;
    if(block){
        
        block(timer);
    }
    
}
@end
