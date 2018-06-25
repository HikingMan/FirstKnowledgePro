//
//  TestJSCoreViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/6/4.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "TestJSCoreViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Foundation/Foundation.h>


@class Student;
@protocol StudentExports <JSExport>

@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,strong)NSDictionary *grades;

- (NSString *)description;

+ (Student *)getStudentWithName:(NSString *)name age:(NSInteger)age grades:(NSDictionary *)grades;
@end

@interface Student:NSObject<StudentExports>

//这里声明为属性是为了自动生成getter和setter方法，可以自己实现getter和setter方法并不声明属性
@property (nonatomic,strong)NSString *name;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,strong)NSDictionary *grades;

@end

@implementation Student

- (NSString *)description{
    
    NSString *desStr = [NSString stringWithFormat:@"学生%@年龄%ld成绩是%@",self.name,self.age,self.grades.description];
    
    return desStr;
}

+ (Student *)getStudentWithName:(NSString *)name age:(NSInteger)age grades:(NSDictionary *)grades{
    
    Student *stu = [Student new];
    stu.name = name;
    stu.age = age;
    stu.grades = grades;
    
    return stu;
}

@end;


__weak static JSContext *weakContext;
@interface TestJSCoreViewController ()


@end

@implementation TestJSCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"JavaScriptCore";
//  *************
//    http://www.cocoachina.com/ios/20170720/19958.html
//    所有内容要参考上面的内容阅读很详细
//    ***************
    
//    [self test1];
//    [self test2];
//    [self test3];
    [self test4];
    
    // Do any additional setup after loading the view.
}

- (NSString *)loadJSFromFile{
    
    NSString *jsFilePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"js"];
    
//    NSData *data = [[NSData alloc]initWithContentsOfFile:jsFilePath];
    
    NSString *jsStr = [NSString stringWithContentsOfFile:jsFilePath encoding:NSUTF8StringEncoding error:nil];
    
    return jsStr;
}
//    oc调用js
- (void)test1{
    
    
    NSString *sourceStr = [self loadJSFromFile];
    
    JSContext *context = [[JSContext alloc]init];
    
    //这里将js代码转成字符串注入到JSContext,这里的的context会被windowValue持有，强引用
    JSValue *windowValue = [context evaluateScript:sourceStr];
    
//    JSContext就相当于js中的window，这里通过key-value的形式获取到factorial的对应的function
    JSValue *factorialValue = context[@"factorial"];
    
    //通过callWithArguments调用该方法，参数是数组的形式，传参数到js的时候会被javasriptcore转成对应的js类型。这里的NSNumber转成了number类型；
    JSValue *resultValue = [factorialValue callWithArguments:@[@(5)]];
    
    NSLog(@"factorial(5) = %ld", [resultValue toInt32]);
}

//js调用oc （block形式）
- (void)test2{
    
    JSContext *context = [[JSContext alloc]init];
    
    //这里block中不能使用JSValue，因为JSValue强引用context，context持有block，造成循环应用，可以把JSValue当作block中的参数传入（又学到了，其他的block有这个问题时也能这么用）；
    //这里block中也不能用JSContext,可以用[JSContext currentContext]代替。
    context[@"makeNSColor"] = ^(NSDictionary *colors){
        
        float r = [colors[@"red"] floatValue];
        
        float g = [colors[@"green"] floatValue];
        
        float b = [colors[@"blue"] floatValue];
        
        UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
        
        return color;
    };
    
    NSString *sourceStr = [self loadJSFromFile];
    
    //注入js到context中，并执行。
    [context evaluateScript:sourceStr];
    
//    获取执行的颜色结果
    JSValue *colorResult = context[@"resultColor"];
    
//    转换为object对象。
    id object = colorResult.toObject;
    NSLog(@"==%@==",[object class]);

    
    self.view.backgroundColor = object;

    
}
//js调用oc （JSExport协议）

- (void)test3{
    
//    只要遵循了JSExport协议就会把协议中的东西加入到js中，此时会遍历协议中的内容，如果是属性，就会生成对应的getter和setter方法；如果是实例方法就会转换成js对象的方法；如果是类方法，就会添加到js中的全局对象上的方法，这个全局对象就是Prototype（原型对象）
    
   /* JavaScript对每个创建的对象都会设置一个原型，指向它的原型对象。对象会从其原型对象上继承属性和方法。
    
    当我们用obj.xxx访问一个对象的属性时，JavaScript引擎先在当前对象上查找该属性，如果没有找到，就到其原型对象上找，如果还没有找到，就一直上溯到object.prototype对象，最后，如果还没有找到，就只能返回undefined。
    
    原型对象也是一个对象，他有一个构造函数Constructor，就是用来创建对象的。*/
    
    
//    每次继承JSExport协议，会把遵守协议的类的，父类。。。根类（NSObject）全都在js端生成相同的类链
    
    JSContext *context = [[JSContext alloc]init];
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
      
        NSLog(@"exception: %@",exception);
    };
    
    //这里必须注入Student对象否则，js无法识别Student
    context[@"Student"] = [Student class];
    
    NSString *sourceStr = [self loadJSFromFile];
    [context evaluateScript:sourceStr];
    
    JSValue *infoValue = context[@"showStuInfo"];
    
    JSValue *resultValue = [infoValue callWithArguments:@[@"葫芦",@(18),@{@"语文":@(98),@"数学":@(80),@"英语":@(70),@"游戏":@(40)}]];
    
    NSLog(@"OC Student Info %@",resultValue.toString);
}

- (void)test4{
    
    JSContext *context = [[JSContext alloc]init];
    context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        
        NSLog(@"exception: %@",exception);
    };
    
    weakContext = context;
    
    
    JSValue *aaaValue = context[@"aaa"];

    JSManagedValue *manaValue = [JSManagedValue managedValueWithValue:aaaValue];
    [context.virtualMachine addManagedReference:manaValue withOwner:self];
    context[@"manager"] = ^(NSString *source){
    
        //这里注释掉之后dealloc打印nil，如果没有注释引用JSValue，造成循环引用就会无法释放，dealloc没有打印weakContext指向的JSContext并没有释放
        
        //这里使用JSManagedValue来持有JSValue并对他进行弱引用，这里是conditional retain有条件的引用，
        
//        当oc对象持有jsvalue，jsvalue持有jscontext的时候，而且jscontext持有oc对象的时候，因为需要持有jsvalue在执行之前不被释放，这时候JSManagedValue可以解决循环引用，并且弱引用jsvalue的问题。
        if([manaValue.value.toString isEqualToString:source]){

            NSLog(@"相等了");
        }
    };
    
    NSString *sourceStr = [self loadJSFromFile];
    [context evaluateScript:sourceStr];

    
}


- (void)dealloc{
    
    NSLog(@"%@",weakContext);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
