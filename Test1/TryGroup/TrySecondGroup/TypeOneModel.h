//
//  TypeOneModel.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrySecondModelProtocol.h"

@interface TypeOneModel : NSObject<TrySecondModelProtocol>

//这里的属性一样不一样都无所谓了，反正使用的时候都会变成真正的当前model对象。
//这里的protocol可以换成继承的（我觉得是没有问题的），但是protocol是横向的对立关系，继承是自上而下的关系。protocol更加方便扩展吧。
@property (nonatomic,strong)NSString *identify;

@property (nonatomic,strong)NSString *showText;

@property (nonatomic,assign)BOOL oneIsTap;
@end
