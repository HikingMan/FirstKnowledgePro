//
//  NATestFourViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/5/19.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NATestFourViewController.h"
#import <objc/message.h>
#import "NATestThreeViewController.h"
#import <objc/runtime.h>
#import "NATestFourViewController+NATestReplaceMethodCate.h"
#import "NATestFiveViewController.h"


//@interface NATestFourViewController(TestCategoryCover)
//
//- (void)click;
//@end
//
//@implementation NATestFourViewController(TestCategoryCover)
//
//- (void)click{
//
//    NSLog(@"it's covered");
//}
//@end

typedef void(^ButtonClickBlock)();
@interface NATestFourViewController ()
{
    
    NSString *_holdOn;
}
@end

@implementation NATestFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"goFive" style:UIBarButtonItemStyleDone target:self action:@selector(goNext)];
    
    
    [self performSelector:@selector(test1)];
    
//    [[self class] performSelector:@selector(test2)];
    
    [self performSelector:@selector(test3)];
    
    [self initailSubViews];
}
void test1Method (id obj, SEL _cmd){
    
    // 这里两个是默认参数
    NSLog(@"%@ == %@",obj,NSStringFromSelector(_cmd));
}

void test2Method (id obj, SEL _cmd){
    
    NSLog(@"%@ == %@",obj,NSStringFromSelector(_cmd));
}
+ (BOOL)resolveInstanceMethod:(SEL)sel{
    
    //这里做动态解析，可以在这里通过runtime添加方法
//    if([NSStringFromSelector(sel) isEqualToString:@"test1"]){
//
//        id obj = [NATestFourViewController new];
//
//        Class class1 = [obj class];
//        Class class2 = object_getClass(obj);
//        Class class3 = objc_getClass([NSStringFromClass([obj class]) UTF8String]);
//        NSLog(@"%p===%p====%p",class1,class2,class3);

//        class1和class3返回的相同都是类对象NATestFourViewController
//        class2返回的是参数obj的isa指针（这里有个不一样的地方，很多文章都没有指出来，这里的参数obj换成self的时候的class2返回的指针和class1，class3不同）；
//        class_addMethod(class2, sel, (IMP)test1Method, "v@:");
//        return YES;
//    }
    
    
    return  [super resolveInstanceMethod:sel];
}

//+ (BOOL)resolveClassMethod:(SEL)sel{
//
//    if([NSStringFromSelector(sel) isEqualToString:@"test2"]){
//        //这里参数应该是元类，获取元类的参数是char * （编码过的字符串就是char * 或者是c的字符串不带@）;
//        class_addMethod(objc_getMetaClass([NSStringFromClass([self class]) UTF8String]), sel, (IMP)test2Method, "v@:");
//        return  YES;
//    }
//    return  [super resolveClassMethod:sel];
//}



