//
//  ReSubViewController.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/23.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "ReSubViewController.h"

@interface ReSubViewController ()

@end

@implementation ReSubViewController


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    NSLog(@"1");
    if(self = [super initWithCoder:aDecoder]){
        
    }
    return self;
}

- (void)awakeFromNib {
    
    NSLog(@"2");
    [super awakeFromNib];
    
}

- (void)viewWillLayoutSubviews{
    NSLog(@"3");
}
- (void)viewDidLayoutSubviews{
    
    NSLog(@"4");
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"6");
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"7");
    [super viewDidAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"8");
    [super viewWillDisappear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"9");
    [super viewDidDisappear:animated];
}
- (void)viewLayoutMarginsDidChange{
    NSLog(@"10");
    [super viewLayoutMarginsDidChange];
}
- (void)viewSafeAreaInsetsDidChange {
    NSLog(@"11");
    [super viewSafeAreaInsetsDidChange];
    
}

- (void)viewDidLoad {
    NSLog(@"5");
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)backClicked:(id)sender {
    
    [self testMothod];
}
-(void)testMothod{
    NSLog(@"我是牛逼的子类");
}

-(void)testResult{
    NSLog(@"我是子类设置完子类呢");
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
