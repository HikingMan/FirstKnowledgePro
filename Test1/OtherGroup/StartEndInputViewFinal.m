//
//  StartEndInputView.m
//  Test1
//
//  Created by Wang HongLu on 2017/11/28.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "StartEndInputViewFinal.h"
#import "Masonry.h"

#define CPColor(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];


@implementation StartEndInputTextField

- (CGRect)textRectForBounds:(CGRect)bounds{
    
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.x+=10;
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    CGRect rect = [super editingRectForBounds:bounds];
    rect.origin.x+=10;
    rect.size.width-=10;
    return rect;
    
}

@end

@interface StartEndInputViewFinal()<UITextFieldDelegate>

@property (nonatomic,strong)UIButton *exchangeButton;

@property (nonatomic,strong)UIView *lineView;

@property (nonatomic,strong)UIButton *startSearchButton;

@end
@implementation StartEndInputViewFinal

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self initSubViews];
        
    }
    return self;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self initSubViews];
    
}

- (void)initSubViews{
    
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    
    _startField = [[StartEndInputTextField alloc]init];
    _startField.placeholder = @"请输入起点";
    _startField.text = @"当前位置";
    _startField.leftViewMode = UITextFieldViewModeAlways;
    _startField.font = [UIFont systemFontOfSize:15];
    _startField.delegate = self;
//    _startField.borderStyle = UITextBorderStyleLine;
    
    UIView *startIconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
    startIconView.backgroundColor = CPColor(151, 231, 112);
    startIconView.layer.cornerRadius = 4;
    startIconView.layer.masksToBounds = YES;
    _startField.leftView = startIconView;
    
    
//    [_startField addTarget:self action:@selector(goInputWithClickField:) forControlEvents:UIControlEventTouchDown];
    [_startField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:_startField];
    
    

    _endField = [[StartEndInputTextField alloc]init];
    _endField.placeholder = @"请输入终点";
    _endField.delegate = self;
//    _endField.text = @"终点位置";
    _endField.leftViewMode =UITextFieldViewModeAlways;
//    _endField.borderStyle = UITextBorderStyleLine;
    _endField.font = [UIFont systemFontOfSize:15];
    [_endField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
    UIView *endIconView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 8)];
    endIconView.backgroundColor = CPColor(241, 140, 140);
    endIconView.layer.cornerRadius = 4;
    endIconView.layer.masksToBounds = YES;
    _endField.leftView = endIconView;
//    [_endField addTarget:self action:@selector(goInputWithClickField:) forControlEvents:UIControlEventTouchDown];
    [self addSubview:_endField];
    
    _exchangeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_exchangeButton setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
    [_exchangeButton addTarget:self action:@selector(exchangeClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_exchangeButton];
    
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = CPColor(216, 216, 216);
    [self addSubview:_lineView];
    
    
    _startSearchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startSearchButton setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [_startSearchButton addTarget:self action:@selector(startSearch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_startSearchButton];
    _startSearchButton.enabled = NO;
    
    [_startSearchButton setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    
    
    [_exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(18);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        
    }];
    
    [_startField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_exchangeButton.mas_right).offset(21);
        make.top.mas_equalTo(13);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(-51);
    }];
    
    [_endField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_startField.mas_left);
        make.width.equalTo(_startField.mas_width);
        make.height.equalTo(_startField.mas_height);
        make.bottom.mas_equalTo(-13);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_startField.mas_left);
        make.right.mas_equalTo(-51);
        make.height.mas_equalTo(0.5);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [_startSearchButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
        make.centerY.equalTo(_exchangeButton.mas_centerY);
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
        
        _startField.leftView.backgroundColor = CPColor(151, 231, 112);
        _startField.placeholder = @"请输入起点";
        _endField.leftView.backgroundColor = CPColor(241, 140, 140);
        _endField.placeholder = @"请输入终点";
        
        
    }];
    
}

- (void)goInputWithClickField:(UITextField *)field{
    

}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    if(self.inputBlock){
        self.inputBlock(textField);
    }
}
- (void)startSearch{
    
    if(self.searchBlock){
        
        self.searchBlock();
    }
}

- (void)textChanged:(UITextField *)field{
    
    if([_startField.text isEqualToString:@"当前位置"] && [_endField.text isEqualToString:@"当前位置"]){
        
        if(field == _startField){
            
            _endField.text = @"";
        }else if (field == _endField){
            
            _startField.text = @"";
        }
    }
    
    if(_startField.text.length>0 && _endField.text.length>0){
        
        _startSearchButton.enabled = YES;
    }else{
        
        _startSearchButton.enabled = NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
