//
//  StartEndInputView.h
//  Test1
//
//  Created by Wang HongLu on 2017/11/28.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class StartEndInputTextField;


typedef void(^GoInputClickBlock)(StartEndInputTextField *);
typedef void(^StartSearchBlock)(void);



@interface StartEndInputViewFinal : UIView

@property (nonatomic,strong)StartEndInputTextField *startField;

@property (nonatomic,strong)StartEndInputTextField *endField;


@property (nonatomic,copy)GoInputClickBlock inputBlock;
@property (nonatomic,copy)StartSearchBlock searchBlock;

//当手动的改变UITextField.text的时候，并不会出发UITextField的UITextFieldTextDidChange的方法，所以暴露出这个方法。
- (void)textChanged:(UITextField *)field;

@end

@interface StartEndInputTextField:UITextField

@property (nonatomic,strong)CLLocation* location;

@end


