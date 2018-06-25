//
//  WheelPlayScrollView.m
//  TestWheelPlay
//
//  Created by teame的新imac on 17/4/28.
//  Copyright © 2017年 teame的新imac. All rights reserved.
//

#import "WheelPlayScrollView.h"
#import "UIImageView+WebCache.h"


#define ALL_COUNT 3

@interface WheelPlayScrollView()

@property (nonatomic,strong)NSMutableArray *sourceArray;

@property (nonatomic,strong)NSTimer *pageTimer;

@property (nonatomic,assign)NSInteger currentIndex;

@end

@implementation WheelPlayScrollView



-(id)initWithFrame:(CGRect)frame source:(NSMutableArray *)sourceArray
{
    if(self=[super initWithFrame:frame])
    {
        self.sourceArray=sourceArray;
        self.currentIndex=0;
        [self loadSubViews];
    }
    return self;
}

-(void)loadSubViews
{
    
    [self setContentSize:CGSizeMake(self.bounds.size.width*ALL_COUNT, self.bounds.size.height)];
    self.pagingEnabled=YES;
    self.showsVerticalScrollIndicator=NO;
    self.showsHorizontalScrollIndicator=NO;
    self.delegate=self;
    


    
    
    for(int i=0;i<ALL_COUNT;i++)
    {
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i*self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        imageView.userInteractionEnabled=YES;
        [self addSubview:imageView];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[self.sourceArray objectAtIndex:(i-1+self.sourceArray.count)%self.sourceArray.count]]];
        imageView.tag=100+i;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [imageView addGestureRecognizer:tap];
        
        
    }
    
    
    
    self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake((self.bounds.size.width-20*self.sourceArray.count)/2, self.bounds.size.height-40-30, 20*self.sourceArray.count, 40)];
    self.pageControl.numberOfPages=self.sourceArray.count;
    self.pageControl.pageIndicatorTintColor=[UIColor whiteColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor cyanColor];
    self.pageControl.currentPage=0;
    self.pageControl.layer.cornerRadius=10;
//    [self addSubview:self.pageControl];
    [self.pageControl addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.pageTimer=[NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(pageGodown:) userInfo:nil repeats:YES];
    
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    
    if(_sourceArray.count==1)
    {
        self.scrollEnabled=NO;
        [self setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    
}
-(void)pageTurn:(UIPageControl *)pageControl
{
    _currentIndex=pageControl.currentPage;
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
}

-(void)imageClick:(UITapGestureRecognizer *)tap
{
    if(self.block)
    {
        self.block(_currentIndex);
    }
}
-(void)pageGodown:(NSTimer *)timer
{
    self.pageControl.currentPage=(self.pageControl.currentPage+1)%self.sourceArray.count;
    _currentIndex=self.pageControl.currentPage;
    
    
    [self reloadImage];
    
    [self setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:YES];
    
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.pageTimer setFireDate:[NSDate distantFuture]];
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGPoint offset=[self contentOffset];
    if(offset.x>1.5*self.bounds.size.width)
    {
        _currentIndex=(_currentIndex+1)%self.sourceArray.count;
    }
    else if(offset.x<self.bounds.size.width)
    {
        _currentIndex=(_currentIndex-1+self.sourceArray.count)%self.sourceArray.count;
    }
    [self reloadImage];

    [scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
    self.pageControl.currentPage=_currentIndex;
    
    [self.pageTimer setFireDate:[NSDate date]];
    
}

-(void)reloadImage
{
    UIImageView *midView=[self viewWithTag:101];
    [midView sd_setImageWithURL:[NSURL URLWithString:[self.sourceArray objectAtIndex:_currentIndex]]];
    
    UIImageView *leftView=[self viewWithTag:100];
    [leftView sd_setImageWithURL:[NSURL URLWithString:[self.sourceArray objectAtIndex:(_currentIndex-1+self.sourceArray.count)%self.sourceArray.count]]];
    
    UIImageView *rightView=[self viewWithTag:102];
    [rightView sd_setImageWithURL:[NSURL URLWithString:[self.sourceArray objectAtIndex:(_currentIndex+1)%self.sourceArray.count]]];
    
}
-(void)dealloc
{
    [_pageTimer invalidate];
    _pageTimer=nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
