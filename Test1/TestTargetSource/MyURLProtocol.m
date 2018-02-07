//
//  MyURLProtocol.m
//  Test1
//
//  Created by Wang HongLu on 2017/11/27.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "MyURLProtocol.h"

static NSString* const  FilterKey = @"FilterKey";


@interface MyURLProtocol()<NSURLSessionDataDelegate>

@property (nonatomic,strong)NSURLSession *session;

@end
@implementation MyURLProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    NSString *scheme = request.URL.scheme;
//    这个方法主要是说明你是否打算处理对应的request，如果不打算处理，返回NO，URL Loading System会使用系统默认的行为去处理；如果打算处理，返回YES，然后你就需要处理该请求的所有东西，包括获取请求数据并返回给 URL Loading System。网络数据可以简单的通过NSURLConnection去获取，而且每个NSURLProtocol对象都有一个NSURLProtocolClient实例，可以通过该client将获取到的数据返回给URL Loading System。
//    这里有个需要注意的地方，想象一下，当你去加载一个URL资源的时候，URL Loading System会询问CustomURLProtocol是否能处理该请求，你返回YES，然后URL Loading System会创建一个CustomURLProtocol实例然后调用NSURLConnection去获取数据，然而这也会调用URL Loading System，而你在+canInitWithRequest:中又总是返回YES，这样URL Loading System又会创建一个CustomURLProtocol实例导致无限循环。我们应该保证每个request只被处理一次，可以通过+setProperty:forKey:inRequest:标示那些已经处理过的request，然后在+canInitWithRequest:中查询该request是否已经处理过了，如果是则返回NO。
    
    if(([scheme caseInsensitiveCompare:@"huluxianren"] == NSOrderedSame) && ([NSURLProtocol propertyForKey:FilterKey inRequest:request] == nil)){
        
        return YES;
    }
    return NO;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    
    //这里可以修改request, 添加header，修改host等，也可以重新生成一个request；
    NSMutableURLRequest *resutlRequest = [request mutableCopy];
    
    NSString *originUrlStr = [request.URL absoluteString];
    NSString *originHostStr = [request.URL scheme];
    [resutlRequest setTimeoutInterval:60];
    if([originUrlStr rangeOfString:originHostStr].location == NSNotFound){
     
        
    }else{
        
        NSString *scheme = @"https";
        NSString *resultURLStr = [originUrlStr stringByReplacingOccurrencesOfString:originHostStr withString:scheme];
        resutlRequest.URL = [NSURL URLWithString:resultURLStr];
    }
    return resutlRequest;
    
}

//主要判断两个request是否相同，如果相同的话可以使用缓存数据，通常只需要调用父类的实现。
+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b{
    
    return [super requestIsCacheEquivalent:a toRequest:b];
}

#pragma mark - NSURLSessionDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    
    [self.client URLProtocol:self didLoadData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    if(error==nil){
        [self.client URLProtocolDidFinishLoading:self];
    }else{
        [self.client URLProtocol:self didFailWithError:error];
    }
}

- (void)startLoading{
    
    NSMutableURLRequest *resultRequest = [self.request mutableCopy];
    //标示改request已经处理过了，防止无限循环
    [NSURLProtocol setProperty:@YES forKey:FilterKey inRequest:resultRequest];
    
    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue currentQueue]];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:resultRequest];
    [task resume];
}

- (void)stopLoading{
    
    
    
    
}

@end
