//
//  HL_PickerView.m
//  Test1
//
//  Created by Wang HongLu on 2018/3/6.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import "HL_PickerView.h"
#import "Masonry.h"

@interface HL_PickerView()<UIScrollViewDelegate>

{
    UIView *_coverView;
}

@property (nonatomic,strong)UIButton *cancleButton;

@property (nonatomic,strong)UIButton *confirmButton;

@property (nonatomic,strong)UILabel *titleLable;

@property (nonatomic,strong)UIView *middleSelectView;

@property (nonatomic,strong)UIButton *bottomButton;


@property (nonatomic,strong)NSString *lastSelectKey;

@property (nonatomic,strong,readwrite)NSMutableArray *resultArray;
@end

@implementation HL_PickerView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        
        [self initailSubViews];
    }
    self.backgroundColor = [UIColor whiteColor];
    self.hidden = YES;
    self.resultArray = [NSMutableArray new];
    return self;
}

- (void)initailSubViews{
    
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_cancleButton addTarget:self action:@selector(cancleClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancleButton];
    
    _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_confirmButton addTarget:self action:@selector(confirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_confirmButton];
    
    _titleLable = [UILabel new];
    _titleLable.font = [UIFont systemFontOfSize:18];
    _titleLable.text =@"哈哈哈哈哈哈";
    _titleLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLable];
    
    _bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_bottomButton setTitle:@"接受15分钟浮动，快速呈现" forState:UIControlStateNormal];
    _bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_bottomButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_bottomButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [_bottomButton addTarget:self action:@selector(bottomClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bottomButton];
    
    _middleSelectView = [UIView new];
    _middleSelectView.layer.borderColor = [UIColor greenColor].CGColor;
    _middleSelectView.layer.borderWidth = 1;
    _middleSelectView.layer.cornerRadius = 4;
    _middleSelectView.layer.masksToBounds = YES;
    [self addSubview:_middleSelectView];
    
    
    [_cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(_titleLable.mas_centerY);
    }];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(24);
        make.left.equalTo(_cancleButton.mas_right).offset(20);
        
        make.right.equalTo(_confirmButton.mas_left).offset(-20);
    }];
    
    [_confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
        make.centerY.equalTo(_titleLable.mas_centerY);
    }];
    
    [_middleSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self.mas_centerY);
//        make.top.mas_equalTo(81.5);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    [_bottomButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
//        make.width.mas_equalTo(192.5);
        make.height.mas_equalTo(16);
        make.bottom.mas_equalTo(-20);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    
    _coverView.backgroundColor=[UIColor colorWithRed:40/255.0f green:40/255.0f blue:40/255.0f alpha:0.4];
    [self.superview addSubview:_coverView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(coverViewClick:)];
    [_coverView addGestureRecognizer:tap];
    
    
}
- (void)reloadSubColunmWithLastScrollView:(UIScrollView *)lasScrollView{
    
    UIScrollView *scrollView = [self viewWithTag:lasScrollView.tag+1];
    if(nil == scrollView){
        
        return;
    }

    NSArray *sourceArray = [self.delegate pickerView:self rowSourceWithIndex:scrollView.tag-100 lastSelectRowKey:self.lastSelectKey];
    
    for(UIView *subView in scrollView.subviews){
        
        [subView removeFromSuperview];
    }
    
    [self loadRowViewWithScourceArray:sourceArray WithSuperScroll:scrollView];
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    
}
- (void)drawRect:(CGRect)rect{
    
    [UIView animateWithDuration:0.2 animations:^{
        [_coverView setFrame:CGRectMake(self.superview.frame.origin.x, self.superview.frame.origin.y-64, self.superview.frame.size.width, self.superview.frame.size.height-rect.size.height+64)];
        self.frame=CGRectMake(self.frame.origin.x, self.bounds.size.height-210, self.frame.size.width, 210);
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    [self show];
}

- (void)show{
    
    
    NSInteger colunmNum = [self.delegate pickerColunmNum];
    for(int i=0; i<colunmNum; i++){
        
        [self.resultArray addObject:@{}];
    }
    
    CGFloat leftMargin = 0.0f;
    
    __block UIView *lastView = nil;
    for(int i=0; i<colunmNum ;i++){
        
        leftMargin = [self.delegate spaceWidthWithIndex:i];
        UIScrollView *rowScroll = [UIScrollView new];
        rowScroll.delegate = self;
        rowScroll.tag = 100+i;
        rowScroll.showsVerticalScrollIndicator = NO;
        rowScroll.showsHorizontalScrollIndicator = NO;
        [self addSubview:rowScroll];
        
        
        NSArray *rowSource = [self.delegate pickerView:self rowSourceWithIndex:i lastSelectRowKey:_lastSelectKey];
        
        
        
        [rowScroll mas_makeConstraints:^(MASConstraintMaker *make) {
           
            if(lastView){
                
                make.left.equalTo(lastView.mas_right).offset(leftMargin);
            }else{
                
                make.left.mas_equalTo(leftMargin);
            }
            
            
            make.centerY.equalTo(_middleSelectView.mas_centerY);
            make.height.mas_equalTo(100);
            make.width.mas_equalTo([self.delegate rowWidthWithIndex:i]);
        }];
        lastView = rowScroll;
        
        UIView *behindView = [self.delegate behindViewWithIndex:i];
        [self addSubview:behindView];
        
        [behindView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(rowScroll.mas_right);
            make.centerY.equalTo(rowScroll.mas_centerY);
        }];
        
        [self loadRowViewWithScourceArray:rowSource WithSuperScroll:rowScroll];
        
        
    }
    
    
    
    self.hidden = NO;
}

- (void)loadRowViewWithScourceArray:(NSArray *)rowSource WithSuperScroll:(UIScrollView *)rowScroll{
    
    UIView *containerView = [UIView new];
    [rowScroll addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(rowScroll);
        make.width.equalTo(rowScroll.mas_width);
    }];
    
    for(int j=0; j<rowSource.count; j++){
        
        UILabel *label = [UILabel new];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor redColor];
        label.text = [rowSource objectAtIndex:j];
        label.textAlignment = NSTextAlignmentCenter;
        [containerView addSubview:label];
        label.tag = 200+j;
        
        if(j == 0){
            
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
            self.lastSelectKey = label.text;
            if(self.lastSelectKey){
                
                [self.resultArray replaceObjectAtIndex:rowScroll.tag-100 withObject:@{@(j):self.lastSelectKey}];
            }
        }
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo((j+1)*(20+20));
            make.height.mas_equalTo(20);
        }];
        if(j == rowSource.count-1){
            
            [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(label.mas_bottom).offset(40);
            }];
        }
    }
}

