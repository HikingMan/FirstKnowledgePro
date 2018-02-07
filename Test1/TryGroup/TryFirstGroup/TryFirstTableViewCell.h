//
//  TryFirstTableViewCell.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/25.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TryFirstModel.h"

typedef void(^OperaBlock)(id sender);

@interface TryFirstTableViewCell : UITableViewCell


@property (nonatomic,strong)OperaBlock block;

- (void) reloadCellWithSource:(TryFirstModel *)sourceModel;
@end
