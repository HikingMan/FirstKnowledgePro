//
//  NATestFirstViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/1/15.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NATestFirstViewController.h"
#import "NATestSecondViewController.h"
#import "HL_PickerView.h"
#import "Masonry.h"


@interface NATestFirstViewController ()<HLPickerProtocol>

@property (nonatomic,strong)HL_PickerView *picker;

@property (nonatomic,strong)NSString *name;
@property (nonatomic,copy)NSString *nName;
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
    
    UIView *layoutView = [UIView new];
    layoutView.translatesAutoresizingMaskIntoConstraints = NO;
    layoutView.backgroundColor = [UIColor redColor];
    

    [self.view addSubview:layoutView];

    NSLayoutConstraint *constraint1 = [NSLayoutConstraint constraintWithItem:layoutView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:80];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:layoutView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    NSLayoutConstraint *constraint3 = [NSLayoutConstraint constraintWithItem:layoutView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    NSLayoutConstraint *constraint4 = [NSLayoutConstraint constraintWithItem:layoutView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:40];
    
    //这里必须是用父视图来添加约束，因为这个约束是相对父视图的，可以想象一下storyboard的场景
    [self.view addConstraints:@[constraint1,constraint2,constraint3,constraint4]];
        // Do any additional setup after loading the view.
    
    UIView *testMasView = [UIView new];
    [self.view addSubview:testMasView];
    
    
    //mas_makeConstraints是UIView的类别View+MASAdditions中的。
   /* - (NSArray *)mas_makeConstraints:(void(^)(MASConstraintMaker *))block {
        self.translatesAutoresizingMaskIntoConstraints = NO;//关闭自动添加约束。
        MASConstraintMaker *constraintMaker = [[MASConstraintMaker alloc] initWithView:self];//创建maker对象，每个UIView生成一个maker
        block(constraintMaker);//操作用户添加的所有约束
        return [constraintMaker install];//将约束布局到UIView上，相当于addConstraints，返回值是添加的所有约束数组，类型是MASViewConstraint。
    }*/
//    View+MASAdditions类别中还有两个和mas_makeConstraints类似的方法：
//    1.mas_updateConstraints将maker对象中的updateExisting设置为YES,之后根据这个属性检查被添加的约束，如果添加了就更新，如果没有添加就添加，其他部分和mas_makeConstraints一样
//    2.mas_remakeConstraints将maker对象中的removeExisting设置为YES，之后根据这个属性将当前视图的旧的约束删除，然后添加新的约束
    
//    最后一个方法mas_closestCommonSuperview寻找当前视图和参数中的视图的公共父视图，如果a相对于b布局，那么约束就添加a和b的公共父视图；如果b是a的父视图，约束就添加到b上
    
//    其他的就是MASViewAttribute类型的约束属性，属性的getter中传入view，item和layoutAttribute来生成对应的MASViewAttribute。
//    view：即当前的view；
//    item：如果是view并且不是UILayoutGuide的属性则是当前的view；否则就会根据不同的属性返回对应的UILayoutGuide的值。
//    layoutAttribute：即对应的NSLayoutConstraint属性。
//    MASViewAttribute保存这些数据可以读取约束值，而且之后的
//    MASViewAttribute还有一个isSizeAttribute属性，因为NSLayoutAttributeHeight和NSLayoutAttributeWidth是要加到当前view上的
//    约束对象MASViewConstraint也是根据MASViewAttribute来创建的。
    
//    UILayoutGuide是在ios9之后添加的占位对象，他可以设置约束，添加到view中，参与布局。但是不会渲染，不会响应事件（应用场景：两个控件需要成组后居中，一般都是添加一个背景view，设置view的居中，但是view会响应事件和渲染出来，这时可以使用UILayoutGuide）
    
    //下面的代码打印顺序是1，2，3，因为在mas_makeConstraints中并没有持有这个block，而是直接调用block，所以这个block是在栈中的，所以也不会使用__weak来避免循环引用
    NSLog(@"1");
    NSArray *array = [testMasView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        NSLog(@"2");
        make.top.equalTo(self.view);
    }];
    NSLog(@"3");
    
