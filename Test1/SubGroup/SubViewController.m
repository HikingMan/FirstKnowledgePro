//
//  SubViewController.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/23.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "SubViewController.h"
#import "ReSubViewController.h"
#import <objc/message.h>
#import "CreateQRImage.h"
#import "TestModel.h"

@interface SubViewController ()
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *leftLable;

@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (nonatomic, strong)UIImageView *qrImageView;

@property (nonatomic,strong)dispatch_source_t timer;
@end

@implementation SubViewController
- (IBAction)backClicked:(id)sender {

    //这个方法改变父类的isa指针，指向子类，返回值是父类的class，之后用self调用方法，会调用子类的方法。
    Class subClass = object_setClass(self, [ReSubViewController class]);
    
    [self testMothod];
    
    [self testResult];
    //重新将self的指针都指向self。
    object_setClass(self, subClass);
    
    
    [self testResult];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)testMothod{
    NSLog(@"我是不牛逼的父类");
}

-(void)testResult{
    NSLog(@"设置完子类呢");
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"生成二维码" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(100, 100, 100, 100)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(getQRImage) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundColor:[UIColor cyanColor]];

    [self.view addSubview:button];

    self.qrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 300, 80, 80)];
    self.qrImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.qrImageView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QRTap:)];
    self.qrImageView.userInteractionEnabled = YES;
    [self.qrImageView addGestureRecognizer:tap];
    
    
    //这里测试按比例布局，其中还有约束优先级配置
    //这里是相关链接http://blog.csdn.net/CaryaLiu/article/details/49283699
    self.leftLable.text = @"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    self.rightLabel.text = @"呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵呵";
    // Do any additional setup after loading the view.
}

- (void)getQRImage{
    
    UIImage *image = [CreateQRImage getQRImageWithSource:@"https://www.baidu.com" imageSize:CGSizeMake(80, 80) logo:nil midLogoSize:CGSizeZero];
    
    if(nil != image){
        [self.qrImageView setImage:image];
        self.qrImageView.backgroundColor = [UIColor clearColor];
    }
}

- (void)QRTap:(UITapGestureRecognizer *)gesture{
    
    [TestModel startParase];
    
    
    //这里必须使用成员变量来接收timer。否则不启动
    __block int j=0;
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 1.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        NSLog(@"aaaa%ld",j++);
        if(j==10){
            dispatch_cancel(self.timer);
        }
    });
    dispatch_resume(self.timer);
//    [self dismissViewControllerAnimated:YES completion:nil];
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
