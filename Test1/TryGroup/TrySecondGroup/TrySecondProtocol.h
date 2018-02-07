//
//  TrySecondProtocol.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrySecondModelProtocol.h"

typedef void(^ButtonClick)(id sender);
@protocol TrySecondProtocol <NSObject>

@property (nonatomic,strong)ButtonClick block;

-(void)reloadCellWithSource:(id<TrySecondModelProtocol>)sourceModel;


@end
