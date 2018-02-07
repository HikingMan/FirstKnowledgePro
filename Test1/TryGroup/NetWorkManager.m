//
//  NetWorkManager.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/25.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "NetWorkManager.h"

@interface NetWorkManager()

@property (nonatomic,strong)NSURLSession *session;
@end


static NetWorkManager * netWorkInstance;
@implementation NetWorkManager

+(NetWorkManager *)shareManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if(nil==netWorkInstance){
            
            netWorkInstance = [[NetWorkManager alloc]init];
            netWorkInstance.session=[NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        }
    });
    return netWorkInstance;
}

-(void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)params result:(ResultBlock)result{
    
    if(nil!=params && params.allKeys.count!=0){
        
        //这里做参数的拼接
    }
    
    NSURL *requestUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:requestUrl];
    
    
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(data!=nil){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                result(data);
            });
            
        }
    }];
    [task resume];
    
    
}

@end