//    MASConstraintMaker中包含所有和约束相关的MASConstraint类型的属性，MASConstraint是抽象类，一般用到子类MASViewConstraint。
//    当用getter方法访问这些属性的时候，最终调用到
//    - (MASConstraint *)constraint:(MASConstraint *)constraint addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute {
//        MASViewAttribute *viewAttribute = [[MASViewAttribute alloc] initWithView:self.view layoutAttribute:layoutAttribute];//根据maker中的view和传入的NSLayoutAttribute生成MASViewAttribute对象
//        MASViewConstraint *newConstraint = [[MASViewConstraint alloc] initWithFirstViewAttribute:viewAttribute];//根据MASViewAttribute生成MASViewConstraint，因为是当前view的约束，所以这里对应设置了约束中的FirstViewAttribute。
//
//
//        //在MASViewConstraint和MASCompositeConstraint中都会调用到改方法，并将self作为constraint传入，在maker中constraint为nil。
////        MASCompositeConstraint相当于MASViewConstraint的数组也是MASConstraint的子类
//        if ([constraint isKindOfClass:MASViewConstraint.class]) {
////            这里如果是MASViewConstraint中调用该方法就会把新的约束和旧的约束放到MASCompositeConstraint中
//            //replace with composite constraint
//            NSArray *children = @[constraint, newConstraint];
//            MASCompositeConstraint *compositeConstraint = [[MASCompositeConstraint alloc] initWithChildren:children];
//            compositeConstraint.delegate = self;
//            [self constraint:constraint shouldBeReplacedWithConstraint:compositeConstraint];
//            return compositeConstraint;
//        }
//        if (!constraint) {
//            newConstraint.delegate = self;
//            [self.constraints addObject:newConstraint];//最终将要添加的约束添加到属组constraints中
//        }
//        //注意：这里生成的MASCompositeConstraint和MASViewConstraint的delegate都设置为maker，这样之后可以通过delegate调用maker的方法，包括当前方法，也就支持了链式调用。
//
////        链式调用：maker.top.left.right.equalTo(@10)；
////
////        这里maker.top 最终返回的MASViewConstraint对象，当执行到make.top.left时MASViewConstraint调用的是重写父类的- (MASConstraint *)addConstraintWithLayoutAttribute:(NSLayoutAttribute)layoutAttribute ;
////        该方法通过delegate来调用当前方法，最终实际是调用了maker.top和maker.left
//
//        return newConstraint;
//    }
    
//    maker在根据view生成maker的时候，会实例话一个数组constraints，用来保存block中添加的约束
//
//    最后是maker的install方法：这里涉及到mas_installedConstraints（NSMutableSet类型），这是在MASViewConstraint中通过runtime添加的属性映射，mas_installedConstraints保存了view已经添加的所有约束MASViewConstraint。
//    如果removeExisting是YES，需要先移除旧的约束，即mas_installedConstraints中的所有约束MASViewConstraint调用uninstall方法
//    之后获取到maker的constraints中保存的添加的约束，把maker的updateExisting传给MASViewConstraint的updateExisting来判断是否更新，然后调用MASViewConstraint的install方法。
    
//    MASViewConstraint的uninstall方法这里会判断约束是否是通过激活状态来控制约束，只有激活状态的约束才会影响最终的布局（一般修改约束的active值性能比addConstraint和removeConstraint更好），如果是激活状态，设置状态为未激活，然后用约束的firstViewAttribute.view得到被约束的视图，之后从已添加约束中删除[self.firstViewAttribute.view.mas_installedConstraints removeObject:self];
//    如果是不是通过激活状态约束，那么需要从被添加约束的视图installview中删除该约束，然后在从已添加约束mas_installedConstraints删除
    
//    MASViewConstraint的install方法：
//    1.判断是否已经install，如果是则返回；
//    2.如果是通过激活状态来控制约束，就设置激活状态后，直接把约束添加到已添加约束的数组mas_installedConstraints里。
//    3.MASViewConstraint初始化的时候会把参数MASViewAttribute来保存为_firstViewAttribute，这里面保存了当前view（被约束view），item和相对应的约束。
//    在equalToWithRelation方法中会传入view（uiview类型）或者view的约束mas_top（MASViewAttribute类型）,@(10)(NSValue类型)，这些都会传给_secondViewAttribute,会在_secondViewAttribute的set方法中最后都会变成MASViewAttribute类型返回。包括equelto，greater，less等方法都会走到这个方法并保存对应的NSLayoutRelation到layoutRelation。
//
//    之后的divideby，multiplierby会保存到layoutMultiplier；layoutPriority会保存对应的Priority
//
//    至此，生成NSLayoutConstraint的子类MASLayoutConstraint的所有约束都已经完成，然后找到添加约束的视图即installview（如果secondview存在就会找firstview和secondview的公共父视图；否则看看是不是sizeattribute的约束，是就添加到firstview上，如果不是，就添加到firstview的父视图上）
//
//    之后判断是不是更新约束然后查找相似约束，如果是直接赋值constant并保存约束；如果不是就添加约束addConstraint，并把约束添加到已添加约束数组中mas_installedConstraints添加
//    此时整个流程就算完成了
    
    
//    上面说到了链式调用，上面的那种是通过delegate实现的：还有下面这一种通过block；
//    make.left.equalTo(superView).offset(10);
//
//    这里equalTo(superView)肯定使用block来实现，要完成链式调用，必须有参数，然后返回值必须是当前调用对象
//
//    - (MASConstraint * (^)(CGFloat))offset {
//        return ^id(CGFloat offset){
//            self.offset = offset;
//            return self;
//        };
//    }
//    这些方法都是在MASConstraint中，最后的block中返回self。
//    因为链式调用中是MASViewConstraint来调用的，所以这就可以实现链式
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    _picker.hidden = YES;
}

