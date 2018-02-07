//
//  TestModel.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/31.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



@interface GradeModel : NSObject

@property (nonatomic,strong)NSString *math;
@property (nonatomic,assign)NSInteger chinese;
@property (nonatomic,strong)NSString *english;

@end


@protocol GradeModel <NSObject>


@end

@interface TestModel : NSObject


@property (nonatomic,strong)NSString *id;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,strong)NSString *name;

//这里需要声明一个和数组中模型类名相同的协议，这样获取属性的时候 这个协议也会包含在属性类型。这样就可以得到嵌套模型的类对象然后循环解析。
@property (nonatomic,strong)NSArray<GradeModel> *grades;


+ (void)startParase;

@end
