//
//  TestModel.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/31.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TestModel.h"
#import "ParaseTool.h"



@implementation GradeModel

@end




@implementation TestModel

+ (void)startParase{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"testJson" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *sourceDict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    TestModel *model = (TestModel *)[ParaseTool parasemodel:NSStringFromClass([self class]) withSource:sourceDict];
    
    NSLog(@"返回结果%@",model);
    
}


@end
