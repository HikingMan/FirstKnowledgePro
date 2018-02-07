//
//  TestViewController.m
//  Test1
//
//  Created by Wang HongLu on 2017/11/20.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TestViewController.h"
#import "TestSnapWebview.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewWillLayoutSubviews{
    NSLog(@"这样就准确了will");
}
- (void)viewDidLayoutSubviews{
    NSLog(@"这样就准确了did");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    TestSnapWebview *snapView = [[TestSnapWebview alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:snapView];
    
    
    
    // Do any additional setup after loading the view.
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
