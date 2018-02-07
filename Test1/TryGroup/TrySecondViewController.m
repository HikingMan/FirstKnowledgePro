//
//  TrySecondViewController.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/25.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TrySecondViewController.h"

#import "NetWorkManager.h"

#import "HelpAnaly.h"

#import "TrySecondModelProtocol.h"
#import "TrySecondProtocol.h"

@interface TrySecondViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *trySecondTableView;

@property (nonatomic,strong)NSMutableArray *sourceArray;

@end

@implementation TrySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"MVP";
    
    
    //看看这MVP干了点啥！！！没啥用！！！
    //相较于之前的MVC，因为这里出现了多种cell，这些都需要在tableview里面做判断的，然后MVP把她们的一些特点提取出来（需要根据数据源家刷新cell等）生成protocol，她们的数据源的相同操作也踢去出来生成modelprotocol，这里的presenter就是当前的控制器，然后形成了protocol--->>>presenter<<<<----modelprotocol。这样减少了控制器的代码量，但是很有限。
    //现在的app虽然逐渐复杂，但是还没有复杂到一个页面有n多种类似的控件和n多种不同的操作。这样的设计要么直接用js的形式（用weex，rn去写或者用webview），要么就打死产品吧。。
    //自我得出的结论（仅供参考）:MVP只能适于某种特定场景（还没找到）吧，感觉还是分工好MVC，就很舒服了。
    [[NetWorkManager shareManager] getDataWithUrl:@"http://www.qq.com/" parameters:@{} result:^(id result) {
        
        if(nil!=result){
            
            //这里做数据解析，即填充数据源,这里可以交给其他工具类来做，就可以不引用各个model头文件了。
            self.sourceArray = [[HelpAnaly getMadeInMineSource] mutableCopy];
            
            [self.trySecondTableView reloadData];
            
        }
        
    }];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id <TrySecondModelProtocol> model = [self.sourceArray objectAtIndex:indexPath.row];
    
    UITableViewCell<TrySecondProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:[model relateCellIdentify]];
    
    [cell reloadCellWithSource:model];
    
    cell.block = ^(id sender){
        [model changeStateWithSource:model completeHandl:^(id<TrySecondModelProtocol> result, BOOL issuccess) {
            
            if(issuccess){
                
                [self.sourceArray replaceObjectAtIndex:indexPath.row withObject:result];
                [self.trySecondTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }];
    };
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id <TrySecondModelProtocol> model = [self.sourceArray objectAtIndex:indexPath.row];
    
    return [model getRowHeightWith:model];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArray.count;
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
