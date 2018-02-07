//
//  TryFirstModel.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/25.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TryFirstModel : NSObject

@property (nonatomic,strong)NSString *headPicUrl;

@property (nonatomic,strong)NSString *detailInfo;

@property (nonatomic,assign)BOOL isOperated;


+(void)getSourceDataWithCompleteHandle:(void(^)(NSArray *resultArray, BOOL isSuccess, NSError *error)) block;

+(void)changeOperationState:(TryFirstModel *)model CompleteHandle:(void(^)(TryFirstModel *model, BOOL isSuccess, NSError *error)) block;

+(CGFloat)getCellHeightWithInfo:(TryFirstModel *)model;
@end
