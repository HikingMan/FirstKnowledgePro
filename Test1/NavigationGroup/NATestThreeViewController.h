//
//  NATestThreeViewController.h
//  Test1
//
//  Created by Wang HongLu on 2018/1/15.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^CallBackBlock)(NSString *str);

@interface NATestThreeViewController : UIViewController

@property (nonatomic,copy)CallBackBlock block;

@end
