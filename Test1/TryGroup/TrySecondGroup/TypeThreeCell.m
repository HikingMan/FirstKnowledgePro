//
//  TypeThreeCell.m
//  Test1
//
//  Created by Wang HongLu on 2017/10/26.
//  Copyright © 2017年 Wang Honglu. All rights reserved.
//

#import "TypeThreeCell.h"
#import "TrySecondModelProtocol.h"
#import "TypeThreeModel.h"

@implementation TypeThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)reloadCellWithSource:(id<TrySecondModelProtocol>)sourceModel{
    
    TypeThreeModel * model = sourceModel;
    
    [self.opThreeBut setTitle:model.name forState:UIControlStateNormal];
    
    self.opThreeLabel.text = [sourceModel showText];
    
    CGRect rect = self.opThreeLabel.frame;
    rect.size.height = [sourceModel getLableHeightWith:sourceModel];
    self.opThreeLabel.frame = rect;
    
    if(model.threeIsTap){
        
        self.opThreeBut.backgroundColor = [UIColor whiteColor];
    }else{
        
        self.opThreeBut.backgroundColor = [UIColor redColor];
    }
}
- (IBAction)butClicked:(id)sender {

    if(self.block){
        self.block(sender);
    }
    
}

@end
