//
//  NATestThreeViewController.m
//  Test1
//
//  Created by Wang HongLu on 2018/1/15.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "NATestThreeViewController.h"
#import "Masonry.h"
#import "NATestFourViewController.h"


typedef void(^TapBlock)();
@interface My_Cell:UITableViewCell<NSObject>

@property (nonatomic,strong,readwrite)UILabel *testLabel;

@property (nonatomic,copy)TapBlock block;
@end

@implementation My_Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.testLabel = [UILabel new];
        self.testLabel.font = [UIFont systemFontOfSize:16];
        self.testLabel.numberOfLines = 0;
        self.testLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.testLabel];
        
        [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(20);
            make.right.mas_equalTo(-50);
            make.bottom.mas_equalTo(-20);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClicked:)];
        self.testLabel.userInteractionEnabled = YES;
        [self.testLabel addGestureRecognizer:tap];
    }
    return self;
}
- (void)tapClicked:(UITapGestureRecognizer *)tap{
    
    
    if(self.block){
        
        self.block();
    }
}
- (void)dealloc{
    
    NSLog(@"是否循环引用了");
}

@end

@interface NATestThreeViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign)BOOL  isSpread;
@end

@implementation NATestThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Third Page";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    if(self.block){
        
        self.block(@"Start Call Back");
    }
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.estimatedRowHeight = 150;
    tableView.rowHeight = UITableViewAutomaticDimension;
//    tableView.estimatedSectionFooterHeight = 0;
//    tableView.estimatedSectionHeaderHeight = 0;
    
    
    [self.view addSubview:tableView];
    self.tableView = tableView;
    _isSpread = YES;
    
    NSDictionary *dict = @{@"aaa":@"1",@"bbb":@"2",@"ccc":@"3",@"ddd":@"4",@"eee":@"5",@"fff":@"6",@"ggg":@"7"};
    NSArray *array1 = [dict allKeys];
    
    NSArray *array2 = [dict allKeys];
    
    NSArray *array3 = [dict allKeys];
    NSLog(@"%@====%@====%@",array1.description,array2.description,array3.description);
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cellIden";
    
    My_Cell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if(nil == cell){
        
        cell = [[My_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    if(indexPath.row == 0){
        
        if(_isSpread){
            
            cell.testLabel.numberOfLines = 0;
        }else{
            
            cell.testLabel.numberOfLines = 1;
        }
        cell.testLabel.text = @"恒大时间到啦健康减肥啦减肥啦饭卡看见饭卡健身房见上看风景啊剋大风大浪煞风景啊放假啊是咖啡大师福利卡收费的咖啡了地方";
    }else if (indexPath.row == 1){
        
        cell.testLabel.text = @"djaskfalfjafjasdflsjdkfakjfalflasfjasfaklfsafaslfasflafasfalsjfd";
    }else if (indexPath.row == 2){
        
        cell.testLabel.text = @"djdjjdjdjdjjdjjdjdj     djdjjdjd教练大家说的空间都撒漏打卡撒娇大家打开圣诞节啊是肯定司法局浪费jdjdjdjjddjdsllssl迪萨肯德基啊电视剧啊侃大山老大迪萨达商量大佬遂令东山客德桑克蒂斯看电视的德桑克蒂斯山东省来打卡宽度";
    }else{
        
        cell.testLabel.text = @"123456";

        
    }
    __weak typeof(tableView) weakTableView = tableView;
    cell.block = ^{
      
        __strong typeof(weakTableView) strongTableView = weakTableView;
        _isSpread = !_isSpread;
        NSArray *array = [strongTableView visibleCells];
        [strongTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    My_Cell *cell = [self tableView:self.tableView cellForRowAtIndexPath:indexPath];
    cell.testLabel.text = @"what is wrong";
    NSLog(@"%@",cell.testLabel.text);
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NATestFourViewController *fourVC = [[NATestFourViewController alloc]init];
    [self.navigationController pushViewController:fourVC animated:YES];
    
    
}

- (void)test1{
    
    NSLog(@"three test1");
}
+ (void)test2{
    
    NSLog(@"three test2");
}

- (void)test3{
    
    NSLog(@"three test3");
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
