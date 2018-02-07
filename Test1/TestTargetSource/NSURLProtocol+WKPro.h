//
//  NSURLProtocol+WKPro.h
//  Test1
//
//  Created by Wang HongLu on 2017/11/27.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURLProtocol (WKPro)

+(void)wk_registerScheme:(NSString *)scheme;

+(void)wk_unregisterScheme:(NSString *)scheme;
@end
