//
//  CreateQRImage.h
//  Test1
//
//  Created by Wang HongLu on 2017/10/31.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface CreateQRImage : NSObject

+ (UIImage *)getQRImageWithSource:(NSString *)string imageSize:(CGSize)qrSize logo:(UIImage *)logoImage midLogoSize:(CGSize)logoSize;
+ (UIImage *)screenShotWithScrollView:(UIWebView *)webView;
+ (UIImage*)captureView:(WKWebView *)webView;

@end