- (id)forwardingTargetForSelector:(SEL)aSelector{
    
    //这里可以返回另外的对象来处理对应的aSelector
    
    if([NSStringFromSelector(aSelector) isEqualToString:@"test1"]){

        return [NATestThreeViewController new];
    }
    
    //这个方法不能截获类方法，所以不能对类方法重定向
    if([NSStringFromSelector(aSelector) isEqualToString:@"test2"]){
        
        return [NATestThreeViewController class];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation{
    
    
    if(anInvocation.selector == @selector(test3)){
        
        //在这里重新设置target
        [anInvocation invokeWithTarget:[NATestThreeViewController new]];
    }
    // 此方法不能截获类方法，所以不能对类消息转发
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    
    NSMethodSignature *sig = [super methodSignatureForSelector:aSelector];
    if(nil == sig){
        
        //这里根据参数类型和返回值方法名（方法的默认2个参数@（对象）代表self，:代表方法）进行签名，如果不为nil提交给forwardInvocation
        sig = [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return sig;
}

- (void)initailSubViews{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    ButtonClickBlock block = ^(){
        
        NSLog(@"哈哈哈");
        [self testAddIvar];
    };
    objc_setAssociatedObject(self, @selector(click), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)click{
    
    ButtonClickBlock block = objc_getAssociatedObject(self, @selector(click));
    if(block){
        
        block();
    }
}

- (void)testAddIvar{
    
    Class NATestCreateViewController = objc_allocateClassPair([UIViewController class], "NATestCreateViewController", 0);
    class_addIvar(NATestCreateViewController, "_fiveIvar", sizeof(NSString *), log(sizeof(NSString *)), "i");
    Ivar ivar = class_getInstanceVariable(NATestCreateViewController, "_fiveIvar");
    
    //这里只能用实例才能设置和取出ivar的值
//    id object = [NATestCreateViewController new];
//    object_setIvar(object, ivar, @"five");
//    id result = object_getIvar(object, ivar);
    objc_registerClassPair(NATestCreateViewController);

    u_int size = class_getInstanceSize(NATestCreateViewController);
    
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t policy = {"C", ""};
    objc_property_attribute_t backing = {"V", "_fiveIvar"};
    
    objc_property_attribute_t attrs[] = {type, policy, backing};
    
    class_addProperty(NATestCreateViewController, "_fiveIvar", attrs, 3);
    //添加完属性后并不会添加成员变量，而且没有get和set方法，需要自己添加，这里添加的set和get方法也是通过上面的object_getIvar和object_setIvar方法。
    
    SEL getter = NSSelectorFromString(@"fiveIvar");
    SEL setter = NSSelectorFromString(@"setFiveIvar:");
    class_addMethod(NATestCreateViewController, getter, (IMP)fiveGetter, "@@:");
    class_addMethod(NATestCreateViewController, setter, (IMP)fiveSetter, "v@:@");
    
    id object = [NATestCreateViewController new];
    [object performSelector:setter withObject:@"five_property"];
    
    id result = [object performSelector:getter];
//    id result = [self performSelector:@selector(getFiveIvar)];
//    [self testReturnValue];
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList(NATestCreateViewController, &count);
    for(int i=0; i<count; i++){
        
        Ivar iv = ivars[i];
        NSLog(@"%s",ivar_getName(iv));
    }
    free(ivars);
    
    objc_property_t *properties = class_copyPropertyList(NATestCreateViewController, &count);
    
    for(int j=0; j<count; j++){
        
        objc_property_t proper = properties[j];
        NSLog(@"%s",property_getName(proper));
    }
    free(properties);
    
    
    Method *methods = class_copyMethodList([self class], &count);
    //如果有属性(确切的说是有成员变量ivar)，就会多生成一个方法cxx_destruct,这个方法来处理成员变量的释放，释放的过程先调用dealloc，此时并不会成员变量不会释放，之后返回dealloc，然后自动调用super dealloc，最后调用到根类的dealloc，在这里会做三件事：
//    1. 执行一个叫object_cxxDestruct的东西干了点什么事（
//    1. 只有在ARC下这个方法才会出现（试验代码的情况下）
//    2. 只有当前类拥有实例变量时（不论是不是用property）这个方法才会出现，且父类的实例变量不会导致子类拥有这个方法
//    3. 出现这个方法和变量是否被赋值，赋值成什么没有关系
    
//    ）
//
//    2. 执行_object_remove_assocations去除和这个对象assocate的对象（常用于category中添加带变量的属性，这也是为什么ARC下没必要remove一遍的原因 (Edit: 在ARC或MRC下都不需要remove，感谢@sagles的基情提示）
//
//    3. 执行objc_clear_deallocating，清空引用计数表并清除弱引用表，将所有weak引用指nil（这也就是weak变量能安全置空的所在）
    for(int k=0; k<count; k++){
        
        Method meth = methods[k];
        NSLog(@"%@",NSStringFromSelector(method_getName(meth)));
    }
}


NSString * fiveGetter(id obj, SEL _cmd){
    
    Ivar ivar = class_getInstanceVariable([obj class], "_fiveIvar");
    
   return object_getIvar(obj, ivar);
    
}

void fiveSetter(id obj, SEL _cmd, NSString *fiveIvarStr){
    
    Ivar ivar = class_getInstanceVariable([obj class], "_fiveIvar");
    object_setIvar(obj, ivar, fiveIvarStr);
}






- (void)testReturnValue{
    
    //这个方法和    [self performSelector:@selector(getFiveIvar) withObject:nil];效果一样，不过可以方便的穿多个参数。
    NSMethodSignature *sig = [self methodSignatureForSelector:@selector(getFiveIvar)];
    
    sig = [NSMethodSignature signatureWithObjCTypes:"@@:"];
    
    NSInvocation *invoca = [NSInvocation invocationWithMethodSignature:sig];
    
    NSString *str = @"five";
    [invoca setArgument:&str atIndex:2];//设置参数，因为有两个隐藏函数
    [invoca retainArguments];//防止参数释放
    
    invoca.target = self;
    invoca.selector = @selector(getFiveIvar);
    __autoreleasing id value = nil;
    [invoca invoke];
//    sig.methodReturnType
    [invoca getReturnValue:&value];//这里如果返回值是void（v）就会 崩溃,可以用上面的方法检测返回值类型。
    
    NSLog(@"%@",value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private

- (void)goNext{
    
    
    NATestFiveViewController *fiveVC = [[NATestFiveViewController alloc]init];
    
    [self.navigationController pushViewController:fiveVC animated:YES];
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
