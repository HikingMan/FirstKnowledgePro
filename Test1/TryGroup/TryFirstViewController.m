//
//  TryFirstViewController.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/25.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TryFirstViewController.h"
#import "TryFirstTableViewCell.h"
#import "TryFirstModel.h"

@interface TryFirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

@property (nonatomic,strong)NSMutableArray *sourceArray;

@end

@implementation TryFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=NO;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backClicked)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"下一级" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage)];
    
    self.title=@"MVC";
    _myTableView.tableFooterView=[UIView new];
    [TryFirstModel getSourceDataWithCompleteHandle:^(NSArray * resultArray ,BOOL isSuccess, NSError *error){
        if(isSuccess){
            self.sourceArray=[resultArray mutableCopy];
                [_myTableView reloadData];
        }
    }];
    
    // Do any additional setup after loading the view.
}
- (IBAction)testUpTableView:(id)sender {
    
    
    NSLog(@"what is wrong");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TryFirstTableViewCell *cell = (TryFirstTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TryFirstCell"];
    
    [cell reloadCellWithSource:[self.sourceArray objectAtIndex:indexPath.row]];
    cell.block = ^(id sender){
        
        [TryFirstModel changeOperationState:[self.sourceArray objectAtIndex:indexPath.row] CompleteHandle:^(TryFirstModel * model, BOOL success, NSError *error){
            
            [self.sourceArray replaceObjectAtIndex:indexPath.row withObject:model];
            [self.myTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
    };
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return [TryFirstModel getCellHeightWithInfo:[self.sourceArray objectAtIndex:indexPath.row]]+70;
}
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.sourceArray.count;
}


#pragma mark - private

-(void)backClicked{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)nextPage{
    
    [self performSegueWithIdentifier:@"FirstToSecond" sender:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    NSLog(@"====%@",segue);
    
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
