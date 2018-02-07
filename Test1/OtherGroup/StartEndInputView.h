//
//  StartEndInputView.h
//  Test1
//
//  Created by Wang HongLu on 2017/11/28.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol goInputDelegate<NSObject>

- (void)goInputWithClickField:(UITextField *)textField;

@end
@interface StartEndInputView : UIView

@property (nonatomic,weak)id<goInputDelegate> delegate;

@property (nonatomic,readonly,strong)UITextField *startField;

@property (nonatomic,readonly,strong)UITextField *endField;

@end
