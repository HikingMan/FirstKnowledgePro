//
//  NATestSecondViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/1/15.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NATestSecondViewController.h"
#import "StartEndInputViewFinal.h"
#import "NATestThreeViewController.h"
#import "NSTimer+WHLTimerCate.h"
#import "TryFirstModel.h"

@interface NATestSecondViewController ()

@property (nonatomic,strong)StartEndInputViewFinal *inputView;

@property (nonatomic,strong)NSTimer *testTimer;
@end


@implementation NATestSecondViewController


__weak id weakObj = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Second Page";

    self.view.backgroundColor = [UIColor whiteColor];

    UIView *testView = [[UIView alloc]initWithFrame:CGRectMake(0, 300, 100, 100)];
    testView.backgroundColor = [UIColor redColor];
    [self.view addSubview:testView];

    [UIView animateWithDuration:0.25 delay:0.3 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        testView.frame = CGRectMake(200, 300, 100, 100);

    } completion:^(BOOL finished) {

    }];

    [self initailSubView];

    __block NSInteger i = 0;
//    self.testTimer = [NSTimer whl_scheduledTimerWithTimeInterval:1.0 repeats:YES
//                                                           block:^(NSTimer *timer) {
//                                                               
//                                                               NSLog(@"%ld",i++);
//                                                           }];
    
    
    //每个线程都有各自的自动释放池，主线程在初始化的时候也有自己的自动释放池。(称作NSAutoReleasPool)

//    1.autorelease对象（测试过程中都是方法中的临时变量）在超出其作用范围时 调用AutoreleasePoolPage::pop(void *)来执行release操作引用计数-1，引用计数变为0，之后会调用dealloc方法。 可能存在时间差的问题(这里引发的思考啊，可能viewdidload执行完直接就调用了viewWillAppear相当于array所在的函数还没有执行完，而viewDidAppear则是通过runloop来检测并发送通知才执行的)，这里的释放过程是在viewWillAppear和viewDidAppear之间的,*****这里特别说明一下，只有是数组才会在这个时间段释放(可能需要先释放内部对象吧)，如果是对象，在viewWillAppear的时候已经被释放了
    
    
    //这里不能用array 来实验，下面的array的引用计数是2,如果数组初始化的时候为空，引用计数就是-1。
    NSArray *array = [NSArray arrayWithObjects:@(2),nil];
    
    
    NSArray *array1 = [NSArray arrayWithObject:@"11"];
    
    TryFirstModel *model = [TryFirstModel new];
    
    weakObj = array;

//    2.在自己的创建的释放池时会执行objc_autoreleasePoolPush()，当超出释放池的作用域，即释放池要调用drain方法的时候，释放池里面的autorelease对象还要做一次relese操作即objc_autoreleasePoolPop（）；
    //因此当出下面方法的时候，array的引用计数已经为0，
//    @autoreleasepool{
//        TryFirstModel *model = [TryFirstModel new];
//
//        weakObj = model;
//
//        //        走出作用域时release一次，释放池drain时释放一次最后为0
//    }

    NSLog(@"111%@",weakObj);
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"222%@",weakObj);
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    NSLog(@"333%@",weakObj);
}

- (void)initailSubView{

    _inputView = [[StartEndInputViewFinal alloc]initWithFrame:CGRectMake(12.5, 10, [UIScreen mainScreen].bounds.size.width-25, 90)];
    [self.view addSubview:_inputView];

    __weak typeof(self) weakSelf = self;
    _inputView.searchBlock  = ^(void){

        __strong typeof(self) strongSelf = weakSelf;
        NATestThreeViewController *naTT = [[NATestThreeViewController alloc]init];


        [strongSelf.navigationController pushViewController:naTT animated:YES];

    };


    _inputView.inputBlock = ^(StartEndInputTextField *isInputingField) {

        __strong typeof(self) strongSelf = weakSelf;

        NATestThreeViewController *naTT = [[NATestThreeViewController alloc]init];
        naTT.block = ^BOOL(NSString *str) {

            isInputingField.text = str;
            return YES;
        };
        [strongSelf.navigationController pushViewController:naTT animated:YES];

    };

}

- (void)dealloc{

    [self.testTimer invalidate];
    NSLog(@"second dealloc");

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
