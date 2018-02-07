//
//  NSURLProtocol+WKPro.m
//  Test1
//
//  Created by Wang HongLu on 2017/11/27.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "NSURLProtocol+WKPro.h"
#import <WebKit/WebKit.h>

static Class  browsClass;

FOUNDATION_STATIC_INLINE Class BrowsContextControllerClass(){
    if(!browsClass){
        browsClass = [[[WKWebView new] valueForKey:@"browsingContextController"] class];
    }
    return browsClass;
}

FOUNDATION_STATIC_INLINE SEL  RegisterSchemeSelector(){

    return  NSSelectorFromString(@"registerSchemeForCustomProtocol:");
}
//FOUNDATION_STATIC_INLINE 是定义的内联函数的宏，内联函数继承了宏的优点，取代了宏的缺点。它会在使用宏的地方替换为定义的代码。并且有参数类型检查，可以使用所在类的保护成员及私有成员。
//内联函数注意事项
//1.内联函数只是我们向编译器提供的申请,编译器不一定采取inline形式调用函数.（不需要预编译）
//2.内联函数不能承载大量的代码.如果内联函数的函数体过大,编译器会自动放弃内联.（一般是1-5行）
//3.内联函数内不允许使用循环语句或开关语句.（会当做普通函数）
//4.内联函数的定义须在调用之前.

FOUNDATION_STATIC_INLINE SEL UnRegisterSchemeSelector(){
    
    return NSSelectorFromString(@"unregisterSchemeForCustomProtocol:");
}


@implementation NSURLProtocol (WKPro)


+(void)wk_registerScheme:(NSString *)scheme{
    
    Class class = BrowsContextControllerClass();
    SEL selector = RegisterSchemeSelector();
    if([class respondsToSelector:selector]){
        //#pragma clang diagnostic push 和pop是取消工程里面代码的警告的，"-Warc-performSelector-leaks"是忽视掉performSelector方法带来的警告，也可以设置成其他值来屏蔽其他的警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [class performSelector:selector withObject:scheme];
#pragma clang disagnostic pop
    }
    
}
+(void)wk_unregisterScheme:(NSString *)scheme{
    
    Class class = BrowsContextControllerClass();
    SEL selector = UnRegisterSchemeSelector();
    
    if([class respondsToSelector:selector]){
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [class performSelector:selector withObject:scheme];
#pragma clang diagnostic pop
    }
    
    
}

@end
