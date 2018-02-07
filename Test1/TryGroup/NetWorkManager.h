//
//  NetWorkManager.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/25.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResultBlock)(id result);
@interface NetWorkManager : NSObject


+(NetWorkManager *)shareManager;

-(void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)params result:(ResultBlock)result;

@end
