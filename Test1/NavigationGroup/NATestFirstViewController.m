//
//  NATestFirstViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/1/15.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NATestFirstViewController.h"
#import "NATestSecondViewController.h"

@interface NATestFirstViewController ()


@end

@implementation NATestFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"First Page";
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"next" style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    [self initailSubView];
    // Do any additional setup after loading the view.
}

- (void)initailSubView{
    
    
}



- (void)rightClick{
    
    
    
    
    NATestSecondViewController *test = [[NATestSecondViewController alloc]init];

    [self.navigationController pushViewController:test animated:YES];
    
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
