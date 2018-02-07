//
//  CreateQRImage.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/31.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "CreateQRImage.h"
#import <Photos/Photos.h>


@implementation CreateQRImage

+ (UIImage *)getQRImageWithSource:(NSString *)string imageSize:(CGSize)qrSize logo:(UIImage *)logoImage midLogoSize:(CGSize)logoSize{
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setDefaults];
    NSData *sourceData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:sourceData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *resultImage = [qrFilter outputImage];
    
    
    
    return [[self new] dealWithImage:resultImage imageSize:qrSize logo:logoImage midLogoSize:logoSize];
    
}

- (UIImage *)dealWithImage:(CIImage *)sourceImage imageSize:(CGSize)qrSize logo:(UIImage *)logoImage midLogoSize:(CGSize)logoSize{
    
    CGRect extent = CGRectIntegral(sourceImage.extent);
    
    CGFloat scale = MIN(qrSize.width/CGRectGetWidth(extent), qrSize.height/CGRectGetHeight(extent));
    
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CGImageRef bitmapImage = [context createCGImage:sourceImage fromRect:extent];
    
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    UIImage *resultImage = [UIImage imageWithCGImage:scaledImage];
    
    if(logoImage!=nil){
        
        UIGraphicsBeginImageContextWithOptions(resultImage.size, NO, [UIScreen mainScreen].scale);
        [resultImage drawInRect:CGRectMake(0, 0, qrSize.width, qrSize.height)];
        
        [logoImage drawInRect:CGRectMake((qrSize.width-logoSize.width)/2.0, (qrSize.height-logoSize.height)/2.0, logoSize.width, logoSize.height)];
        UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return finalImage;
        
    }
    
    return resultImage;
    
}

+ (UIImage *)screenShotWithScrollView:(UIWebView *)webView
{
    
    //这个方法是可以的，模拟器里面会看起来比较模糊，真机没有问题
    UIScrollView *scrollView = webView.scrollView;
    UIImage* image;

    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, true, [UIScreen mainScreen].scale);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(scrollView.frame.origin.x, scrollView.frame.origin.y, scrollView.contentSize.width, scrollView.contentSize.height);
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
//        [scrollView drawViewHierarchyInRect:scrollView.bounds afterScreenUpdates:YES];
        image = UIGraphicsGetImageFromCurrentImageContext();
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    

    if (image != nil)
    {
        return image;
    }
    return nil;
}
+ (UIImage*)captureView:(WKWebView *)webView{


    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(webView.scrollView.contentSize, true, [UIScreen mainScreen].scale);
    {
        CGPoint savedContentOffset = webView.scrollView.contentOffset;
        CGRect savedFrame = webView.scrollView.frame;
        webView.scrollView.contentOffset = CGPointZero;
        webView.scrollView.frame = CGRectMake(0, 0, webView.scrollView.contentSize.width, webView.scrollView.contentSize.height);
         //这个方法在wkwebview上是不行的，drawViewHierarchyInRect这个方法只是截图屏幕不能截图整个webview里面scroll里面的内容。这个方法就是不对的
        //如果使用webView.scrollView.layer renderInContext: UIGraphicsGetCurrentContext()这样只能截取当前屏幕的内容，因为最终显示加载内容的，是多个WKCompositingView通过重用机制，重用大小是375*512，类似于UITableView。所以即使改变了scroll的frame为contentsize大小，也不会全部加载出来。。
        //Important :
        //renderInContext: UIGraphicsGetCurrentContext()和drawViewHierarchyInRect在wkwebview上的效果是一样的。 在uiwebview上drawViewHierarchyInRect有问题
        //解决方法：将链接用UIWebView重新加载一遍然后截图，可以在后台做。也有一种方法：获取每页的截图，然后做拼接。(没有试过，感觉不太好)。
        for (UIView * subView in webView.subviews) {
            [subView drawViewHierarchyInRect:subView.bounds afterScreenUpdates:YES];
        }
        
//        [webView.scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        image = UIGraphicsGetImageFromCurrentImageContext();
    
        webView.scrollView.contentOffset = savedContentOffset;
        webView.scrollView.frame= savedFrame;
    }
    UIGraphicsEndImageContext();
    if (image != nil) {
        return image;
    }
    return nil;
    
}

@end
