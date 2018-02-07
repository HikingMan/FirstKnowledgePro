//
//  StartEndViewController.m
//  Test1
//
//  Created by Wang HongLu on 2017/11/28.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "StartEndViewController.h"
#import "StartEndInputView.h"
#import "TestSouceOneViewController.h"

@interface StartEndViewController ()<goInputDelegate>

@property (nonatomic,strong)StartEndInputView *inputView;
@end

@implementation StartEndViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    StartEndInputView *inputView = [[StartEndInputView alloc]initWithFrame:CGRectMake(20, 50, self.view.frame.size.width-40, 70)];
    inputView.delegate = self;
    
    inputView.layer.borderWidth = 1;
//    inputView.layer.borderColorf = [UIColor blackColor].CGColor;
    [self.view addSubview:inputView];
    
    _inputView = inputView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setFrame:CGRectMake(50, 200, 200, 50)];
    [button setTitle:@"测试" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor greenColor]];
    [button addTarget:self action:@selector(testClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"我的钱包"] forState:UIControlStateNormal];
    //在button的width大于（图片和内容的总和）的时候，默认是在中间的，下面两行代码是将内容放在了左上角
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    //这里的edgeinsets是偏移量，（10，20，0，0）代表，向下偏移了10，向右偏移了20；
    [button setImageEdgeInsets:UIEdgeInsetsMake(10, 20, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(15, button.bounds.size.width-button.imageView.bounds.size.width-20-button.titleLabel.bounds.size.width, 0, 0)];
    
    
    
    [self.view addSubview:button];
    // Do any additional setup after loading the view.
}
- (void)testClick:(UIButton *)button{
    
    NSString *startStr = _inputView.startField.text;
    
    NSString *endStr = _inputView.endField.text;
    
    NSLog(@"%@===%@",startStr,endStr);
}

- (void)goInputWithClickField:(UITextField *)textField{
    
    TestSouceOneViewController *source = [TestSouceOneViewController new];
    
    source.block = ^(NSString * inputStr) {
      
        textField.text = inputStr;
    };
    [self presentViewController:source animated:YES completion:nil];
    
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
