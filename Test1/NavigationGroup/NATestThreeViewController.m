//
//  NATestThreeViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/1/15.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NATestThreeViewController.h"

@interface NATestThreeViewController ()

@end

@implementation NATestThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Third Page";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if(self.block){
        
        self.block(@"Start Call Back");
    }
    // Do any additional setup after loading the view.
}

- (void)dealloc{
    
    
    NSLog(@"three dealloc");
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
