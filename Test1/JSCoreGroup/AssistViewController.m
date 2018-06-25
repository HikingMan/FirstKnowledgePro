//
//  AssistViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/6/4.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "AssistViewController.h"
#import "TestJSCoreViewController.h"

@interface AssistViewController ()

@end

@implementation AssistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"next" style:UIBarButtonItemStyleDone target:self action:@selector(goNext)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"refresh" style:UIBarButtonItemStyleDone target:self action:@selector(test2)];
    
//    [self test1];
    [self test3];
    // Do any additional setup after loading the view.
}

- (void)test1{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    label.text = @"123";
    label.backgroundColor = [UIColor redColor];
    [self.view addSubview:label];
    
//    CABasicAnimation *animamove = [CABasicAnimation animationWithKeyPath:@"position"];
//    animamove.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
//    animamove.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
//    animamove.duration = 1.0f;
//    animamove.fillMode = kCAFillModeForwards;
//    animamove.removedOnCompletion = NO;
//    animamove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [label.layer addAnimation:animamove forKey:@"positionAnimation"];
//
//    CABasicAnimation *animarotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    animarotation.toValue = [NSNumber numberWithFloat:M_PI];
//    animarotation.duration = 1.0f;
//    animarotation.fillMode = kCAFillModeForwards;
//    animarotation.removedOnCompletion = NO;
//
//    [label.layer addAnimation:animarotation forKey:@"rotationAnimation"];
//
//    CAAnimationGroup *animagroup = [CAAnimationGroup animation];
//    animagroup.animations = @[animamove,animarotation];
//    animagroup.duration = 2.0f;
//    animagroup.fillMode = kCAFillModeForwards;
//    animagroup.removedOnCompletion = NO;
////    [label.layer addAnimation:animagroup forKey:@"groupAnimation"];
    
    
    
    
    
}
- (void)test2{
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    label2.text = @"456";
    label2.backgroundColor = [UIColor clearColor];
    [self.view addSubview:label2];
    
    CABasicAnimation *animamove = [CABasicAnimation animationWithKeyPath:@"position"];
    animamove.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 200)];
    animamove.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 200)];
    animamove.duration = 1.0f;
    animamove.fillMode = kCAFillModeForwards;
    animamove.removedOnCompletion = NO;
    animamove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [label2.layer addAnimation:animamove forKey:@"positionAnimation"];
    
    CABasicAnimation *animarotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    animarotation.toValue = [NSNumber numberWithFloat:M_PI];
    animarotation.fillMode = kCAFillModeForwards;
    animarotation.removedOnCompletion = NO;
    
    [label2.layer addAnimation:animarotation forKey:@"rotationAnimation"];
    
    
        CAAnimationGroup *animagroup2 = [CAAnimationGroup animation];
        animagroup2.animations = @[animarotation,animamove];
        animagroup2.duration = 2.0f;
        animagroup2.fillMode = kCAFillModeForwards;
        animagroup2.removedOnCompletion = NO;
//        [label2.layer addAnimation:animagroup2 forKey:@"groupAnimation2"];


}

- (void)test3{
    
    
    
}



- (void)goNext{
    
    TestJSCoreViewController *jsVC = [TestJSCoreViewController new];
    [self.navigationController pushViewController:jsVC animated:YES];
    
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
