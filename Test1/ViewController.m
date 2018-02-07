//
//  ViewController.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/18.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "ViewController.h"
#import "SubViewController.h"
#import "ReSubViewController.h"
#import "TestViewController.h"
#import "TestSouceOneViewController.h"
#import "StartEndViewController.h"

#import <mach/machine.h>


typedef void(^TestBlcok)(BOOL isIn);
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *testLable;
@property (weak, nonatomic) IBOutlet UIButton *testButton;
@property (weak, nonatomic) IBOutlet UIView *testView;

@property (nonatomic,strong)dispatch_queue_t queue;

@end

@implementation ViewController
- (IBAction)testButtonClicked:(id)sender {
    
//    UIStoryboard *tryfirstSB = [UIStoryboard storyboardWithName:@"TryFirst" bundle:nil];
//
//    UINavigationController * na = [tryfirstSB instantiateInitialViewController];
//
//    [self presentViewController:na animated:YES completion:nil];
    
    //下面这两行代码会执行initWithCoder和awakeFromNib这两个方法
    UIStoryboard *subStory =[UIStoryboard storyboardWithName:@"Sub" bundle:nil];
    UIViewController *VC = [subStory instantiateViewControllerWithIdentifier:@"Sub"];
    
    //使用alloc方法会执行两次viewWillLayoutSubviews和viewDidLayoutSubviews
//    UIViewController *VC = [[TestViewController alloc]init];
    [self presentViewController:VC animated:YES completion:nil];
    NSLog(@"button已经被点击了");
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.testLable.text=@"生生灯火明暗无辄，看着迂回的伤痕却不能为你做什么，我恨我，躲在永夜的背后，找微光的出口；生生你我离别无辄，每一道岁月的痛，眼泪自答自问，眼前是永昼的颠簸";
    self.testLable.numberOfLines=0;


    NSString *str1 = @"111";
    NSString *str2 = [str1 copy];
    
//    NSLog(@"%p====%p",str1,str2);
//
//    str2 = @"222";
//    NSLog(@"%p",str2);
    
    NSMutableArray *array1 = [[NSMutableArray alloc]initWithObjects:@"11",@"22", nil];
    NSArray *array2 = [array1 mutableCopy];
    BOOL result2 = [array2 isMemberOfClass:[NSArray class]];
    NSArray *array3 = [array2 copy];
    
    NSLog(@"%@===%@",NSStringFromClass([array2 class]),NSStringFromClass([array3 class]));
    
    NSLog(@"%p === %p === %p",array1,array2,array3);
    
    [self mytest1];
    
    [self myTest];
    
    
    

    
    
    // Do any additional setup after loading the view, typically from a nib.
}


-(void)myTest{
    //这里取消串行队列的任务
//    self.queue=dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
//    
//    for(int i=0;i<10;i++){
//        
//        dispatch_async(self.queue, ^{
//            NSLog(@"%d===",i);
//            if(i==3){
//                
//                dispatch_suspend(self.queue);
//                dispatch_source_cancel(self.queue);
//                NSLog(@"====%@",self.queue);
//            }
//        });
//    }
    
    //同步执行任务时，不会开启新的线程，会加在当前线程的最后
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"%@======",[NSThread currentThread]);
//        dispatch_sync(dispatch_queue_create("myqueue", DISPATCH_QUEUE_CONCURRENT), ^{
//            NSLog(@"%@===",[NSThread currentThread]);
//            NSLog(@"hahah");
//        });
//    });
//    
    
 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testViewTaped:(id)sender {
    
    TestSouceOneViewController *sourceOne = [TestSouceOneViewController new];
    [self presentViewController:sourceOne animated:YES completion:nil];

//    StartEndViewController * seVC = [StartEndViewController new];
//
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:seVC animated:YES completion:nil];

    
    NSLog(@"testView被点击了");
}








- (void)mytest1
{
    int a[] = {4,3,5,8,9,6,4,2};
    
    int length =sizeof(a)/sizeof(int);
    
    //冒泡
    //    int aa=0;
    //    for(int i=0;i<length;i++){
    //
    //        for(int j=0;j<length-1-i;j++){
    //
    //            if(a[j]>a[j+1]){
    //
    //                aa=aa+1;
    //                int temp=a[j+1];
    //                a[j+1]=a[j];
    //                a[j]=temp;
    //            }
    //
    //        }
    //    }
    
    //    选择
    //    int aa =0;
    //    for(int i=0;i<length;i++)
    //    {
    //        int tag =i;
    //        for(int j=i+1;j<length;j++){
    //
    //            if(a[tag]>a[j]){
    //                tag=j;
    //            }
    //        }
    //        if(tag!=i){
    //            aa=aa+1;
    //            int temp=a[i];
    //            a[i]=a[tag];
    //            a[tag]=temp;
    //        }
    //    }
    
    
    //折半插入
    for(int i=1;i<length;i++){
        
        int min =0;
        int max =i-1;
        
        int temp=a[i];
        while (min<=max) {
            
            int mid =(min+max)/2;
            if(a[mid]>temp){
                
                max=mid-1;
                
            }else if (a[mid]<=temp){
                
                min=mid+1;
                
            }
        }
        
        for(int j=i;j>min;j--){
            
            a[j]=a[j-1];
        }
        
        a[min]=temp;
        
        
        
    }
    
    //    int num=search(a,length,6);
    
    NSLog(@"result");
}
//折半
int search(int *a ,int n ,int key){
    
    int max = n-1;
    int min = 0;
    
    for(int i=min;i<=max;i++){
        
        int mid =(min+max)/2;
        if(key<a[mid]){
            max=mid-1;
        }else if (key>a[mid]){
            
            min=mid+1;
            
        }
        else{
            return mid;
        }
        
        
    }
    
    
    return -1;
}



@end