#pragma mark - ScrollDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    NSLog(@"1");
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self calculateToSelectRowWithSuperView:scrollView];
    NSLog(@"2");
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if(!decelerate){
        
        [self calculateToSelectRowWithSuperView:scrollView];
    }
    
    NSLog(@"3");
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self cancelSelectRowWithSuperView:scrollView];
    NSLog(@"4");
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    [self cancelSelectRowWithSuperView:scrollView];
    NSLog(@"5");
}
- (void)calculateToSelectRowWithSuperView:(UIScrollView *)scrollView{
    
    CGFloat yOff = scrollView.contentOffset.y;
    int off = ((int)yOff-40)%40;
    int newYoff = 0;
    if(off>20){
        
        newYoff = (int)yOff+40-off;
        
    }else{
        newYoff = (int)yOff-off;
        
    }
    [scrollView setContentOffset:CGPointMake(0, newYoff) animated:YES];
    int index = (int)newYoff/40;
    UILabel *label = [scrollView viewWithTag:200+index];
    label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
    self.lastSelectKey = label.text;
    if(self.lastSelectKey){
        
         [self.resultArray replaceObjectAtIndex:scrollView.tag-100 withObject:@{@(index):self.lastSelectKey}];
    }
    [self reloadSubColunmWithLastScrollView:scrollView];
}
- (void)cancelSelectRowWithSuperView:(UIScrollView *)scrollView{
    
    CGFloat yOff = scrollView.contentOffset.y;
    int index = (int)yOff/40;
    UILabel *label = [scrollView viewWithTag:200+index];
    label.font = [UIFont systemFontOfSize:16];
}


#pragma mark - Action

- (void)cancleClick:(id)sender{
    
    [self removeFromSuperview];
    if([self.delegate respondsToSelector:@selector(cancleDidClick)]){
        
        [self.delegate cancleDidClick];
    }
    
}
- (void)confirmClick:(id)sender{
    
    
    [self.delegate confirmDidClickWithResult:self.resultArray];
    
}

- (void)bottomClick:(id)sender{
    
    
}

- (void)coverViewClick:(id)sender{
    
    [UIView animateWithDuration:0.2 animations:^{
        _coverView.alpha = 0;
        self.center = CGPointMake(self.center.x, self.center.y+self.frame.size.height);
    }completion:^(BOOL finished) {
        [_coverView removeFromSuperview];
        [self removeFromSuperview];
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