- (void)initailSubView{
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    HL_PickerView *picker = [[HL_PickerView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    picker.delegate = self;
    [[UIApplication sharedApplication].keyWindow addSubview:picker];
    
    _picker = picker;
    
    
    
    UIView *testView = [UIView new];
    testView.backgroundColor = [UIColor cyanColor];
    testView.tag = 100;
    [self.view addSubview:testView];
    
    [testView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(0.5);
        make.width.equalTo(self.view);
        make.top.mas_equalTo(300);
        make.left.mas_equalTo(0);
    }];
    
    NSLog(@"%@",NSStringFromCGRect(testView.frame));
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://wx3.sinaimg.cn/mw690/0063Rz1Sgy1fhj7ljtzecj30u01hc1be.jpg"]];//此方法会阻塞当前线程，同步下载图片
//    UIImage *image = [UIImage imageWithData:data];
//    [imageView setImage:image];
//    
//    [self.view addSubview:imageView];
//    [self.view bringSubviewToFront:imageView];
    
    
}

- (void)viewDidLayoutSubviews{
    
    UIView *testView = [self.view viewWithTag:100];
    
    NSLog(@"%@",NSStringFromCGRect(testView.frame));
}

- (void)confirmDidClickWithResult:(NSArray *)resultArray{
    
    //网上说[self performSelector:@selector(test2) withObject:nil afterDelay:3];只能在主线程执行，在我看来其实说的不太对。
    //- (void)performSelector:(SEL)aSelector withObject:(nullable id)anArgument afterDelay:(NSTimeInterval)delay这个方法会生成一个定时器，哪怕他是0的时间，并加到当前线程的runloop，定时器创建的时候默认加到当前线程。但是自线程的runloop的默认关闭的，即使有输入源（定时器），没有runloop，定时器不会执行。
   
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT); dispatch_async(queue, ^{
        NSLog(@"1");
        
        
        [self performSelector:@selector(test2) withObject:nil afterDelay:3];
        [[NSRunLoop currentRunLoop] run];//如果没有这一行，会打印1，3。加上这一行之后runloop启动，就会打印定时器，之后定时器因为不是repeat的，所以没有了输入源，runloop又变成了睡眠状态，runloop不再死循环所以打印了3（1，2，3）；
        NSLog(@"3");
    });
//    NSLog(@"%@",resultArray);
}
- (void)test2{
    
    NSLog(@"2 === %@",[NSThread currentThread]);
}

- (NSArray *)pickerView:(HL_PickerView *)picker rowSourceWithIndex:(NSInteger)colunmIndex lastSelectRowKey:(NSString *)lastrow{
    //这里可以获取picker的resultarray 获取前面选中的数据
    if (lastrow && ![lastrow isEqualToString:@""]) {
        if([lastrow isEqualToString:@"4月10日"]){
            
            return @[@"1",@"2",@"3",@"4"];
        }
    }
    
    if(colunmIndex == 0){
        
        
        
        return @[@"3月10日",@"3月11日",@"3月12日",@"3月13日",@"4月10日",@"5月10日",@"10月10日",@"11月10日",@"12月10日"];
    }else if (colunmIndex == 1){
        
        
        
        return @[@"8",@"9",@"10",@"11",@"12",@"13",@"13",@"14",@"15"];
    }else if (colunmIndex == 2){
        
        return @[@"0",@"10",@"15",@"20",@"30",@"35",@"50",@"51",@"55"];
    }
    return nil;
    
}
- (NSInteger)pickerColunmNum{
    
    return 3;
}

- (CGFloat)spaceWidthWithIndex:(NSInteger)colunmIndex{
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if(colunmIndex == 0){
        
        return 70.0f;
    }else{
        
        return (width-70-30-30-80*2)/2;
    }
    
}


- (CGFloat)rowWidthWithIndex:(NSInteger)colunmIndex{
    
    if(colunmIndex == 0){
        
        return 70.0f;
    }else if (colunmIndex == 1){
        
        return 30.0f;
    }else if (colunmIndex == 2){
        
        return 30.0f;
    }
    
    return 0;
}

- (UIView *)behindViewWithIndex:(NSInteger)colunmIndex{
    
    if(colunmIndex == 0){
        
        return nil;
    }
    UILabel *label = [UILabel new];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    if(colunmIndex == 1){
        
        label.text = @"时";
    }else if(colunmIndex == 2){
        
        label.text = @"分";
    }
    return label;
}

- (void)cancleDidClick{
    
    
}




- (void)rightClick{
    
    
    //用strong和copy 修饰对NSString操作的时候，都是对原有字符串retain加1，因为没有对NSString对象修改的方法（一般的方法都是返回字符串对象，应该内部使用NSMutableString来操作的，所有的赋值操作都是改变了指针指向）；
    //用strong和copy 修饰对NSMutableString操作的时候,strong对原字符串引用计数加1，copy是生成了新的对象（分配了新的内存），并且是NSString对象，NSMutableString是有修改字符串对象的方法的replaceCharactersInRange，可以测试
    NSMutableString *str = [NSMutableString stringWithFormat:@"123"];
    
    self.name = @"789";
    self.nName = @"456";
    self.name = str;
    self.nName = str;

    NSLog(@"%p=%p=%p",str,self.name,self.nName);
    [str replaceCharactersInRange:NSMakeRange(0, 1) withString:@"0"];
    int count = CFGetRetainCount((__bridge CFTypeRef)(str));
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
