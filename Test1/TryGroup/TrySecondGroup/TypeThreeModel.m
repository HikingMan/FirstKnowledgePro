//
//  TypeThreeModel.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TypeThreeModel.h"

@implementation TypeThreeModel

-(NSString *)relateCellIdentify{
    
    return @"TypeThree";
    
}
-(CGFloat)getLableHeightWith:(id<TrySecondModelProtocol>)model{
    CGSize size = [[model showText] boundingRectWithSize:CGSizeMake(180, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}  context:nil].size;
    return size.height>=20?size.height:20;
}
-(CGFloat)getRowHeightWith:(id<TrySecondModelProtocol>)model{
    
    return 20+[self getLableHeightWith:model]+20;
}

-(void)changeStateWithSource:(id<TrySecondModelProtocol>)model completeHandl:(void (^)(id<TrySecondModelProtocol>, BOOL))block{
    //这里对应的model做对应的网络处理，有可能是不同的接口
    TypeThreeModel *threeModel = model;
    threeModel.threeIsTap = !threeModel.threeIsTap;
    block(threeModel,YES);
}

@end
