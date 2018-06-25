//
//  NATestFiveViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/5/25.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NATestFiveViewController.h"
#import "WheelPlayScrollView.h"

@interface NATestFiveViewController ()
{
    
    NSArray *array;
    NSInteger count;
    
    dispatch_semaphore_t sema;
}
@end

@implementation NATestFiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    array = @[@"0",@"1",@"2",@"3",@"4",@"5"];
    count = 50;

    
    
    
    
    
//    [self fiveTest1];
//    [self fiveTest2];
//    [self testFive3];
//    [self testFive4];
    [self testFive5];
    
//    [self testFive6];
    
    
    
    // Do any additional setup after loading the view.
}

//barrier障碍 （先完成所有barrier之前的任务，然后执行barrier，然后执行barrier之后的任务,只有在异步并行队列中执行）；
- (void)fiveTest1{
    
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    for(int i=0; i<array.count; i++){
        
        if(i<3){
            
            dispatch_async(queue, ^{
                
                //这里线程睡眠2秒，如果没有barrier的话，应该先执行i>3的情况，但是barrier等待queue中前面的block值性完毕之后，会有一个较长时间差之后再去执行barrier中的block，之后再执行barrier之后的block。
                [NSThread sleepForTimeInterval:2];
                NSLog(@"****%d***",i);
            });
        }else if (i == 3){
            dispatch_barrier_async(queue, ^{
               
                NSLog(@"****%d***",i);
            });
            
        }else{
            
            dispatch_async(queue, ^{
               
                NSLog(@"****%d***",i);

            });
        }
    }
    
}
//group (在所有添加到group里面的任务block完成之后，才会执行dispatch_group_notify,多用于异步并行队列，串行队列或同步执行都会按顺序输出)；
-(void)fiveTest2{
    
    NSLog(@"---start---");
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT);
    for(int i=0; i<array.count; i++){
        
        NSInteger random = arc4random()%5+1;
        
//        dispatch_group_async(group, queue, ^{
//
//            [NSThread sleepForTimeInterval:random];
//            NSLog(@"---%d---",i);
//        });
        
        //dispatch_group_enter和dispatch_group_leave必须成对出现，下面的代码和上面的代码实现的效果等价
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            
            [NSThread sleepForTimeInterval:random];
            NSLog(@"---%d---",i);
            dispatch_group_leave(group);
        });
    }
    dispatch_group_notify(group, queue, ^{

        NSLog(@"---finishi---");
    });
    //dispatch_group_wait相当于设置了group的超时时间，会阻塞当前线程，所以两秒（设置的时间可以是forever）之后才会打印10。
    dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC));
    NSLog(@"---10---");
}
//semaphore(信号量),多用于是操作同步,也可以保证线程安全，为线程枷锁
//也可以用于控制线程并发数量，原理也是根据sema中的值是否等于0来区分（一般不这么用）
- (void)testFive3{
    
    //线程同步
    sema = dispatch_semaphore_create(0);
    
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
       
        [NSThread sleepForTimeInterval:2];
        NSLog(@"over");
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"ok,i know it's over");
    
    //线程加锁
//    sema = dispatch_semaphore_create(1);
//
//    dispatch_queue_t queue1 = dispatch_queue_create("queue1", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t queue2 = dispatch_queue_create("queue2", DISPATCH_QUEUE_CONCURRENT);
//
//    dispatch_async(queue1, ^{
//
//        [self reduce];
//    });
//    dispatch_async(queue2, ^{
//
//        [self reduce];
//    });
}
- (void)reduce{
    
    //dispatch_semaphore_wait如果大于1，就会往下执行并减1；如果是0就会一直等待不往下执行（这时就相当于加锁）；
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    //如果没用信号量，打印出的数字不是顺序输出的，是错乱的。
    while(1){
        
        if(count>0){
            
            count--;
            NSLog(@"===%d===%@",(int)count,[NSThread currentThread]);
            [NSThread sleepForTimeInterval:0.2];
            //相当于加1（这时sema变成1，相当于解锁）
            dispatch_semaphore_signal(sema);
        }else{
            
            dispatch_semaphore_signal(sema);
            return;
        }
    }
}

