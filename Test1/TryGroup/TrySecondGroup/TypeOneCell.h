//
//  TypeOneCell.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrySecondProtocol.h"

@interface TypeOneCell : UITableViewCell<TrySecondProtocol>
@property (weak, nonatomic) IBOutlet UIButton *opOneBut;
@property (weak, nonatomic) IBOutlet UILabel *opOneLabel;

@property (nonatomic,strong)ButtonClick block;
@end
