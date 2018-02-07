//
//  TypeTwoCell.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrySecondProtocol.h"

@interface TypeTwoCell : UITableViewCell<TrySecondProtocol>
@property (weak, nonatomic) IBOutlet UIButton *opTwoBut;
@property (weak, nonatomic) IBOutlet UILabel *opTwoLabel;

@property (nonatomic,strong)ButtonClick block;
@end
