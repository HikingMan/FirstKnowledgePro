//
//  TestSnapWebview.m
//  Test1
//
//  Created by Wang HongLu on 2017/11/21.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TestSnapWebview.h"
#import <WebKit/WebKit.h>
#import "CreateQRImage.h"
#import <Photos/Photos.h>

@interface TestSnapWebview()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate>
{
    
    CGFloat _realHeight;
}
@property (nonatomic,strong)UIWebView *webView;

@property (nonatomic,strong)WKWebView *wkWebview;

@property (nonatomic,strong)UIImageView *loadImageView;

@property (nonatomic,strong)NSArray *urlArray;

@property (nonatomic,strong)NSMutableArray *imageArray;
@end

@implementation TestSnapWebview


- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self creatSubViews];
        
        _urlArray = @[@"http://www.jianshu.com/",@"https://www.baidu.com/"];
        
        _imageArray = [NSMutableArray new];
    }
    return self;
}

- (void)creatSubViews{
    
    _loadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.frame.size.width, self.frame.size.height)];
    _loadImageView.backgroundColor = [UIColor redColor];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [_loadImageView addGestureRecognizer:tap];
    _loadImageView.userInteractionEnabled = YES;
    [self addSubview:_loadImageView];
    
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"https://m.treevc.net/assets/html/train/driverService.html"]];
    
    _webView = [[UIWebView alloc]initWithFrame:_loadImageView.frame];
    [_webView loadRequest:request];
    _webView.delegate = self;
    [self addSubview:_webView];
    
    _wkWebview = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) configuration:[[WKWebViewConfiguration alloc]init]];
    _wkWebview.backgroundColor = [UIColor cyanColor];
    [_wkWebview loadRequest:request];
    _wkWebview.navigationDelegate = self;
    
    [self addSubview:_wkWebview];
    
    [self.wkWebview.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                                                                                                                 context:nil];
    
    
    NSArray *array = @[@"UIWebview",@"WKWebview"];
    for(int i=0;i<array.count;i++){
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(10+120*i, 20, 100, 40)];
        [button setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        button.tag =100+i;
        [self addSubview:button];
        
    }
    
   
    
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"contentOffset"]){
        
        CGPoint oldP = [[change objectForKey:@"old"] CGPointValue];
        CGPoint newP = [[change objectForKey:@"new"] CGPointValue];
        
        
        if(_imageArray.count==0){
            return;
        }
        UIImage* image = nil;
        UIView *superView = _wkWebview;
        //这里通过遍历获取最上层显示的WKCompositingView的数组
        while (superView && superView.subviews.count>0) {
            superView = [[superView subviews] firstObject];
        }
        if([NSStringFromClass([superView class]) isEqualToString:@"WKCompositingView"]){

            NSArray *array = [[superView superview] subviews];
            for(UIView *positionView in array){

                NSInteger index = (int)positionView.frame.origin.y/512+((int)positionView.frame.origin.y%512?1:0);
                NSLog(@"****%ld****",index);
                if([[_imageArray objectAtIndex:index] isKindOfClass:[UIImage class]]){
                    continue;
                }
                @autoreleasepool{
                    //UIGraphicsBeginImageContextWithOptions这个方法真的耗内存啊，这里使用之后直接到达50+M，使用UIGraphicsBeginImageContext只有20M
//                    UIGraphicsBeginImageContextWithOptions(webView.scrollView.contentSize, true, [UIScreen mainScreen].scale);
                    UIGraphicsBeginImageContext(positionView.bounds.size);
                    NSLog(@"%@",NSStringFromCGRect(positionView.frame));
                    
                    [positionView drawViewHierarchyInRect:positionView.bounds afterScreenUpdates:YES];
                    image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    if(image !=nil){
                        
                        [_imageArray replaceObjectAtIndex:index withObject:image];
                    }
                    
                }
            }
        }
    }
    
}
- (void)combineImage{
//    根据已经得到的图片合成最终的图片
    CGFloat width = _wkWebview.bounds.size.width;
    CGFloat height = _imageArray.count*512;
    CGSize offScreenSize = CGSizeMake(width, height);
    
    UIGraphicsBeginImageContext(offScreenSize);
    for(int i=0; i<_imageArray.count; i++){
        
        UIImage *image = [_imageArray objectAtIndex:i];
        CGRect rect = CGRectMake(0, i*512, width, 512);
        if([image isKindOfClass:[UIImage class]]){
            [image drawInRect:rect];
        }
    }
    UIImage* resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    [_imageArray removeAllObjects];
//    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
//        PHAssetChangeRequest *reqest = [PHAssetChangeRequest creationRequestForAssetFromImage:resultImage];
//    } completionHandler:^(BOOL success, NSError * _Nullable error) {
//
//        NSLog(@"hahaha");
//    }];
    
}
- (void)click:(UIButton *)sender{
    
    
    if(sender.tag==100){
        
        [self bringSubviewToFront:_webView];
        
        UIImage *image = [CreateQRImage screenShotWithScrollView:_webView];
        
        [_loadImageView setImage:image];
        [self bringSubviewToFront:_loadImageView];
        
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *reqest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            NSLog(@"%@",reqest.creationDate);
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            NSLog(@"hahaha");
        }];
        
    }else{
        
        [self bringSubviewToFront:_wkWebview];
        
        UIImage *image = [CreateQRImage captureView:_wkWebview];
        
        [_loadImageView setImage:image];
        [self bringSubviewToFront:_loadImageView];
        
        
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetChangeRequest *reqest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
            NSLog(@"%@",reqest.creationDate);
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            
            NSLog(@"hahaha");
        }];
        //这种方法需要注册观察者，滚动时，将显示的WKCompositingView生成image。（所以，滚动结束后，只能得到当前显示页面以及之后（大概是5个，这个数值也可以和重用策略有关）的几张图片，只有滚动到底部的时候才能保证获取到整个webview的图片）。然后通过图片合成获取整个图片。
//        [self combineImage];
    }
    
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"uiwebview load finishi");

    _realHeight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
    
    
    
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    decisionHandler(WKNavigationActionPolicyAllow);
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    
    NSLog(@"wkwebview load finishi");
    
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        
        _realHeight = [result floatValue];
        NSInteger count = (int)_realHeight/512+((int)_realHeight%512?1:0);
        for(int i=0;i<count;i++){
            
            [_imageArray addObject:[NSNumber numberWithInt:i]];
        }
    }];
}

- (void)startCollectImage{
    
   
    
    NSInteger count = (int)_realHeight/512+((int)_realHeight%512?1:0);
    for(int i=0;i<count;i++){
        
        [_imageArray addObject:[NSNumber numberWithInt:i]];
    }
    NSLog(@"%@",NSStringFromCGSize(_wkWebview.scrollView.contentSize));
}

- (void)tapClick:(UITapGestureRecognizer *)tap{
    
    [self insertSubview:_loadImageView atIndex:0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
