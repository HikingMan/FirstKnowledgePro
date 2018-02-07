//
//  TypeThreeModel.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrySecondModelProtocol.h"

@interface TypeThreeModel : NSObject<TrySecondModelProtocol>


@property (nonatomic,strong)NSString *name;

@property (nonatomic,strong)NSString *showText;

@property (nonatomic,assign)BOOL threeIsTap;
@end
