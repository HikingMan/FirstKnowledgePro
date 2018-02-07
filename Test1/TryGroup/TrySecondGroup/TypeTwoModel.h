//
//  TypeTwoModel.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrySecondModelProtocol.h"

@interface TypeTwoModel : NSObject<TrySecondModelProtocol>


@property (nonatomic,assign)NSInteger count;

@property (nonatomic,strong)NSString *showText;

@property (nonatomic,assign)BOOL twoIsTap;
@end
