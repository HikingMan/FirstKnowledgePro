//
//  TestSouceOneViewController.h
//  Test1
//
//  Created by Wang HongLu on 2017/11/27.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^InputResultBlock)(NSString *);
@interface TestSouceOneViewController : UIViewController

@property (nonatomic,copy)InputResultBlock block;

- (UIViewController *)testForTest;
@end
