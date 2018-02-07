//
//  StartEndInputView.m
//  Test1
//
//  Created by Wang HongLu on 2017/11/28.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "StartEndInputView.h"
#import "Masonry.h"

@interface StartEndInputView()<UITextFieldDelegate>

@property (nonatomic,strong,readwrite)UITextField *startField;

@property (nonatomic,strong,readwrite)UITextField *endField;

@property (nonatomic,strong)UIButton *exchangeButton;

@end
@implementation StartEndInputView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self initSubViews];
        
    }
    return self;
}

- (void)initSubViews{
    
    _startField = [[UITextField alloc]init];
    _startField.placeholder = @"请输入起点";
    _startField.text = @"我的位置";
    _startField.leftViewMode = UITextFieldViewModeAlways;
    _startField.borderStyle = UITextBorderStyleLine;
    
    UIView *startIconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
    startIconView.backgroundColor = [UIColor redColor];
    startIconView.layer.cornerRadius = 4;
    startIconView.layer.masksToBounds = YES;
    _startField.leftView = startIconView;
    
    
    [_startField addTarget:self.delegate action:@selector(goInputWithClickField:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_startField];
    
    

    _endField = [[UITextField alloc]init];
    _endField.placeholder = @"请输入终点";
    _endField.text = @"终点位置";
    _endField.leftViewMode =UITextFieldViewModeAlways;
    _endField.borderStyle = UITextBorderStyleLine;
    
    UIView *endIconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
    endIconView.backgroundColor = [UIColor cyanColor];
    endIconView.layer.cornerRadius = 4;
    endIconView.layer.masksToBounds = YES;
    _endField.leftView = endIconView;
    [_endField addTarget:self.delegate action:@selector(goInputWithClickField:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_endField];
    
    _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exchangeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_exchangeButton setBackgroundColor:[UIColor yellowColor]];
    [_exchangeButton addTarget:self action:@selector(exchangeClicked) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_exchangeButton];
    
    
    [_exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(30);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        
    }];
    
    [_startField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_exchangeButton.mas_right).offset(30);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-30);
    }];
    
    [_endField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_startField.mas_left);
        make.width.equalTo(_startField.mas_width);
        make.height.equalTo(_startField.mas_height);
        make.bottom.mas_equalTo(-10);
    }];
    
}

- (void)exchangeClicked{
    CGRect startRect = _startField.frame;
    CGRect endRect = _endField.frame;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _startField.frame = endRect;
        _endField.frame = startRect;
        
    } completion:^(BOOL finished) {
        
        UITextField * tempTextfield = _startField;
        _startField =_endField;
        _endField = tempTextfield;
        
        _startField.leftView.backgroundColor = [UIColor redColor];
        _startField.placeholder = @"请输入起点";
        _endField.leftView.backgroundColor = [UIColor cyanColor];
        _endField.placeholder = @"请输入终点";
        
    }];
    
    
   
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
