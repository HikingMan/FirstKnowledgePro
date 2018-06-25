//
//  WheelPlayScrollView.h
//  TestWheelPlay
//
//  Created by teame的新imac on 17/4/28.
//  Copyright © 2017年 teame的新imac. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ImageTapClickBlock)(NSInteger index);

@interface WheelPlayScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,strong)UIPageControl *pageControl;

@property (nonatomic,copy)ImageTapClickBlock block;

-(id)initWithFrame:(CGRect)frame source:(NSMutableArray *)sourceArray;

@end
