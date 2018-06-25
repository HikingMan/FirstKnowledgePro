//
//  HL_PickerView.h
//  Test1
//
//  Created by Wang HongLu on 2018/3/6.
//  Copyright © 2018年 Wang Honglu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HL_PickerView;
@protocol HLPickerProtocol<NSObject>

@required

- (NSInteger)pickerColunmNum;


- (NSArray *)pickerView:(HL_PickerView *)picker rowSourceWithIndex:(NSInteger)colunmIndex lastSelectRowKey:(NSString *)lastrow;

- (void)confirmDidClickWithResult:(NSArray *)resultArray;

//index是0时，表示是距左边距
- (CGFloat)spaceWidthWithIndex:(NSInteger)colunmIndex;


- (CGFloat)rowWidthWithIndex:(NSInteger)colunmIndex;
@optional

- (void)cancleDidClick;


- (UIView *)behindViewWithIndex:(NSInteger)colunmIndex;


@end

@interface HL_PickerView : UIView

@property (nonatomic,assign)id<HLPickerProtocol> delegate;

@property (nonatomic,strong,readonly)NSMutableArray *resultArray;

@end
