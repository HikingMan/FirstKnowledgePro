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

@interface NATestSecondViewController ()

@property (nonatomic,strong)StartEndInputViewFinal *inputView;

@property (nonatomic,strong)NSTimer *testTimer;
@end

@implementation NATestSecondViewController

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
    self.testTimer = [NSTimer whl_scheduledTimerWithTimeInterval:1.0 repeats:YES
                                                           block:^(NSTimer *timer) {
                                                               
                                                               NSLog(@"%ld",i++);
                                                           }];
    
    // Do any additional setup after loading the view.
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