//apply 快速迭代，将任务分发到多个线程中执行，并且同步阻塞，只有所有任务完成之后才会返回.(因为任务分发到多个线程所以效率比for循环高，但是如果是串行队列就和for循环一样)
- (void)testFive4{
    
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_apply(array.count, queue, ^(size_t index) {
    
        NSInteger random = arc4random()%5+1;
        [NSThread sleepForTimeInterval:random];;
        
        NSLog(@"####%d####%@",(int)index,[NSThread currentThread]);
    });
    NSLog(@"finishi");
}


//同步，异步和串行，并发(这里是并发，因为cpu执行是在多个线程之间切换，因为速度快所以看起来是一起执行，其实是这个执行一部分有可能就去执行另一个)
- (void)testFive5{
    
    //    dispatch_async异步执行具有开启线程的能力
    //    dispatch_sync同步执行没有开启线程的能力，只能在当前线程执行，会把任务加在最后
    
    //    DISPATCH_QUEUE_CONCURRENT 并发队列（异步执行在各个线程中执行，不能确定哪个先执行完；同步执行没有开启新线程，顺序执行）
    //    DISPATCH_QUEUE_SERIAL 串行队列（异步执行开启一个新线程，在新线程中，任务都加到队列最后,顺序执行;同步执行不开启线程，顺序执行）
    //主线程是串行队列，全局队列是并发队列
    
    dispatch_queue_t serialQueue =  dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("conCurrnet", DISPATCH_QUEUE_CONCURRENT);
    
    NSLog(@"CURRENT THREAD %@",[NSThread currentThread]);

//    for(int i =0; i<array.count; i++){
//
//        dispatch_async(serialQueue, ^{
//
//            //在新的线程中顺序执行
//            NSInteger random = arc4random()%5+1;
//            [NSThread sleepForTimeInterval:random];
//            NSLog(@"***%@***%d",[NSThread currentThread],(int)i);
//        });
//    }

//    for(int i =0; i<array.count; i++){
//
//        //这里如果是主队列就会死锁崩溃
//        dispatch_sync(serialQueue, ^{
//
//            //在主线程顺序执行
//            NSInteger random = arc4random()%5+1;
//            [NSThread sleepForTimeInterval:random];
//            NSLog(@"***%@***%d",[NSThread currentThread],(int)i);
//        });
//    }

//    for(int i =0; i<array.count; i++){
//
//        dispatch_async(concurrentQueue, ^{
//
//            NSInteger random = arc4random()%5+1;
//            [NSThread sleepForTimeInterval:random];
//            NSLog(@"***%@***%d",[NSThread currentThread],(int)i);
//        });
//    }

    for(int i =0; i<array.count; i++){

        //在主线程顺序执行
        dispatch_sync(concurrentQueue, ^{

            NSInteger random = arc4random()%5+1;
            [NSThread sleepForTimeInterval:random];
            NSLog(@"***%@***%d",[NSThread currentThread],(int)i);
        });
    }
    
    
    
}

- (void)testFive6{
    
    NSArray *sourceArray = @[@"http://client.echengbus.com/assets/images/office/banner0420.png",@"http://client.echengbus.com/assets/images/v4/theme/banner/banner0110@2x.png",@"http://client.echengbus.com/assets/images/office/banner0420.png",@"http://client.echengbus.com/assets/images/v4/train/banner1215.png"];
    
    WheelPlayScrollView *wheel=[[WheelPlayScrollView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height/540*268) source:sourceArray];
    
    wheel.block=^(NSInteger index)
    {
        
        
    };
    [self.view addSubview:wheel];
    
    if(sourceArray.count>1)
    {
        [self.view addSubview:wheel.pageControl];
    }
    
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
