//
//  TestSouceOneViewController.m
//  Test1
//
//  Created by Wang HongLu on 2017/11/27.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TestSouceOneViewController.h"
#import <WebKit/WebKit.h>
#import "NSURLProtocol+WKPro.h"

@interface TestSouceOneViewController ()<WKNavigationDelegate>

@property (nonatomic,strong)WKWebView *testWebView;
@end

@implementation TestSouceOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NSURLProtocol wk_registerScheme:@"huluxianren"];
    
    [self loadWebView];
    
    
//    if(self.block){
//
//        self.block(@"输入了起点");
//
//    }
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIViewController *)testForTest{
    NSLog(@"hahahha");
    return self;
}

- (void)loadWebView{
    
    NSString *urlStr = @"http://client.treevc.net/assets/html/office/notice.html";
    
    urlStr = @"huluxianren://www.baidu.com/";
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    
    _testWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) configuration:[WKWebViewConfiguration new]];
    _testWebView.navigationDelegate = self;
    
    [_testWebView loadRequest:request];
    [self.view addSubview:_testWebView];
}


#pragma mark - WKNavigationDelgate

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    
    NSLog(@"url == %@",webView.URL.absoluteString);
    
    [webView reload];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    
    
    NSLog(@"finishi===%@",webView.title);
}
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"error---%@",error.localizedDescription);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    
    NSLog(@"yanzheng---%@",navigationAction);
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {

        NSURLCredential *credential = [[NSURLCredential alloc]initWithTrust:challenge.protectionSpace.serverTrust];

        completionHandler(NSURLSessionAuthChallengeUseCredential,credential);

    }
    
    
}



- (void)dealloc{
    
//    [NSURLProtocol wk_unregisterScheme:@"huluxianren"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
