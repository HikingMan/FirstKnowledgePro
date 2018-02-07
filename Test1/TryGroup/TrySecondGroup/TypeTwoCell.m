//
//  TypeTwoCell.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TypeTwoCell.h"
#import "TrySecondProtocol.h"
#import "TypeTwoModel.h"

@implementation TypeTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadCellWithSource:(id<TrySecondModelProtocol>)sourceModel{
    
    TypeTwoModel *model = sourceModel;
    
    [self.opTwoBut setTitle:[NSString stringWithFormat:@"一共有%ld",model.count] forState:UIControlStateNormal];
    
    self.opTwoLabel.text = [sourceModel showText];
    
    CGRect rect = self.opTwoLabel.frame;
    rect.size.height = [sourceModel getLableHeightWith:sourceModel];
    self.opTwoLabel.frame = rect;
    
    if(model.twoIsTap){
        
        self.opTwoBut.backgroundColor = [UIColor whiteColor];
    }else{
        
        self.opTwoBut.backgroundColor = [UIColor redColor];
    }
}
- (IBAction)butClicked:(id)sender {
    
    if(self.block){
        self.block(sender);
    }
}


@end
