//
//  NATestFourViewController+NATestReplaceMethodCate.m
//  Test1
//
//  Created by Wang HongLu on 2018/5/22.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NATestFourViewController+NATestReplaceMethodCate.h"
#import <objc/message.h>

@implementation NATestFourViewController (NATestReplaceMethodCate)

+ (void)load{
    
    Method origin = class_getInstanceMethod([self class], @selector(click));
    Method replace = class_getInstanceMethod([self class], @selector(replaceClick));
    
    method_exchangeImplementations(origin, replace);
    
}


- (void)replaceClick{
    
    NSLog(@"哈哈哈，我把你换了，没用！！");
    sleep(5);
    NSLog(@"算了，放过你了");
    [self replaceClick];
    
}
@end
