//
//  TrySecondModelProtocol.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TrySecondModelProtocol <NSObject>

-(NSString *)relateCellIdentify;

-(CGFloat)getLableHeightWith:(id<TrySecondModelProtocol>)model;

-(CGFloat)getRowHeightWith:(id<TrySecondModelProtocol>)model;


//这个方法就是测试，如果有相同属性，直接用父类访问，不用转换了。写了这个方法，相同属性也可以用protocol代替不用转换。
-(NSString *)showText;

@optional

-(void)changeStateWithSource:(id<TrySecondModelProtocol>)model completeHandl:(void(^)(id<TrySecondModelProtocol> result, BOOL issuccess)) block;

@end
